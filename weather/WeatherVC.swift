//
//  WeatherVC.swift
//  weather
//
//  Created by James Dyer on 4/16/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {
    
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var tempatureLbl: UILabel!
    @IBOutlet weak var conditionImg: UIImageView!
    @IBOutlet weak var conditionDescLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var highLbl: UILabel!
    @IBOutlet weak var lowLbl: UILabel!
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var windDirectionLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var stateLbl: UILabel!
    
    var userWeather: Weather!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayLbl.text = weekDay(NSDate().dayOfWeek()!)
        let background = CAGradientLayer().blueColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, atIndex: 0)
        userWeather.downloadWeather { () -> () in
            self.updateUI()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        print(userWeather.zip)
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updateUI() {
        conditionImg.image = UIImage(named: "\(userWeather.conditionTxt.lowercaseString).png")
        tempatureLbl.text = userWeather.tempature
        highLbl.text = userWeather.high
        lowLbl.text = userWeather.low
        humidityLbl.text = userWeather.humidity
        conditionDescLbl.text = userWeather.conditionTxt.uppercaseString
        windSpeedLbl.text = userWeather.windSpeed
        windDirectionLbl.text = userWeather.windDirection
        cityLbl.text = userWeather.city
        stateLbl.text = userWeather.state
    }
    
    func weekDay(day: Int) -> String {
        switch day {
        case 1:
            return "SUNDAY"
        case 2:
            return "MONDAY"
        case 3:
            return "TUESDAY"
        case 4:
            return "WEDNESDAY"
        case 5:
            return "THURSDAY"
        case 6:
            return "FRIDAY"
        case 7:
            return "SATURDAY"
        default:
            return ""
        }
    }

}
