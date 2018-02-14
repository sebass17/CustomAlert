//
//  ViewController.swift
//  LoadingIndicator
//
//  Created by Sebastián Méndez on 2/13/18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBAction func displayAlert(_ sender: UIButton) {
        let title = "Error"
        let text = "An error has ocurred in the DB, what do you want to do? An error has ocurred in the DB, what do you want to do?"
        let alert = AlertViewController.instance(title: title, text: text, image: #imageLiteral(resourceName: "error"))
        present(alert, animated: true, completion: nil)
    }
}
