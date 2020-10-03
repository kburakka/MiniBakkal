//
//  UiViewControllerEx.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 3.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

typealias CompletionHandler = (_ success:Bool) -> Void

extension UIViewController {

    func showAlert(title: String, message: String?, completionHandler: CompletionHandler?){

        let alertController = UIAlertController(title: title, message: message ?? "", preferredStyle: .alert)

        let OKAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction!) in
            alertController.dismiss(animated: true, completion: {
                if let completionHandler = completionHandler{
                    completionHandler(true)
                }
            })
        }
        alertController.addAction(OKAction)

        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion:nil)
        }
    }
    
    func showDeleteAlert(title: String, message: String?, completionHandler: CompletionHandler?){

        let alertController = UIAlertController(title: title, message: message ?? "", preferredStyle: .alert)

        let DelAction = UIAlertAction(title: "Hayır", style: .default) { (action:UIAlertAction!) in
            alertController.dismiss(animated: true, completion: {
                if let completionHandler = completionHandler{
                    completionHandler(false)
                }
            })
        }
        
        let OKAction = UIAlertAction(title: "Evet", style: .destructive) { (action:UIAlertAction!) in
            alertController.dismiss(animated: true, completion: {
                if let completionHandler = completionHandler{
                    completionHandler(true)
                }
            })
        }
        alertController.addAction(DelAction)
        alertController.addAction(OKAction)

        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion:nil)
        }
    }
}
