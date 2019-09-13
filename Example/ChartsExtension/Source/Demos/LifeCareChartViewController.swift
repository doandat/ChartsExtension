//
//  LifeCareChartViewController.swift
//  ChartsExtension
//
//  Created by DoanDat Macbook2012 on 9/12/19.
//  Copyright © 2019 lushera. All rights reserved.
//

import UIKit
import ChartsExtension

class LifeCareChartViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet var barChartView: BarChartView!
    @IBOutlet weak var lineChartView: LineChartView!
    
    var isBGMChart = true
    
    //barchart
    var maxValueChart = 250.0
    let labelPercentDisplay = 0.1
    var maxValueDisplay: Double {
        get {
            //            return 30000.0
            return ceil(maxValueChart*(1.0+labelPercentDisplay))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //        self.title = "Line Chart 1"
        barChartView.isHidden = !isBGMChart
        lineChartView.isHidden = isBGMChart
        if isBGMChart {
            barChartView.delegate = self
            barChartView.chartDescription?.enabled = false
            barChartView.dragEnabled = false
            barChartView.setScaleEnabled(false)
            barChartView.pinchZoomEnabled = false
            barChartView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
            bgmBarChartSetup()
        } else {
            lineChartView.delegate = self
            lineChartView.chartDescription?.enabled = false
            lineChartView.dragEnabled = false
            lineChartView.setScaleEnabled(false)
            lineChartView.pinchZoomEnabled = false
            lineChartView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
            bpmChartSetup()
        }
    }
    
}

extension LifeCareChartViewController {
    //BPM chart
    func bpmChartSetup() {
        // x-axis limit line
        
        lineChartView.xAxis.gridLineDashLengths = [5, 0]
        lineChartView.xAxis.gridLineDashPhase = 0
        
        let leftAxis = lineChartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.axisMaximum = 205
        leftAxis.axisMinimum = 0
        leftAxis.gridLineDashLengths = [5, 0]
        leftAxis.gridColor = UIColor.gray
        leftAxis.gridLineWidth = 1
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        leftAxis.arrValueYAxis = [
            ChartYValueCustom(value: 0.0, displayValue: "0", colorYValue: NSUIColor.red, colorLine:NSUIColor.gray,  lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: 20.0, displayValue: "20", colorYValue: NSUIColor.gray, colorLine:NSUIColor.gray, lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: 60.0, displayValue: "60", colorYValue: NSUIColor.gray, colorLine:NSUIColor.gray, lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: 90.0, displayValue: "90", colorYValue: NSUIColor.gray, colorLine:NSUIColor.gray, lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: 140.0, displayValue: "140", colorYValue: NSUIColor.gray, colorLine:NSUIColor.gray, lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: 180.0, displayValue: "180", colorYValue: NSUIColor.red, colorLine:NSUIColor.gray, lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: 200.0, displayValue: "200", colorYValue: NSUIColor.red, colorLine:NSUIColor.gray, lineDashLengths: [CGFloat](), optional: false),

        ]
        
        let xAxis = lineChartView.xAxis
        //        xAxis.removeAllLimitLines()
        //        xAxis.addLimitLine(ll1)
        //        xAxis.addLimitLine(ll2)
        xAxis.disableZeroValue = true
        xAxis.drawCirclesEnabled = false
        xAxis.circleRadius = 3
        xAxis.circleColor = NSUIColor.lightGray
        xAxis.extendRightAreaEnabled = true
        xAxis.drawGridLinesEnabled = false
        
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
//        marker.circleColor = UIColor.red
        lineChartView.marker = marker
        
        lineChartView.legend.form = .line
        lineChartView.legend.enabled = false
        
        self.setDataBPM()
        
        lineChartView.animate(xAxisDuration: 2.5)
    }
    
    func setDataBPM() {
        //        let values = [ChartDataEntry]()
        let valuesSBP = [
            ChartDataEntry(x: 1.0, y: 10.0, icon: UIImage(named: "ic_he"), iconHighlight: UIImage(named: "ic_he_hl"), data: "2133123231223 2019/12/23"),
            ChartDataEntry(x: 2.0, y: 40.0, icon: UIImage(named: "ic_he"), iconHighlight: UIImage(named: "ic_he_hl"), data: "2133123231223 2019/12/23"),
            ChartDataEntry(x: 3.0, y: 70.0, icon: UIImage(named: "ic_he"), iconHighlight: UIImage(named: "ic_he_hl"), data: "2133123231223 2019/12/23"),
            ChartDataEntry(x: 5.0, y: 201.0, icon: UIImage(named: "ic_he"), iconHighlight: UIImage(named: "ic_he_hl"), data: "2133123231223 2019/12/23")

        ]
        let sbpDataSet = LineChartDataSet(entries: valuesSBP, label: "sbpDataSet 1")
        sbpDataSet.drawIconsEnabled = true
        sbpDataSet.drawCirclesEnabled = false
        sbpDataSet.lineDashLengths = [5, 0]
        sbpDataSet.highlightLineDashLengths = [5, 2.5]
        sbpDataSet.setColor(.white)
        sbpDataSet.setCircleColor(.white)
        sbpDataSet.circleRadius = 5.0
        sbpDataSet.lineWidth = 2
        sbpDataSet.drawCircleHoleEnabled = false
        sbpDataSet.valueFont = .systemFont(ofSize: 14)
        sbpDataSet.formLineDashLengths = [5, 2.5]
        sbpDataSet.formLineWidth = 1
        sbpDataSet.formSize = 15
        sbpDataSet.drawValuesEnabled = false
        sbpDataSet.fillAlpha = 1
        sbpDataSet.drawFilledEnabled = false
        
        ///DBP
        let valuesDBP = [
            ChartDataEntry(x: 1.0, y: 20.0, icon: UIImage(named: "ic_he"), iconHighlight: UIImage(named: "ic_he_hl"), data: "2133123231223 2019/12/23"),
            ChartDataEntry(x: 2.0, y: 40.0, icon: UIImage(named: "ic_he"), iconHighlight: UIImage(named: "ic_he_hl"), data: "2133123231223 2019/12/23"),
            ChartDataEntry(x: 3.0, y: 60.0, icon: UIImage(named: "ic_he"), iconHighlight: UIImage(named: "ic_he_hl"), data: "2133123231223 2019/12/23")
        ]
        let dbpDataSet = LineChartDataSet(entries: valuesDBP, label: "dbpDataSet 1")
        dbpDataSet.drawIconsEnabled = true
        dbpDataSet.drawCirclesEnabled = false
        dbpDataSet.lineDashLengths = [5, 0]
        dbpDataSet.highlightLineDashLengths = [5, 2.5]
        dbpDataSet.setColor(.white)
        dbpDataSet.setCircleColor(.white)
        dbpDataSet.circleRadius = 5.0
        dbpDataSet.lineWidth = 2
        dbpDataSet.drawCircleHoleEnabled = false
        dbpDataSet.valueFont = .systemFont(ofSize: 14)
        dbpDataSet.formLineDashLengths = [5, 2.5]
        dbpDataSet.formLineWidth = 1
        dbpDataSet.formSize = 15
        dbpDataSet.drawValuesEnabled = false
        dbpDataSet.fillAlpha = 1
        dbpDataSet.drawFilledEnabled = false
        
        //
        let valuesHeart = [
            ChartDataEntry(x: 1.0, y: 30.0, icon: UIImage(named: "ic_he"), iconHighlight: UIImage(named: "ic_he_hl"), data: "2133123231223 2019/12/23"),
            ChartDataEntry(x: 2.0, y: 50.0, icon: UIImage(named: "ic_he"), iconHighlight: UIImage(named: "ic_he_hl"), data: "2133123231223 2019/12/23"),
            ChartDataEntry(x: 3.0, y: 80.0, icon: UIImage(named: "ic_he"), iconHighlight: UIImage(named: "ic_he_hl"), data: "2133123231223 2019/12/23")
        ]
        let heartDataSet = LineChartDataSet(entries: valuesHeart, label: "heartDataSet 1")
        heartDataSet.drawIconsEnabled = true
        heartDataSet.drawCirclesEnabled = false
        heartDataSet.lineDashLengths = [5, 0]
        heartDataSet.highlightLineDashLengths = [5, 2.5]
        heartDataSet.setColor(.white)
        heartDataSet.setCircleColor(.white)
        heartDataSet.circleRadius = 5.0
        heartDataSet.lineWidth = 0
        heartDataSet.drawCircleHoleEnabled = false
        heartDataSet.valueFont = .systemFont(ofSize: 14)
        heartDataSet.formLineDashLengths = [5, 2.5]
        heartDataSet.formLineWidth = 1
        heartDataSet.formSize = 15
        heartDataSet.drawValuesEnabled = false
        heartDataSet.fillAlpha = 1
        heartDataSet.drawFilledEnabled = false
        
        let data = LineChartData(dataSets: [sbpDataSet, dbpDataSet, heartDataSet])
//        let data = LineChartData(dataSet: sbpDataSet)
        data.highlightEnabled = true
        lineChartView.data = data
    }
    
}

extension LifeCareChartViewController {
    //BGM chart
    func bgmBarChartSetup() {
        // x-axis limit line
        
        barChartView.xAxis.gridLineDashLengths = [5, 0]
        barChartView.xAxis.gridLineDashPhase = 0
        
        barChartView.drawValueAboveBarEnabled = true
        let xAxis = barChartView.xAxis
        xAxis.drawCirclesEnabled = false
        xAxis.circleRadius = 3
        xAxis.circleColor = NSUIColor.lightGray
        xAxis.extendRightAreaEnabled = true
        xAxis.drawGridLinesEnabled = false
        xAxis.disableZeroValue = true

        xAxis.labelPosition = .bottom
        xAxis.axisMaximum = 11
        xAxis.axisMinimum = 0
        xAxis.labelCount = 11
        xAxis.gridLineDashLengths = [5, 0]
        xAxis.gridColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        xAxis.gridLineWidth = 1
        
        xAxis.drawLimitLinesBehindDataEnabled = true
        
        let leftAxis = barChartView.leftAxis
        leftAxis.removeAllLimitLines()
        //            leftAxis.addLimitLine(ll1)
        
        leftAxis.axisMaximum = maxValueChart+15
        leftAxis.axisMinimum = 0
//        leftAxis.labelCount = 4
//        leftAxis.chartExamType3 = true
        
        leftAxis.gridColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        leftAxis.gridLineWidth = 1
        leftAxis.gridLineDashLengths = [5, 0]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        leftAxis.valueFormatter = BGMAxisValueFormatter(chart: barChartView, chartType: 0, maxValue: maxValueDisplay)
        leftAxis.arrValueYAxis = [
            ChartYValueCustom(value: 0.0, displayValue: "0", colorYValue: NSUIColor.red, colorLine:NSUIColor.gray,  lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: 70.0, displayValue: "70", colorYValue: NSUIColor.red, colorLine:NSUIColor.red, lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: 100.0, displayValue: "100", colorYValue: NSUIColor.gray, colorLine:NSUIColor.gray, lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: 126.0, displayValue: "126", colorYValue: NSUIColor.red, colorLine:NSUIColor.red, lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: 140.0, displayValue: "140", colorYValue: NSUIColor.gray, colorLine:NSUIColor.gray, lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: 200, displayValue: "200", colorYValue: NSUIColor.red, colorLine:NSUIColor.red, lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: 150, displayValue: "150", colorYValue: NSUIColor.black, colorLine:NSUIColor.black, lineDashLengths: [5,5], optional: true),
            ChartYValueCustom(value: maxValueChart, displayValue: "600", colorYValue: NSUIColor.gray, colorLine:NSUIColor.gray, lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: maxValueDisplay, displayValue: "\(maxValueDisplay)", colorYValue: NSUIColor.gray, colorLine:NSUIColor.gray, lineDashLengths: [CGFloat](), optional: false)
        ]

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
        
        self.setBarChartData()
        
        barChartView.animate(xAxisDuration: 2.5)
    }
    
    func setBarChartData() {
        //        let values = [ChartDataEntry]()
        let values = [
            BarChartDataEntry(x: 1.0, y: 10, data: "2133123231223 2019/12/23"),
            BarChartDataEntry(x: 3.0, y: 220, data: "2133123231223 2019/12/23"),
            BarChartDataEntry(x: 4.0, y: 120, data: "2133123231223 2019/12/23"),
            BarChartDataEntry(x: 5.0, y: 150, data: "2133123231223 2019/12/23"),
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
            set1.drawValuesEnabled = false
            set1.valueFont = NSUIFont.systemFont(ofSize: 14)
            set1.barChart = true
            set1.highlightColor = NSUIColor.clear
            
            let data = BarChartData(dataSet: set1)
            data.setValueFormatter(ExamValueFormatter())
            data.highlightEnabled = true
            data.barWidth = 0.5
            barChartView.data = data
            barChartView.fitBars = true
        }
        
        barChartView.setNeedsDisplay()
    }
    
}

