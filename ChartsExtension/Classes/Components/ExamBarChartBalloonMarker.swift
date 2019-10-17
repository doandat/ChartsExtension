//
//  ExamBarChartBalloonMarker.swift
//  ChartsExtension
//
//  Created by DoanDat Macbook2012 on 10/17/19.
//

import Foundation

open class ExamBarChartBalloonMarker: BalloonMarker {
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        if let str = entry.dataArray?.first as? String {
            setLabel(str, entry)
        }
    }
}
