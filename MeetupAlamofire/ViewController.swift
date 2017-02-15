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
                guard error == nil else {
                    
                    switch error! {
                    case .networkError(let networkErrorDescription):
                        let networkErrorAlert = UIAlertController.simpleAlert(withTitle: "Error", message: networkErrorDescription)
                        self.present(networkErrorAlert, animated: true, completion: nil)
                    case .serverError:
                        let serverErrorAlert = UIAlertController.simpleAlert(withTitle: "Error", message: "Server didn't respond")
                        self.present(serverErrorAlert, animated: true, completion: nil)
                    case .parsingJSONError:
                        break
                    }
                    
                    //self.handleNetworkManagerErrors(networkManagerError: error!)
                    return
                }
                self.textView.text = jsonObject.description
            }
        }
        
        AlamoFireManager.searchMovies(withKeyword: "Matrix") { jsonObject in
            DispatchQueue.main.async {
                print("Alamofire returned JSON: \n \(jsonObject)")
                let dictionary = jsonObject as! [String: Any]
                self.textView.text = dictionary.description
            }
        }
        
        AlamoFireManager.donwnloadFile { data in
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }
    }

}

