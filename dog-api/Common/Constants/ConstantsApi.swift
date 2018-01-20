//
//  ConstantsApi.swift
//  dog-api
//
//  Created by Magno C. Heck on 1/20/18.
//  Copyright © 2018 none. All rights reserved.
//

import Foundation

extension Constants.Api {

    static let baseURL: URL = URL(string: "https://dog.ceo")! //This will never fail
    static let apiURL: URL = baseURL.appendingPathComponent("api")

    static let breedsURL: URL = apiURL.appendingPathComponent("breeds/list")

    static func breedImagesURL(for breedName: String) -> URL {
        return apiURL.appendingPathComponent("/breed/\(breedName)/images")
    }
}
