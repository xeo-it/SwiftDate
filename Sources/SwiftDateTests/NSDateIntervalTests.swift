//
//  NSDateIntervalTests.swift
//  SwiftDate
//
//  Created by Jeroen Houtzager on 21/02/16.
//  Copyright © 2016 Jeroen Houtzager. All rights reserved.
//
// https://github.com/Quick/Quick


import Quick
import Nimble
import SwiftDate

class NSDateIntervalSpec: QuickSpec {

    override func spec() {

        describe("NSDateInterval") {

            context("initialisation") {

                it("start & end") {
                    let startDate = NSDate(year: 2012, month: 3, day: 4)
                    let endDate = NSDate(year: 2012, month: 3, day: 5)

                    let dateInterval = NSDateInterval(start: startDate, end: endDate)
                    expect(dateInterval).toNot(beNil())
                    expect(dateInterval.start) == startDate
                    expect(dateInterval.end) == endDate
                }

                it("interval") {
                    let startDate = NSDate(year: 2012, month: 3, day: 4)
                    let interval = NSTimeInterval(24 * 60 * 60)

                    let dateInterval = NSDateInterval(start: startDate, interval: interval)
                    expect(dateInterval).toNot(beNil())
                    expect(dateInterval.start) == startDate
                    expect(dateInterval.interval) == interval
                }
            }

            context("equatable") {

                var interval: NSDateInterval!
                beforeEach {
                    interval = NSDateInterval(start: NSDate(), interval: 1.0)
                }

                it("should be unequal with unequal start dates") {
                    let interval2 = NSDateInterval(start: NSDate() - 5.minutes, end: interval.end)

                    expect(interval) != interval2
                }

                it("should be unequal with unequal end dates") {
                    let interval2 = NSDateInterval(start: interval.start, end: NSDate() + 5.minutes)

                    expect(interval) != interval2
                }

                it("should be equal with identic intervals") {
                    expect(interval) == interval
                }

                it("should be equal with equal intervals") {
                    let interval2 = interval

                    expect(interval) == interval2
                }

            }

            context("description") {

                it("should report proper description") {
                    let interval = NSDateInterval(start: NSDate(year: 2001, month: 1, day: 1),
                        end: NSDate(year: 2002, month: 1, day: 1))

                    expect(interval.description) == "2000-12-31 23:00:00 +0000 --> 2001-12-31 23:00:00 +0000"
                }

            }
        }
    }
}
