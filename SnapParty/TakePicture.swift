//
//  TakePicture.swift
//  SnapParty
//
//  Created by Fhict on 08/04/16.
//  Copyright © 2016 Fhict. All rights reserved.
//

import UIKit

class TakePicture: UIViewController {
  /*
    @IBOutlet weak var currentImage: UIImageView!
    // @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    
    @IBAction func BtnTakePicture(sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                presentViewController(imagePicker, animated: true, completion: {})
            } else {
                //   postAlert("Rear camera doesn't exist", message: "Application cannot access the camera.")
            }
        } else {
            //  postAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("Got an image")
        if let pickedImage:UIImage = (info[UIImagePickerControllerOriginalImage]) as? UIImage {
            let selectorToCall = Selector("imageWasSavedSuccessfully:didFinishSavingWithError:context:")
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, selectorToCall, nil)
             currentImage = UIImageView(image: pickedImage)
            
       
        }
        imagePicker.dismissViewControllerAnimated(true, completion: {
            // Anything you want to happen when the user saves an image
           self.myImageUploadRequest(self.currentImage)
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("User canceled image")
        dismissViewControllerAnimated(true, completion: {
            // Anything you want to happen when the user selects cancel
        })
    }
    
    func myImageUploadRequest(pickedImage: UIImageView)
    {
        
        let myUrl = NSURL(string: "https://www.maxvdwerf.nl/SnapParty/Photo.php");
        
        
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        let param = [
            "firstName"  : "Sergey",
            "lastName"    : "Kargopolov",
            "userId"    : "9"
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
            
        }
            catch
            {
                
            }
            
            dispatch_async(dispatch_get_main_queue(),{
          //      self.myActivityIndicator.stopAnimating()
                self.currentImage.image = nil;
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
        var body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        
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
    
//    func appendString(string: String) {
//        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
 //       appendData(data!)
 //   }

 */
 }
    
