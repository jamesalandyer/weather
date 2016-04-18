//
//  ViewController.swift
//  weather
//
//  Created by James Dyer on 4/16/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var zipTxtFld: UITextField!
    
    var zipCheck: String!
    var zipCode: String!
    var userWeather: Weather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zipTxtFld.delegate = self
        submitBtn.layer.cornerRadius = 5.0
        
        let background = CAGradientLayer().blueColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, atIndex: 0)
        setTextField()
    }
    
    override func viewDidAppear(animated: Bool) {
        zipTxtFld.text = ""
    }

    @IBAction func submitBtnPressed(sender: AnyObject) {
        view.endEditing(true)
        if zipTxtFld.text?.characters.count == 5 {
            errorLbl.hidden = true
            zipCode = zipTxtFld.text
            zipCheck = "https://www.zipcodeapi.com/rest/vjLzWBXhYFa4hzjL4fMPknsRmklhUogpI1YECWVAB6ETFYEKdrzyP1qbmLtgaJGS/info.json/\(zipCode)/degrees"
            let url = NSURL(string: zipCheck)!
            Alamofire.request(.GET, url).responseJSON { response in
                let result = response.result
                if let dict = result.value as? Dictionary<String, AnyObject> {
                    if dict["error_code"] as? Int != nil {
                        self.errorLbl.hidden = false
                        self.errorLbl.text = "ERROR: THIS ZIP CODE DOES NOT EXIST"
                        self.zipTxtFld.text = ""
                    } else {
                        self.errorLbl.hidden = true
                        self.userWeather = Weather(zip: self.zipCode)
                        self.userWeather.state = states[(dict["state"] as? String)!]!
                        self.showWeather()
                    }
                }
            }
        } else {
            errorLbl.text = "ERROR: ENTER A VALID ZIP CODE"
            errorLbl.hidden = false
            zipTxtFld.text = ""
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "WeatherVC" {
            if let weatherVC = segue.destinationViewController as? WeatherVC {
                    weatherVC.userWeather = self.userWeather
            }
        }
    }
    
    func showWeather() {
        performSegueWithIdentifier("WeatherVC", sender: userWeather)
    }
    
    func setTextField() {
        zipTxtFld.keyboardType = UIKeyboardType.NumberPad
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let length = textField.text!.characters.count + string.characters.count
        
        if length > 5 {
            textFieldDidEndEditing(zipTxtFld)
            zipCode = textField.text
            return false
        } else {
            return true
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        zipTxtFld.resignFirstResponder()
    }
    

}

