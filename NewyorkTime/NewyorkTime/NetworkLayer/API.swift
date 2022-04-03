//
//  API.swift
//  NewyorkTime
//
//  Created by Alok Sagar on 02/04/22.
//

import Foundation

enum APIS {
    case articleSearch(page:Int)
    
    var baseURL:String{
        return APIConstants.BASE_URL
    }
    var endPoint:String {
        switch self {
        case .articleSearch:
            return APIConstants.ARTICLE_SEARCH_ENDPOINT
        }
    }
    var url : String {
        switch self {
        case .articleSearch:
            return baseURL+endPoint
        }
    }
    var httpMethod:String{
        switch self {
        case .articleSearch:
            return "get"
        }
    }
    
    var parameters:[String:Any] {
        var param : [String : Any] = [:]
        return param
    }
    
    var queryParams:[String:Any] {
        var param : [String : Any] = [:]
        if needToAppendAPIKey {
            param["api-key"] = APIConstants.API_KEY
        }
        switch self {
        case .articleSearch( let page):
            param["q"] = "india"
            param["page"] = page
        }
        return param
    }
    
    var needToAppendAPIKey : Bool {
        switch self {
        case .articleSearch(_):
            return true
        }
    }
    
    var urlComponents: URLComponents? {

        var urlComponents = URLComponents(string: self.url)
        if needToAppendAPIKey {
            urlComponents?.queryItems = [ URLQueryItem(name: "api-key", value: "\(APIConstants.API_KEY)") ]
        }
        
        switch self {
        case .articleSearch(let page):
            urlComponents?.queryItems?.append(URLQueryItem(name: "q", value: "india") )
            urlComponents?.queryItems?.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        return urlComponents
    }
}

///search/v2/articlesearch.json
