//
//  ImageCache.swift
//  NewyorkTime
//
//  Created by Alok Sagar on 31/03/22.
//

import Foundation
import UIKit

extension UIImageView {
    private static var urlStore = [String:NSURL]() //To keep track of image download request ulr with unique identifier. This is usefull while loading images in reusable tableview cells
   
    
    //Function to Load image from url
    //It is async call
    func loadImageFrom(url:String,placeHolder:UIImage) {
        guard let nsURL = URL.init(string: url) as NSURL? else {
            self.image = placeHolder
            return
        }
        let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
        UIImageView.urlStore[tmpAddress] = nsURL
        self.image = nil
        self.startShimmerAnimation()
            ImageDownloader.shared.downloadImage(url: nsURL) { image,url  in
                DispatchQueue.main.async {
                    if UIImageView.urlStore[tmpAddress] == url {
                        self.image = image ?? placeHolder
                        self.stopShimmerAnimation()
                    }
                }
            }
    }
}
