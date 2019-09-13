//
//  ExamChartViewController.swift
//  ChartsExtension
//
//  Created by DoanDat Macbook2012 on 9/12/19.
//  Copyright © 2019 lushera. All rights reserved.
//

import UIKit
import ChartsExtension
class ExamChartViewController: UIViewController, ChartViewDelegate {

    @IBOutlet var barChartView: BarChartView!
    @IBOutlet weak var lineChartView: LineChartView!
    
    var chartType = 1
    
    //barchart
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
//        self.title = "Line Chart 1"
        barChartView.isHidden = chartType == 1
        lineChartView.isHidden = chartType != 1
        if chartType == 1 {
            lineChartView.delegate = self
            lineChartView.chartDescription?.enabled = false
            lineChartView.dragEnabled = false
            lineChartView.setScaleEnabled(false)
            lineChartView.pinchZoomEnabled = false
            lineChartView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
            examChartType1Setup()
        } else {
            barChartView.delegate = self
            barChartView.chartDescription?.enabled = false
            barChartView.dragEnabled = false
            barChartView.setScaleEnabled(false)
            barChartView.pinchZoomEnabled = false
            barChartView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
            examBarChartTypeSetup(type: chartType)
        }
    }
    
}

extension ExamChartViewController {
    //chart 1
    func examChartType1Setup() {
        // x-axis limit line
        
        lineChartView.xAxis.gridLineDashLengths = [5, 0]
        lineChartView.xAxis.gridLineDashPhase = 0
        
        let leftAxis = lineChartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.axisMaximum = 250
        leftAxis.axisMinimum = 0
        leftAxis.labelCount = 5
        leftAxis.gridLineDashLengths = [5, 0]
        leftAxis.gridColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        leftAxis.gridLineWidth = 1
        leftAxis.drawLimitLinesBehindDataEnabled = true
        leftAxis.valueFormatter = ExamAxisValueFormatter(chart: lineChartView, chartType: chartType, maxValue: 250)

        let xAxis = lineChartView.xAxis
        //        xAxis.removeAllLimitLines()
        //        xAxis.addLimitLine(ll1)
        //        xAxis.addLimitLine(ll2)
        xAxis.disableZeroValue = true
        xAxis.drawCirclesEnabled = true
        xAxis.circleRadius = 3
        xAxis.circleColor = NSUIColor.lightGray
        xAxis.extendRightAreaEnabled = true
        
        xAxis.axisMaximum = 11
        xAxis.axisMinimum = 0
        xAxis.labelCount = 11
        xAxis.gridLineDashLengths = [5, 0]
        xAxis.gridColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        xAxis.gridLineWidth = 1
        xAxis.drawLimitLinesBehindDataEnabled = true
        
        
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.enabled = true
        lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        //        chartView.axis.enabled = false
        
        //[_chartView.viewPortHandler setMaximumScaleY: 2.f];
        //[_chartView.viewPortHandler setMaximumScaleX: 2.f];
        
        let marker = BalloonMarker(color: UIColor(white: 1.0, alpha: 1),
                                   font: .systemFont(ofSize: 14),
                                   textColor: .red,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 10, right: 8), arrowSize: CGSize(width: 15, height: 11))
        marker.chartView = lineChartView
        marker.minimumSize = CGSize(width: 40, height: 40)
        marker.drawCirclesEnabled = false
        marker.circleRadius = 5.0
        marker.circleColor = UIColor.red
        lineChartView.marker = marker
        
        lineChartView.legend.form = .line
        lineChartView.legend.enabled = false

        self.setDataType1Count(10, range: 220)
        
        lineChartView.animate(xAxisDuration: 2.5)
    }
    
    func setDataType1Count(_ count: Int, range: UInt32) {
//        let values = [ChartDataEntry]()
        let values = [
            ChartDataEntry(x: 2, y: 90, icon: nil, iconHighlight: nil, colorHighlight: NSUIColor.red, data: "2133123231223 2019/12/23"),
            ChartDataEntry(x: 3, y: 20, icon: nil, iconHighlight: nil, colorHighlight: NSUIColor.red, data: "2133123231223 2019/12/23"),
            ChartDataEntry(x: 4, y: 50, icon: nil, iconHighlight: nil, colorHighlight: NSUIColor.red, data: nil),
            ChartDataEntry(x: 5, y: 120, icon: nil, iconHighlight: nil, colorHighlight: NSUIColor.red, data: "2133123231223 2019/12/23"),
            ChartDataEntry(x: 6, y: 90, icon: nil, iconHighlight: nil, colorHighlight: NSUIColor.red, data: "2133123231223 2019/12/23"),
            ChartDataEntry(x: 7, y: 190, icon: nil, iconHighlight: nil, colorHighlight: NSUIColor.red, data: "2133123231223 2019/12/23"),
            ChartDataEntry(x: 8, y: 200, icon: nil, iconHighlight: nil, colorHighlight: NSUIColor.red, data: "2133123231223 2019/12/23"),
            ChartDataEntry(x: 9, y: 98, icon: nil, iconHighlight: nil, colorHighlight: NSUIColor.red, data: "2133123231223 2019/12/23")
        ]
//        let values = [
//
//            ChartDataEntry(x: 2, y: 90.0, data: "2133123231223 2019/12/23", iconHighlight: UIColor.red),
//            ChartDataEntry(x: 3, y: 0.0, data: nil, iconHighlight: UIColor.red),
//            ChartDataEntry(x: 4, y: 45.0, data: "2133123231223 2019/12/23", iconHighlight: UIColor.red),
//            ChartDataEntry(x: 5, y: 120, data: "2133123231223 2019/12/23", iconHighlight: UIColor.red),
//            ChartDataEntry(x: 7, y: 190, data: "2133123231223 2019/12/23", iconHighlight: UIColor.red)
//        ]
        
        let set1 = LineChartDataSet(entries: values, label: "DataSet 1")
        set1.drawIconsEnabled = false
        set1.drawCirclesEnabled = true
        set1.lineDashLengths = [5, 0]
        set1.highlightLineDashLengths = [5, 2.5]
        set1.setColor(.white)
        set1.setCircleColor(.white)
        set1.circleRadius = 5.0
        set1.lineWidth = 2
        set1.drawCircleHoleEnabled = false
        set1.valueFont = .systemFont(ofSize: 14)
        set1.formLineDashLengths = [5, 2.5]
        set1.formLineWidth = 1
        set1.formSize = 15
        set1.drawValuesEnabled = false
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fillAlpha = 1
        set1.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
        set1.drawFilledEnabled = false
        
//        let data = LineChartData(dataSets: [set1,set2])
        let data = LineChartData(dataSet: set1)
        data.highlightEnabled = true
        lineChartView.data = data
    }
    
}

extension ExamChartViewController {
    //chart 2
    func examBarChartTypeSetup(type: Int) {
        // x-axis limit line
        
        barChartView.xAxis.gridLineDashLengths = [5, 0]
        barChartView.xAxis.gridLineDashPhase = 0
        
        barChartView.drawValueAboveBarEnabled = true
        let xAxis = barChartView.xAxis
        xAxis.drawCirclesEnabled = true
        xAxis.circleRadius = 3
        xAxis.circleColor = NSUIColor.lightGray
        xAxis.extendRightAreaEnabled = true
        
        xAxis.labelPosition = .bottom
        xAxis.axisMaximum = 11
        xAxis.axisMinimum = 0
        xAxis.labelCount = 11
        xAxis.gridLineDashLengths = [5, 0]
        xAxis.gridColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        xAxis.gridLineWidth = 1
        
        xAxis.drawLimitLinesBehindDataEnabled = true
        
        let leftAxis = barChartView.leftAxis
        if chartType == 2 {
//            let ll1 = ChartLimitLine(limit: 20, label: "Upper Limit")
//            ll1.lineWidth = 1
//            ll1.lineColor = UIColor.gray
//            ll1.lineDashLengths = [5, 0]
//            ll1.labelPosition = .topRight
//            ll1.drawLabelEnabled = false
//            ll1.valueFont = .systemFont(ofSize: 10)
            leftAxis.removeAllLimitLines()
//            leftAxis.addLimitLine(ll1)
            leftAxis.axisMaximum = 20
            leftAxis.axisMinimum = -20
            leftAxis.labelCount = 5
        } else if chartType == 3 {
//            let ll1 = ChartLimitLine(limit: maxValueDisplay, label: "Upper Limit")
//            ll1.lineWidth = 1
//            ll1.lineColor = UIColor.gray
//            ll1.lineDashLengths = [5, 0]
//            ll1.labelPosition = .topRight
//            ll1.drawLabelEnabled = false
//            ll1.valueFont = .systemFont(ofSize: 10)
            leftAxis.removeAllLimitLines()
//            leftAxis.addLimitLine(ll1)
            
            leftAxis.axisMaximum = maxValueDisplay
            leftAxis.axisMinimum = -leftAxis.axisMaximum
            leftAxis.labelCount = 4
            leftAxis.chartExamType3 = true
        } else if chartType == 4 {
//            let ll1 = ChartLimitLine(limit: 40, label: "Upper Limit")
//            ll1.lineWidth = 1
//            ll1.lineColor = UIColor.gray
//            ll1.lineDashLengths = [5, 0]
//            ll1.labelPosition = .topRight
//            ll1.drawLabelEnabled = false
//            ll1.valueFont = .systemFont(ofSize: 10)
            
            leftAxis.removeAllLimitLines()
//            leftAxis.addLimitLine(ll1)
            leftAxis.axisMaximum = 40
            leftAxis.axisMinimum = -20
            leftAxis.labelCount = 7
        }
        
        leftAxis.gridColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        leftAxis.gridLineWidth = 1
        leftAxis.gridLineDashLengths = [5, 0]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        leftAxis.valueFormatter = ExamAxisValueFormatter(chart: barChartView, chartType: chartType, maxValue: maxValueDisplay)
        
        barChartView.rightAxis.enabled = false
        barChartView.legend.enabled = false
        
        let marker = BalloonMarker(color: UIColor(white: 1.0, alpha: 1),
                                   font: .systemFont(ofSize: 14),
                                   textColor: .red,
                                   insets: UIEdgeInsets(top: 3, left: 8, bottom: 3, right: 8), arrowSize: CGSize(width: 15, height: 3))
        marker.chartView = barChartView
        marker.minimumSize = CGSize(width: 40, height: 25)
        marker.drawCirclesEnabled = false
        //        marker.circleRadius = 5.0
        //        marker.circleColor = UIColor.red
        barChartView.marker = marker
        barChartView.backgroundColor = NSUIColor(red: 238.0/255, green: 238.0/255, blue: 238.0/255, alpha: 1.0)
        
        self.setBarChartDataCount(10, range: 220)
        
        barChartView.animate(xAxisDuration: 2.5)
    }
    
    func setBarChartDataCount(_ count: Int, range: UInt32) {
        //        let values = [ChartDataEntry]()
        let values = [
            BarChartDataEntry(x: 1.0, y: 10, data: "2133123231223 2019/12/23"),
            BarChartDataEntry(x: 3.0, y: -10, data: "2133123231223 2019/12/23"),
            BarChartDataEntry(x: 4.0, y: -10, data: "2133123231223 2019/12/23"),
            BarChartDataEntry(x: 5.0, y: 10, data: "2133123231223 2019/12/23"),
        ]
        
        var arrColor = [
            NSUIColor.red,
            NSUIColor.black,
            NSUIColor.black,
            NSUIColor.red
        ]
        
        var set1: BarChartDataSet! = nil
        if let set = barChartView.data?.dataSets.first as? BarChartDataSet {
            set1 = set
            set1?.replaceEntries(values)
            barChartView.data?.notifyDataChanged()
            barChartView.notifyDataSetChanged()
        } else {
            set1 = BarChartDataSet(entries: values, label: "Data Set")
            set1.colors = arrColor
            set1.drawValuesEnabled = chartType == 3
            set1.valueFont = NSUIFont.systemFont(ofSize: 14)
            set1.barChart = true
            set1.highlightColor = NSUIColor.green
            
            let data = BarChartData(dataSet: set1)
            data.setValueFormatter(ExamValueFormatter())
            data.highlightEnabled = false
            data.barWidth = 0.5
            barChartView.data = data
            barChartView.fitBars = true
        }
        
        barChartView.setNeedsDisplay()
    }
    
}

