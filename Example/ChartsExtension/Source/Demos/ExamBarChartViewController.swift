//
//  ExamBarChartViewController.swift
//  ChartsExtension
//
//  Created by DoanDat Macbook2012 on 8/26/19.
//  Copyright © 2019 lushera. All rights reserved.
//

import UIKit
import ChartsExtension

class ExamBarChartViewController: DemoBaseViewController {
    
    @IBOutlet var chartView: BarChartView!
    
    let chartType = 3
    let maxValueChart3 = 19.0
    let labelPercentDisplay = 0.1
    var maxValueDisplay: Double {
        get {
//            return 30000.0
            return ceil(maxValueChart3*(1.0+labelPercentDisplay))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Exam Bar Chart"
        
        self.options = [.toggleValues,
                        .toggleHighlight,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .saveToGallery,
                        .togglePinchZoom,
                        .toggleData,
                        .toggleBarBorders]
        
        chartView.delegate = self
        
        chartView.chartDescription?.enabled = false
//        chartView.maxVisibleCount = 90
        chartView.pinchZoomEnabled = false
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = true
        let xAxis = chartView.xAxis
//        xAxis.drawCirclesEnabled = true
        xAxis.circleRadius = 3
//        xAxis.circleColor = NSUIColor.lightGray
//        xAxis.extendRightAreaEnabled = true
        
        xAxis.labelPosition = .bottom
        xAxis.axisMaximum = 11
        xAxis.axisMinimum = 0
        xAxis.labelCount = 11
        xAxis.gridColor = UIColor.gray
        xAxis.gridLineWidth = 1
        
        
        //        leftAxis.addLimitLine(ll2)
        let leftAxis = chartView.leftAxis
        if chartType == 2 {
            let ll1 = ChartLimitLine(limit: 20, label: "Upper Limit")
            ll1.lineWidth = 1
            ll1.lineColor = UIColor.gray
            ll1.lineDashLengths = [5, 0]
            ll1.labelPosition = .topRight
            ll1.drawLabelEnabled = false
            ll1.valueFont = .systemFont(ofSize: 10)
            leftAxis.removeAllLimitLines()
            leftAxis.addLimitLine(ll1)
            
            leftAxis.axisMaximum = 20
            leftAxis.axisMinimum = -20
            leftAxis.labelCount = 5
        } else if chartType == 3 {
            let ll1 = ChartLimitLine(limit: maxValueDisplay, label: "Upper Limit")
            ll1.lineWidth = 1
            ll1.lineColor = UIColor.gray
            ll1.lineDashLengths = [5, 0]
            ll1.labelPosition = .topRight
            ll1.drawLabelEnabled = false
            ll1.valueFont = .systemFont(ofSize: 10)
            leftAxis.removeAllLimitLines()
            leftAxis.addLimitLine(ll1)
            
            leftAxis.axisMaximum = maxValueDisplay
            leftAxis.axisMinimum = -leftAxis.axisMaximum
            leftAxis.labelCount = 4
//            leftAxis.chartExamType3 = true
        } else if chartType == 4 {
            let ll1 = ChartLimitLine(limit: 40, label: "Upper Limit")
            ll1.lineWidth = 1
            ll1.lineColor = UIColor.gray
            ll1.lineDashLengths = [5, 0]
            ll1.labelPosition = .topRight
            ll1.drawLabelEnabled = false
            ll1.valueFont = .systemFont(ofSize: 10)
            
            leftAxis.removeAllLimitLines()
            leftAxis.addLimitLine(ll1)
            
            leftAxis.axisMaximum = 40
            leftAxis.axisMinimum = -20
            leftAxis.labelCount = 7
        }
        
        leftAxis.gridColor = UIColor.gray
        leftAxis.gridLineWidth = 1
        leftAxis.gridLineDashLengths = [5, 0]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        leftAxis.valueFormatter = ExamAxisValueFormatter(chart: chartView, chartType: chartType, maxValue: maxValueDisplay)

        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
        
        let marker = BalloonMarker(color: UIColor(white: 1.0, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .red,
                                   insets: UIEdgeInsets(top: 3, left: 8, bottom: 3, right: 8), arrowSize: CGSize(width: 15, height: 3))
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 40, height: 25)
        marker.drawCirclesEnabled = false
//        marker.circleRadius = 5.0
//        marker.circleColor = UIColor.red
        chartView.marker = marker
        chartView.backgroundColor = NSUIColor(red: 238.0/255, green: 238.0/255, blue: 238.0/255, alpha: 1.0)
//        sliderX.value = 10
//        sliderY.value = 100
//        self.slidersValueChanged(nil)
        self.updateChartData()
    }
    
    
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
        //        self.setDataCount(Int(sliderX.value) + 1, range: Double(sliderY.value))
        self.setDataCount(11, range: Double(120))
    }
    
    func setDataCount(_ count: Int, range: Double) {
        var arrColor = [NSUIColor]()
        let yVals = (0..<count).map { (i) -> BarChartDataEntry in
            
            var val = i%2 == 1 ? maxValueDisplay/2 : -maxValueDisplay/2
            var newI = i
            arrColor.append(i%2 == 1 ? NSUIColor.red : NSUIColor.black)
            if i == 5 {
                val = maxValueChart3
                newI = i-1
            }
            
            if i == 0 {
                val = 12
            }
            let valueDisplay = i == 0 ? nil : "\(val)"
            let barchart = BarChartDataEntry(x: Double(newI), y: val, data: valueDisplay)
            
            //            let barchart = BarChartDataEntry(x: 5, y: -val)
            return barchart
        }
        
        var set1: BarChartDataSet! = nil
        if let set = chartView.data?.dataSets.first as? BarChartDataSet {
            set1 = set
            set1?.replaceEntries(yVals)
            chartView.data?.notifyDataChanged()
            chartView.notifyDataSetChanged()
        } else {
            set1 = BarChartDataSet(entries: yVals, label: "Data Set")
            set1.colors = arrColor
            set1.drawValuesEnabled = chartType == 3
            set1.valueFont = NSUIFont.systemFont(ofSize: 10)
            set1.barChart = true
            set1.highlightColor = NSUIColor.green
            
            let data = BarChartData(dataSet: set1)
            data.setValueFormatter(ExamValueFormatter())
            data.highlightEnabled = true
            data.barWidth = 0.5
            chartView.data = data
            chartView.fitBars = true
        }
        
        chartView.setNeedsDisplay()
    }
    
    override func optionTapped(_ option: Option) {
        super.handleOption(option, forChartView: chartView)
    }
    
    // MARK: - Actions
}
