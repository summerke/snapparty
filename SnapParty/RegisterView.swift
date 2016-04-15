//
//  RegisterView.swift
//  SnapParty
//
//  Created by Fhict on 15/04/16.
//  Copyright © 2016 Fhict. All rights reserved.
//

import UIKit

class RegisterView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var tbEmail: UITextField!
    @IBOutlet weak var tbName: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var tbPhoneNumber: UITextField!
    @IBOutlet weak var tbPassword: UITextField!
    @IBOutlet weak var tbPasswordRepeat: UITextField!
     @IBOutlet weak var genderfield: UITextField!
    
    var pickOption = ["Male", "Female", "Other"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var pickerView = UIPickerView()
        
        pickerView.delegate = self
        
        genderfield.inputView = pickerView

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BtnRegister(sender: AnyObject) {
        let email = tbEmail.text;
        let name = tbName.text;
        let dateOfBirth = dateTextField.text;
        let phone = tbPhoneNumber.text;
        let gender = genderfield.text;
        let password = tbPassword.text;
        let passwordRepeat = tbPasswordRepeat.text;
        
        
        
        if (email == "" || name == "" || dateOfBirth == "" || phone == "" || gender == "" || password == "" || passwordRepeat == "") {
            alertMessage("All fields have to be filled!")
            return;
        }
        
        if (password != passwordRepeat) {
             alertMessage("Passwords do not match!")
            return;
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
   

    @IBAction func btnCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func alertMessage(userMessage: String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated: true, completion: nil );
    }
    
    @IBAction func textFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(RegisterView.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        
        
    }
    
    
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        dateTextField.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderfield.text = pickOption[row]
    }
    
    @IBAction func GenderField(sender: UITextView) {
        
        
    }
    
    
    
  

}
