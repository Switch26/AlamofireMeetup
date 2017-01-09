//
//  ViewController.swift
//  MeetupAlamofire
//
//  Created by Serguei Vinnitskii on 1/8/17.
//  Copyright © 2017 Serguei Vinnitskii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        URLSessionManager.searchMovies(forKeyword: "Matrix") { (jsonObject: [String : Any], error: APICallError?) in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    self.handleNetworkManagerErrors(networkManagerError: error!)
                    return
                }
                
                print("Returned JSON: \n \(jsonObject)")
            }
            
        }
        
    }

}

