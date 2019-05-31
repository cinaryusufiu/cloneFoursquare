//
//  Venue.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 30.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import Foundation

struct Venue : Codable {
    let id : String
    var name : String
    var location : Location?
    var tips : Tip?
    var bestPhoto : Photo?
}
struct Location : Codable {
    var address : String?
    var state : String?
    var lat :Float?
    var lng : Float?
    var city : String?
    var formattedAddress : [String]?
    var country : String?
}
struct Tip : Codable {
    var count : Int?
    var groups : [Group]?
}
struct Photo : Codable {
    var prefix :  String
    var suffix : String
    var width : Int
    var height : Int
}
struct Group : Codable {
    var count : Int
    var items : [ItemGroup]
}
struct ItemGroup : Codable{
    var text : String?
}
