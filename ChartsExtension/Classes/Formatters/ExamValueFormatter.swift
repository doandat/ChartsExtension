//
//  ExamValueFormatter.swift
//  ChartsExtension
//
//  Created by DoanDat Macbook2012 on 8/27/19.
//  Copyright © 2019 lushera. All rights reserved.
//

import UIKit

public class ExamValueFormatter: NSObject, IValueFormatter {
    
    public func stringForValue(
        _ value: Double,
        entry: ChartDataEntry,
        dataSetIndex: Int,
        viewPortHandler: ViewPortHandler?) -> String {
        guard let valueDisplay = entry.data as? String else {
            return ""
        }
        return valueDisplay
    }
}
