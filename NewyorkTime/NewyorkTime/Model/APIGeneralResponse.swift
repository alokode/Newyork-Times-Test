//
//  APIGeneralResponse.swift
//  NewyorkTime
//
//  Created by Alok Sagar on 02/04/22.
//

import Foundation


struct APIGeneralResponse<T>:Decodable  where T : Codable {
    var status:String?
    var response: T?
    
    enum CodingKeys: String, CodingKey {
            case status
            case response
            case docs
    }
    
    init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decode(String.self, forKey: .status)
        let dictionary = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        response =  try dictionary.decode(T.self, forKey: .docs)
        }
}
