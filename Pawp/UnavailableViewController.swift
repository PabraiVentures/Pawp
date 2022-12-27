//
//  UnavailableViewController.swift
//  Pawp
//
//  Created by Nathan Pabrai on 12/26/22.
//

import Foundation
import UIKit

class UnavailableViewController: UIViewController {
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "This tab isn't implemented, go to another tab."
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(label)
    }
    
     override func viewDidLayoutSubviews() {
         label.frame = view.frame
    }
    
}
