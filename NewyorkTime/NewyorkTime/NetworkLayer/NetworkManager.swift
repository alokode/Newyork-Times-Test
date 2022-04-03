//
//  NetworkManager.swift
//  NewyorkTime
//
//  Created by Alok Sagar on 02/04/22.
//

import Foundation



enum APIError: Error {
    case invalidURL
    case unexpected(code: Int)
    case genericAPIError
}

class NetworkManager {
    static let sharedManager = NetworkManager.init()
    private init(){}
    func fetchData<T:Codable> (api:APIS,completion:@escaping (Result<T,Error>)->()){
        guard let url = api.urlComponents?.url else{
            completion(.failure(APIError.invalidURL))
            return
        }
        var request = URLRequest.init(url: url)
        request.httpMethod = api.httpMethod
        let urlConf = URLSessionConfiguration.default
        let session = URLSession.init(configuration: urlConf)
         session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    guard let responsedata = data else {completion(.failure(APIError.genericAPIError))
                        return
                    }
                    let str = String(decoding: responsedata, as: UTF8.self)
                    do {
                        //let jsonData = try JSONSerialization.jsonObject(with: responsedata, options: .mutableContainers)
                        let model = try JSONDecoder().decode(APIGeneralResponse<T>.self, from: data!)
                        if let modelResponse = model.response  {
                            completion(.success(modelResponse))
                        } else {
                            completion(.failure(APIError.genericAPIError))
                        }
                    
                    }catch let jsonError{
                        print(jsonError)
                        completion(.failure(APIError.genericAPIError))
                    }
                            
                } else {
                    completion(.failure(APIError.genericAPIError))
                }
            }
         }.resume()
    }
    
}
