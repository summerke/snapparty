//
//  RegisterView.swift
//  SnapParty
//
//  Created by Fhict on 15/04/16.
//  Copyright © 2016 Fhict. All rights reserved.
//

import UIKit

class RegisterView: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var tbEmail: UITextField!
    @IBOutlet weak var tbPassword: UITextField!
    @IBOutlet weak var tbPasswordRepeat: UITextField!
    @IBOutlet weak var tbName: UITextField!
    @IBOutlet weak var tbDateOfBirth: UITextField!
    @IBOutlet weak var tbGender: UITextField!
    @IBOutlet weak var tbPhoneNumber: UITextField!

    // Function alertMessage
    func alertMessage(userMessage: String) {
        // Alert controller
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .Alert)
        
        // OK button
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil )
    }
    
    // Cancel button
    @IBAction func BtnCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Submit button
    @IBAction func BtnSubmit(sender: AnyObject) {
        
        let email = tbEmail.text
        let password = tbPassword.text
        let passwordRepeat = tbPasswordRepeat.text
        let name = tbName.text
        let dateOfBirth = tbDateOfBirth.text
        let gender = tbGender.text
        let phoneNumber = tbPhoneNumber.text
        
        // Check for empty fields
        if (email!.isEmpty || password!.isEmpty || passwordRepeat!.isEmpty || name!.isEmpty || dateOfBirth!.isEmpty || gender!.isEmpty || phoneNumber!.isEmpty) {
                alertMessage("All fields have to be filled!")
                return;
        }
        
        // Check if passwords match
        if(password != passwordRepeat) {
            alertMessage("Passwords do not match")
            return;
        }
        
        // Send user data to server side
        let myUrl = NSURL(string: "https://www.maxvdwerf.nl/SnapParty/userRegister.php")
        let request = NSMutableURLRequest(URL: myUrl!)
        request.HTTPMethod = "POST"
        
        let postString = "email=\(email!)&password=\(password!)&name=\(name!)"
        
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
                    
                    var isUserRegistered: Bool = false
                    if (resultValue == "Success") {
                        isUserRegistered = true
                    }
                    
                    var messageToDisplay: String = parseJSON["message"] as!String!
                    if (!isUserRegistered) {
                        messageToDisplay = parseJSON["message"] as! String!
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        let myAlert = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert)
                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {
                            action in self.dismissViewControllerAnimated(true, completion: nil)
                        }
                        
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                        
                    }
                        
                )}
                
            }
            catch { print(error)}
            
        }
        
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
