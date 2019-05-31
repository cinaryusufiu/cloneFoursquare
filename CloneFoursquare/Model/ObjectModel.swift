//
//  ResponseModel.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 29.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import Foundation

struct ResponseArray : Codable {
    var venues : [Venue]?
}
struct ResponseModel :Codable {
    var venue : Venue?
}
struct ObjectModel<T:Codable>: Codable  {
    
    var dataApi : T?
    
    enum CodingKeys :String, CodingKey{
        case response
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dataApi = try? container.decode(T.self, forKey: .response)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dataApi, forKey: .response)
    }
}
