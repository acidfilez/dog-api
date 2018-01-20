//
//  DogsResponse.swift
//  dog-api
//
//  Created by Magno C. Heck on 1/19/18.
//  Copyright © 2018 none. All rights reserved.
//

import Foundation
import ObjectMapper

//This struct contains the complete response for the api call
struct DogsResponse: Mappable {

    var breeds: [Dog] = []
    var status: String = ""

    init?(map: Map) {
        if let breedsStr: [String] = try? map.value("message") {
            self.breeds = breedsStr.map { Dog(breed: $0) }
        }
    }

    mutating func mapping(map: Map) {
        status <- map["status"]
    }
}
