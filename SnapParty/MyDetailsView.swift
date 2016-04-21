//
//  MyDetailsView.swift
//  SnapParty
//
//  Created by Max van der Werf on 21/04/16.
//  Copyright © 2016 Fhict. All rights reserved.
//

import UIKit

class MyDetailsView: UIViewController {
        

    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userName = NSUserDefaults.standardUserDefaults().objectForKey("userName") as! String
        self.emailLabel.text = userName
        
    }

}