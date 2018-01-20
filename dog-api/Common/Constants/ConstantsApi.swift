//
//  ConstantsApi.swift
//  dog-api
//
//  Created by Magno C. Heck on 1/20/18.
//  Copyright © 2018 none. All rights reserved.
//

import Foundation

extension Constants.Api {

    private static var host: String {
        return "dog.ceo"
    }

    private static var scheme: String {
        return "https://"
    }

    private static var basePath: String {
        return "api"
    }

    private static var apiUrl: String {
        return baseUrl +  "/" + basePath
    }

    static var baseUrl: String {
        return scheme + host
    }

    static var breedsList: String {
        return apiUrl + "/breeds/list"
    }

    static var breedImagesList: String {
        return apiUrl + "/breed/{name}/images"
    }
}
