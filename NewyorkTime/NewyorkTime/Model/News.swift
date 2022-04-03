//
//  News.swift
//  NewyorkTime
//
//  Created by Alok Sagar on 02/04/22.
//

import Foundation

struct News:Codable {
    var abstract:String?
    var snippet:String?
    var leadParagraph:String?
    var multimedia:[Multimedia]?
    var imageURL:String? {
        let serverReponseURL = multimedia?.filter {
            $0.type == "image"
        }.first?.url
        return APIConstants.IMAGE_BASE_URL + (serverReponseURL ?? "")
    }
    var headline:Headline?
    var date:String? //": "2021-11-17T10:02:46+0000
    var readableDateString : String {
        DateUtil.getFormatedDateString(from: date ?? "", to: .MMMdyyyy) ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case abstract,snippet,leadParagraph,multimedia,headline
        case date = "pub_date"
    }
    
    
}

