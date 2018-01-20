//
//  DogsWorker.swift
//  dog-api
//
//  Created by Magno C. Heck on 1/19/18.
//  Copyright © 2018 none. All rights reserved.
//

import Foundation

protocol DogsWorkerProtocol {
    func fetchDogs(response: @escaping (() throws -> ([Dog])) -> Void)
    func fetchImages(for dog: Dog, response: @escaping (() throws -> ([Breed])) -> Void)
}

class DogsWorker: DogsWorkerProtocol {
    let manager = ClientManager()

    func fetchDogs(response: @escaping (() throws -> ([Dog])) -> Void) {
        manager.getBreeds { (apiResponse) in
            switch apiResponse {
            case .success(let dogsResponse):
                let dogs = dogsResponse.breeds
                response { return dogs }
            case .failure(let error):
                response { throw error }
            }
        }
    }

    func fetchImages(for dog: Dog, response: @escaping (() throws -> ([Breed])) -> Void) {
        manager.getBreedImages(dog: dog) { (apiResponse) in
            switch apiResponse {
            case .success(let breedResponse):
                let images = breedResponse.images
                response { return images }
            case .failure(let error):
                response { throw error }
            }
        }
    }
}
