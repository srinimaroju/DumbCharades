//
//  MovieRequest.swift
//  DumbCharades
//
//  Created by Pavan on 7/23/21.
//

import Foundation

public enum Language: String {
    case hindi
    case english
    case telugu
}

extension Language: CustomStringConvertible {
    public var description: String {
        switch self {
            case .hindi: return "hi"
            case .english: return "en"
            case .telugu: return "te"
        }
    }
}
