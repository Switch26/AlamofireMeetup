//
//  AlamofireManager.swift
//  MeetupAlamofire
//
//  Created by Serguei Vinnitskii on 1/9/17.
//  Copyright © 2017 Serguei Vinnitskii. All rights reserved.
//

import UIKit
import Alamofire

struct AlamoFireManager {
    static func searchMovies(withKeyword keyword: String, completionHandler: @escaping (Any)-> Void) {
        
        let url = APIGlobalUrl + "?s=\(keyword)&y=&plot=&r=json"
        
        Alamofire.request(url).responseJSON { response in
            if let JSON = response.result.value {
                completionHandler(JSON)
            }
        }
    }
}


