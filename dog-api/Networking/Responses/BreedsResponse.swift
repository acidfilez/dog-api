//
//  BreedImages.swift
//  dog-api
//
//  Created by Magno C. Heck on 1/20/18.
//  Copyright © 2018 none. All rights reserved.
//

import Foundation
import ObjectMapper

//This struct contains the complete response for the api call
struct BreedsResponse: Mappable {

    var images: [Breed] = []
    var status: String = ""

    init?(map: Map) {
        if let imagesStr: [String] = try? map.value("message") {
            self.images = imagesStr.map { Breed(imageUrl: $0) }
        }
    }

    mutating func mapping(map: Map) {
        status <- map["status"]
    }
}
