//
//  AppConstant.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 29.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import Foundation

struct AppConstant {
    struct ApiKeyValue {
        static let client_id = ""
        static let client_secret = ""
        static let googleApiKey = "Your Api key"
        static let version = "20190516"
    }
    struct ApiKey {
        static let client_id = "client_id"
        static let client_secret = "client_secret"
        static let version = "v"
        static let query = "query"
    }
    struct NavigationBarTitle {
        static let navSearchController = "MainPage"
        static let navPlacesController = "Places"
    }
    struct URl {
        static let baseUrl =  "https://api.foursquare.com/v2/venues/"
        static let search = URl.baseUrl + "search"
    }
}
