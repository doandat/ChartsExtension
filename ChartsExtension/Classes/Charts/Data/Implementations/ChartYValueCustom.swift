//
//  ChartYValueCustom.swift
//  ChartsExtension
//
//  Created by DoanDat Macbook2012 on 9/3/19.
//  Copyright © 2019 lushera. All rights reserved.
//

import UIKit

open class ChartYValueCustom: NSObject {
    let value: Double
    let displayValue: String
    let colorYValue: NSUIColor
    let colorLine: NSUIColor
    let lineDashLengths: [CGFloat]
    let optional: Bool
    
    public init(value: Double, displayValue: String, colorYValue: NSUIColor, colorLine: NSUIColor, lineDashLengths: [CGFloat], optional: Bool) {
        self.value = value
        self.displayValue = displayValue
        self.colorYValue = colorYValue
        self.colorLine = colorLine
        self.lineDashLengths = lineDashLengths
        self.optional = optional
    }
}
