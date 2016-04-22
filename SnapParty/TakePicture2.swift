//
//  TakePicture2.swift
//  SnapParty
//
//  Created by Fhict on 21/04/16.
//  Copyright © 2016 Fhict. All rights reserved.
//

import UIKit

class TakePicture2: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var imagePicker: UIImagePickerController!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func TakePicture(sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
   func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        var currentImage: UIImageView!
     //  imageview.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        currentImage = UIImageView(image: info[UIImagePickerControllerOriginalImage] as? UIImage)
        myImageUploadRequest(currentImage)
    
    
    }
    
    func myImageUploadRequest(pickedImage: UIImageView)
    {
        
        let myUrl = NSURL(string: "https://www.maxvdwerf.nl/SnapParty/Photo.php");
        
        
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        let param = [
            "firstName"  : "Robin",
            "lastName"    : "Welten",
            "userId"    : "1"
        ]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(pickedImage.image!, 1)
        
        if(imageData==nil)  { return; }
        
        request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        
        
        //   myActivityIndicator.startAnimating();
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("****** response data = \(responseString!)")
            
            var err: NSError?
            do
            {
                var json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
               // let datastring = NSString(data: data!, encoding:NSUTF8StringEncoding)
                
               // print(datastring)
            }
            catch
            {
                
            }
            
            dispatch_async(dispatch_get_main_queue(),{
                //      self.myActivityIndicator.stopAnimating()
               pickedImage.image = nil;
            });
            
            /*
             if let parseJSON = json {
             var firstNameValue = parseJSON["firstName"] as? String
             println("firstNameValue: \(firstNameValue)")
             }
             */
            
        }
        
        task.resume()
        
    }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let currentDate = NSDate()
        
        let username = NSUserDefaults.standardUserDefaults().objectForKey("userName") as! String
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "MM-dd-yyyy-HH:mm"
        let convertedDate = dateFormatter.stringFromDate(currentDate)
        let filename = ("\(username)-\(convertedDate).jpg")
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    
    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    
    
}



extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
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
