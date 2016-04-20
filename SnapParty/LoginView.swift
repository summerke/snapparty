//
//  LoginView.swift
//  SnapParty
//
//  Created by Max van der Werf on 20/04/16.
//  Copyright © 2016 Fhict. All rights reserved.
//

import UIKit

class LoginView: UIViewController {
    
    @IBOutlet weak var tbEmail: UITextField!
    @IBOutlet weak var tbPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func LoginButton(sender: AnyObject) {
        
        let userEmail = tbEmail.text
        let userPassword = tbPassword.text
        
        // Cancel if email or password textfield is empty
        if(userEmail!.isEmpty || userPassword!.isEmpty) {
            return
        }
        
        // Send user data to server side
        let myUrl = NSURL(string: "https://www.maxvdwerf.nl/SnapParty/userLogin.php")
        let request = NSMutableURLRequest(URL: myUrl!)
        request.HTTPMethod = "POST";
        
        let postString = "email=\(userEmail!)&password=\(userPassword!)"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    let resultValue = parseJSON["status"] as! String!
                    print("result: \(resultValue)")
                    
                    if(resultValue == "Success") {
                        //Login is successfull
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
                        NSUserDefaults.standardUserDefaults().synchronize()
                    
                    }
                    
                }
                
            }
            catch { print(error)}
            
        }
        
        task.resume()
    }
}