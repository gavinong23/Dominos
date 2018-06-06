//
//  AnyCodable.swift
//  Dominos
//
//  Created by Gavin Ong on 6/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation


struct AnyCodable : Encodable {
    
    private let _encode: (Encoder) throws -> Void
    
    let base: Codable
    let codableType: AnyCodableType
    
    init<Base : Codable>(_ base: Base) {
        self.base = base
        self._encode = { try base.encode(to: $0) }
        self.codableType = AnyCodableType(type(of: base))
    }
    
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}

struct AnyCodableType {
    
    private let _decodeJSON: (JSONDecoder, Data) throws -> AnyCodable
    // repeat for other decoders...
    // (unfortunately I don't believe there's an easy way to make this generic)
    //
    
    let base: Codable.Type
    
    init<Base : Codable>(_ base: Base.Type) {
        self.base = base
        self._decodeJSON = { decoder, data in
            AnyCodable(try decoder.decode(base, from: data))
        }
    }
    
    func decode(from decoder: JSONDecoder, data: Data) throws -> AnyCodable {
        return try _decodeJSON(decoder, data)
    }
}
