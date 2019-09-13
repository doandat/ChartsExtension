//
//  ExamAxisValueFormatter.swift
//  ChartsExtension
//
//  Created by DoanDat Macbook2012 on 8/27/19.
//  Copyright © 2019 lushera. All rights reserved.
//

import UIKit

public class ExamAxisValueFormatter: NSObject, IAxisValueFormatter {
    var chartType: Int
    var maxValue: Double
    weak var chart: BarLineChartViewBase?
    let valueY = ["", "+", "", "-", ""]
    
    public init(chart: BarLineChartViewBase, chartType: Int, maxValue: Double) {
        self.chart = chart
        self.chartType = chartType
        self.maxValue = maxValue
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if chartType == 1 {
            if value == 0 {
                return ""
            } else {
                return "\(Int(value))"
            }
        } else if chartType == 2 {
            if value == 10 {
                return "+"
            } else if value == -10 {
                return "-"
            }
        } else if chartType == 3 {
            if value == maxValue/2 {
                return "+"
            } else if value == -maxValue/2 {
                return "-"
            }
        } else if chartType == 4 {
            if value == 30 {
                return "+++"
            } else if value == 20 {
                return "++"
            } else if value == 10 {
                return "+"
            } else if value == -10 {
                return "-"
            }
        }
        
//        return "\(value)"
        return ""
    }
}

