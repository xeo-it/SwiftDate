//
//  NSTimeIntervalTests.swift
//  SwiftDate
//
//  Created by Jeroen Houtzager on 22/02/16.
//  Copyright © 2016 Jeroen Houtzager. All rights reserved.
//

import Foundation
import Quick
import Nimble
import SwiftDate

class NSTimeIntervalSpec: QuickSpec {

    override func spec() {

        describe("NSTimeInterval") {

            context("fromNow") {
                it("should return the proper date") {
                    let now = NSDate()
                    let interval = NSTimeInterval(3600)
                    expect(interval.fromNow!) >= now + 1.hours
                    expect(interval.fromNow!) <= now + 1.hours + 1.seconds
                }
            }

            context("ago") {
                it("should return the proper date") {
                    let now = NSDate()
                    let interval = NSTimeInterval(3600)
                    expect(interval.ago!) >= now - 1.hours
                    expect(interval.ago!) <= now - 1.hours + 1.seconds
                }
            }

            context("toString") {
                it("should return the proper string for GMT time zone") {
                    let gmt = Region(timeZoneName: .Gmt)
                    let date = NSDate(year: 2011, month: 1, day: 1, region: gmt)
                    let interval = date.timeIntervalSinceReferenceDate
                    expect(interval.toString()) == "10y"
                }

                it("should return the proper string for non-GMT time zone without DST") {
                    let rome = Region(timeZoneName: .EuropeRome)
                    let date = NSDate(year: 2011, month: 1, day: 1, region: rome)
                    let interval = date.timeIntervalSinceReferenceDate
                    let style = FormatterStyle(units: [.Year, .Month, .Day, .Hour])
                    expect(interval.toString(style)) == "9y 11m 30d 23h"
                }

                it("should return the proper string for non-GMT time zone with DST") {
                    let rome = Region(timeZoneName: .EuropeRome)
                    let date = NSDate(year: 2011, month: 7, day: 1, region: rome)
                    let interval = date.timeIntervalSinceReferenceDate
                    let style = FormatterStyle(units: [.Year, .Month, .Day, .Hour])
                    expect(interval.toString(style)) == "10y 5m 27d 22h"
                }

            }
        }
    }
}
