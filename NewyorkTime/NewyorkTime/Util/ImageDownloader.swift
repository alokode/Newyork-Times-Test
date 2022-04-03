//
//  ImageDownloader.swift
//  NewyorkTime
//
//  Created by Alok Sagar on 02/04/22.
//

import Foundation
import UIKit

class ImageDownloader {
    static let shared =  ImageDownloader()
    private init() {}
    private let cachedImages = NSCache<NSURL,UIImage>()
    private var completionHandlers = [NSURL: [(UIImage?,NSURL?) -> ()]]()

    final func downloadImage(url:NSURL, completion : @escaping ((_ image:UIImage?,_ url:NSURL?) -> ()) ) {
        if let cachedImage = cachedImages.object(forKey: url) {
            completion(cachedImage, url)
              return
        }
        if completionHandlers[url] != nil {
            completionHandlers[url]?.append(completion)
            return
        } else {
            completionHandlers[url] = [completion]
            
        }
        let dataTask = URLSession.init(configuration: .default)
        dataTask.dataTask(with: url as URL) {[weak self] (data, response, error) in
            guard let data = data ,
                    let image = UIImage.init(data: data),
                    let ws = self ,
                  let completionBlocks = ws.completionHandlers[url] else{
                      completion(nil, url)
                return
            }
            ws.cachedImages.setObject(image, forKey: url, cost: data.count)
            for block in completionBlocks {
                block(image,url)
            }
        }.resume()
        
    }
}
