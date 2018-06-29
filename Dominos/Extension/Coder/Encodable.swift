//
//  Encodable.swift
//  Dominos
//
//  Created by Gavin Ong on 27/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation

extension Encodable {
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
    
    
    var dictionary: [String: Any]? {
        
             //let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: [.mutableContainers])).flatMap { $0 as? [String: Any] }
    }
    

}
