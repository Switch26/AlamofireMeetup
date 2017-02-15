//
//  ViewController.swift
//  MeetupAlamofire
//
//  Created by Serguei Vinnitskii on 1/8/17.
//  Copyright © 2017 Serguei Vinnitskii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        URLSessionManager.searchMovies(forKeyword: "Matrix") { (jsonObject: [String : Any], error: APICallError?) in
            DispatchQueue.main.async {
                self.textView.text = jsonObject.description
                
            }
        }
        
        
        
    }

}

