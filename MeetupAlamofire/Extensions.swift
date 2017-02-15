//
//  Extensions.swift
//  MeetupAlamofire
//
//  Created by Serguei Vinnitskii on 2/15/17.
//  Copyright © 2017 Serguei Vinnitskii. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    class func simpleAlert(withTitle title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        alertController.addAction(OKAction)
        return alertController
    }
}


extension UIViewController {
    func handleNetworkManagerErrors(networkManagerError: APICallError) {
        
        switch networkManagerError {
        case .networkError(let networkErrorDescription):
            let networkErrorAlert = UIAlertController.simpleAlert(withTitle: "Error", message: networkErrorDescription)
            self.present(networkErrorAlert, animated: true, completion: nil)
        case .serverError:
            let serverErrorAlert = UIAlertController.simpleAlert(withTitle: "Error", message: "Server didn't respond")
            self.present(serverErrorAlert, animated: true, completion: nil)
        case .parsingJSONError:
            break
        }
    }
}
