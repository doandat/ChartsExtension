//
//  BGMAxisValueFormatter.swift
//  ChartsExtension
//
//  Created by DoanDat Macbook2012 on 8/27/19.
//  Copyright © 2019 lushera. All rights reserved.
//

import UIKit

public class BGMAxisValueFormatter: NSObject, IAxisValueFormatter {
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
        return "\(value)"
    }
}
