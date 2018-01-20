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

    func get<T: Mappable>(_ type: T.Type, url: URLConvertible, onSuccess: @escaping ((Result<T>) -> Void)) {
        request(type, url: url, method: .get, validStatusCodes: [200], onSuccess: onSuccess)
    }
}

//This extension handles the api calls
extension ClientManager {

    /// Get a list of breeds from the server
    ///
    /// - Parameter response: A closure for async response with a Result instance with a DogsResponse instance or an Error
    func getBreeds(response: @escaping (Result<DogsResponse>) -> Void) {
        let url = Constants.Api.breedsURL

        get(DogsResponse.self, url: url) { (result) in
            response(result)
        }
    }

    /// Get a list of images for the specific breed from the server
    ///
    /// - Parameters:
    ///   - dog: The dog with the breed to get the images from
    ///   - response: A closure for async response with a Result instance with a DogsResponse instance or an Error
    func getBreedImages(dog: Dog, response: @escaping (Result<BreedsResponse>) -> Void) {
        let url = Constants.Api.breedImagesURL(for: dog.breed)

        get(BreedsResponse.self, url: url) { (result) in
            response(result)
        }
    }
}
