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
                        let networkErrorAlert = self.simpleAlert(withTitle: "Error", message: networkErrorDescription)
                        self.present(networkErrorAlert, animated: true, completion: nil)
                    case .serverError:
                        let serverErrorAlert = self.simpleAlert(withTitle: "Error", message: "Server didn't respond")
                        self.present(serverErrorAlert, animated: true, completion: nil)
                    case .parsingJSONError:
                        break
                    }
                    return
                }
                self.textView.text = jsonObject.description
            }
        }
        
        
    }

    
    func simpleAlert(withTitle title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        alertController.addAction(OKAction)
        return alertController
    }
}

