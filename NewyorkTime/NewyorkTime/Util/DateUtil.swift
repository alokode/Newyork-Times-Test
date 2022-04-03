//
//  DateUtil.swift
//  NewyorkTime
//
//  Created by Alok Sagar on 03/04/22.
//

import Foundation
import UIKit

enum DateFormatType:String {
    case yyMMddTHHmmssZ = "yyyy-MM-dd'T'HH:mm:ssZ"
    case MMMdyyyy = "MMM d, yyyy"
}

class DateUtil {
    static func getFormatedDateString(from dateString:String,to format:DateFormatType) -> String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatType.yyMMddTHHmmssZ.rawValue
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: date ?? Date())
    }
}
