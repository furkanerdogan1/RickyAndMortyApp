//
//  Service.swift
//  RickyAndMortyApp
//
//  Created by Furkan Erdoğan on 11.04.2023.
//

import Foundation
import Combine

class Service {

    static let shared = Service()

    func getLocations(_ index: Int) -> AnyPublisher<LocationSchema, Error> {
        guard let url = URL(string: "https://rickandmortyapi.com/api/location?page=0") else {
            return Fail(error: "Unable to generate url" as! Error).eraseToAnyPublisher()
        }
        return Future { promise in
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                DispatchQueue.main.async {
                    do {
                        guard let data = data else {
                            return promise(.failure("Something went wrong" as! Error))
                        }
                        let users = try JSONDecoder().decode(LocationSchema.self, from: data)
                        print("Başarılı location")
                        return promise(.success(users))
                    } catch let error {
                        print("ErrorLocations: \(error.localizedDescription)")
                        return promise(.failure(error))
                    }
                }
            }.resume()
        }.eraseToAnyPublisher()
    }
    
    func getCharactersID() -> AnyPublisher<[LocationSchemaResult], Error> {
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/1") else {
            return Fail(error: "Unable to generate url" as! Error).eraseToAnyPublisher()
        }
        
        print("Url: \(url)")
        return Future { promise in
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                DispatchQueue.main.async {
                    do {
                        guard let data = data else {
                            return promise(.failure("Something went wrong" as! Error))
                        }
                        let users = try JSONDecoder().decode([LocationSchemaResult].self, from: data)
                        print("Başarılı location Id")
                        return promise(.success(users))
                    } catch let error {
                        print("Errorv: \(error.localizedDescription)")
                        return promise(.failure(error))
                    }
                }
            }.resume()
        }.eraseToAnyPublisher()
    }
    
    func getCharacters(chractersID: [String]) -> AnyPublisher<[Character], Error> {
        let join = chractersID.joined(separator: "%2C")
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/\(join)") else {
            return Fail(error: "Unable to generate url" as! Error).eraseToAnyPublisher()
        }
        
        print("Url: \(url)")
        return Future { promise in
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                DispatchQueue.main.async {
                    do {
                        guard let data = data else {
                            return promise(.failure("Something went wrong" as! Error))
                        }
                        let users = try JSONDecoder().decode([Character].self, from: data)
                        print("Başarılı karakter")
                        return promise(.success(users))
                    } catch let error {
                        print("Errorv: \(error.localizedDescription)")
                        return promise(.failure(error))
                    }
                }
            }.resume()
        }.eraseToAnyPublisher()
    }
}
