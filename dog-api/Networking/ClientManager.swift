//
//  ClientManager.swift
//  dog-api
//
//  Created by Magno C. Heck on 1/19/18.
//  Copyright © 2018 none. All rights reserved.
//

import Foundation

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class ClientManager {

    //Alamofire settings goes here
    fileprivate let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = TimeInterval(90)

        return SessionManager(configuration: configuration)
    }()

    //Awsome Alamofire with ObjectMapper, with generics Return
    fileprivate func request<T: Mappable>(_ type: T.Type, url: URLConvertible,
                                          method: HTTPMethod,
                                          parameters: Parameters? = nil,
                                          encoding: ParameterEncoding = URLEncoding.default,
                                          headers: HTTPHeaders? = nil,
                                          validStatusCodes: [Int],
                                          onSuccess: @escaping ((Result<T>) -> Void)) {
        sessionManager
            .request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate(statusCode: validStatusCodes)
            .responseObject { (data: DataResponse<T>) in
                //TODO: handle validStatsCodes, if doesnt contains return error
                onSuccess(data.result)
        }
    }
}

//This extension handles the api calls
extension ClientManager {

    //This method gets dogs breeds
    func getBreeds(response: @escaping (Result<DogsResponse>) -> Void) {
        let url = URL(string: Constants.Api.breedsList)!

        request(DogsResponse.self, url: url, method: .get, validStatusCodes: [200]) { (result) in
            //TODO: handle status = false
            response(result)
        }
    }

    //This method gets all the images of a breed.
    func getBreedImages(dog: Dog, response: @escaping (Result<BreedsResponse>) -> Void) {
        let path = Constants.Api.breedImagesList.replacingOccurrences(of: "{name}", with: dog.breed)
        let url = URL(string: path)!

        request(BreedsResponse.self, url: url, method: .get, validStatusCodes: [200]) { (result) in
            //TODO: handle status = false
            response(result)
        }
    }
}
