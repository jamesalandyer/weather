//
//  NSDateExtension.swift
//  weather
//
//  Created by James Dyer on 4/17/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import Foundation

extension NSDate {
    func dayOfWeek() -> Int? {
        if
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components(.Weekday, fromDate: self) {
            return comp.weekday
        } else {
            return nil
        }
    }
}