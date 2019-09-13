//
//  LineChart1ViewController.swift
//  ChartsDemo-iOS
//
//  Created by Jacob Christie on 2017-07-09.
//  Copyright © 2017 jc. All rights reserved.
//

import UIKit
import ChartsExtension

class LineChart1ViewController: DemoBaseViewController {

    @IBOutlet var chartView: LineChartView!
    @IBOutlet var sliderX: UISlider!
    @IBOutlet var sliderY: UISlider!
    @IBOutlet var sliderTextX: UITextField!
    @IBOutlet var sliderTextY: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Line Chart 1"
        self.options = [.toggleValues,
                        .toggleFilled,
                        .toggleCircles,
                        .toggleCubic,
                        .toggleHorizontalCubic,
                        .toggleIcons,
                        .toggleStepped,
                        .toggleHighlight,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .saveToGallery,
                        .togglePinchZoom,
                        .toggleAutoScaleMinMax,
                        .toggleData]
        
        chartView.delegate = self
        
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false

        // x-axis limit line
        let llXAxis = ChartLimitLine(limit: 5, label: "Index 10")
        llXAxis.lineWidth = 2
        llXAxis.lineDashLengths = [5, 5]
        llXAxis.labelPosition = .bottomRight
        llXAxis.valueFont = .systemFont(ofSize: 10)
        
        chartView.xAxis.gridLineDashLengths = [5, 0]
        chartView.xAxis.gridLineDashPhase = 0
//        chartView.xAxis.addLimitLine(llXAxis)
        
        let ll1 = ChartLimitLine(limit: 150, label: "Upper Limit")
        ll1.lineWidth = 4
        ll1.lineDashLengths = [5, 5]
        ll1.labelPosition = .topRight
        ll1.valueFont = .systemFont(ofSize: 10)
        
        let ll2 = ChartLimitLine(limit: -30, label: "Lower Limit")
        ll2.lineWidth = 4
        ll2.lineDashLengths = [5,5]
        ll2.labelPosition = .bottomRight
        ll2.valueFont = .systemFont(ofSize: 10)
        
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
//        leftAxis.addLimitLine(ll1)
//        leftAxis.addLimitLine(ll2)
        leftAxis.axisMaximum = 220
        leftAxis.axisMinimum = 0
        leftAxis.gridLineDashLengths = [5, 0]
        leftAxis.gridColor = UIColor.gray
        leftAxis.gridLineWidth = 1
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        leftAxis.arrValueYAxis = [
            ChartYValueCustom(value: 0.0, displayValue: "0", colorYValue: NSUIColor.red, colorLine:NSUIColor.gray,  lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: 70.0, displayValue: "70", colorYValue: NSUIColor.red, colorLine:NSUIColor.red, lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: 100.0, displayValue: "100", colorYValue: NSUIColor.gray, colorLine:NSUIColor.gray, lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: 126.0, displayValue: "126", colorYValue: NSUIColor.red, colorLine:NSUIColor.red, lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: 140.0, displayValue: "140", colorYValue: NSUIColor.gray, colorLine:NSUIColor.gray, lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: 200, displayValue: "200", colorYValue: NSUIColor.red, colorLine:NSUIColor.red, lineDashLengths: [CGFloat](), optional: false),
            ChartYValueCustom(value: 150, displayValue: "141", colorYValue: NSUIColor.black, colorLine:NSUIColor.black, lineDashLengths: [5,5], optional: true),
            ChartYValueCustom(value: 191, displayValue: "600", colorYValue: NSUIColor.gray, colorLine:NSUIColor.gray, lineDashLengths: [CGFloat](), optional: false)
        ]
        
        let xAxis = chartView.xAxis
//        xAxis.removeAllLimitLines()
//        xAxis.addLimitLine(ll1)
//        xAxis.addLimitLine(ll2)
        xAxis.disableZeroValue = true
//        xAxis.drawCirclesEnabled = true
        xAxis.circleRadius = 3
//        xAxis.circleColor = NSUIColor.lightGray
        xAxis.extendRightAreaEnabled = true
        
        xAxis.axisMaximum = 11
        xAxis.axisMinimum = 0
        xAxis.labelCount = 11
        xAxis.gridLineDashLengths = [5, 0]
        xAxis.gridColor = UIColor.gray
        xAxis.gridLineWidth = 1
        xAxis.drawLimitLinesBehindDataEnabled = true
        

        
        chartView.rightAxis.enabled = false
        chartView.xAxis.enabled = true
        chartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
//        chartView.axis.enabled = false
        
        //[_chartView.viewPortHandler setMaximumScaleY: 2.f];
        //[_chartView.viewPortHandler setMaximumScaleX: 2.f];

        let marker = BalloonMarker(color: UIColor(white: 1.0, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .red,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 10, right: 8), arrowSize: CGSize(width: 15, height: 11))
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 40, height: 40)
        marker.drawCirclesEnabled = false
        marker.circleRadius = 5.0
//        marker.circleColor = UIColor.red
        chartView.marker = marker
        
        chartView.legend.form = .line
        
        sliderX.value = 45
        sliderY.value = 200
        slidersValueChanged(nil)
        
        chartView.animate(xAxisDuration: 2.5)
    }

    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
        self.setDataCount(Int(sliderX.value), range: UInt32(sliderY.value))
    }

    func setDataCount(_ count: Int, range: UInt32) {
        let values = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            if i == 4 {
                return ChartDataEntry(x: Double(i), y: 0, data: nil)
//                return nil
            }
            
            return ChartDataEntry(x: Double(i), y: val, icon: UIImage(named: "ic_he"), iconHighlight: UIImage(named: "ic_he_hl"), data: "2133123231223 2019/12/23")
        }
        
        let set1 = LineChartDataSet(entries: values, label: "DataSet 1")
        set1.drawIconsEnabled = true
        set1.drawCirclesEnabled = false
        set1.lineDashLengths = [5, 0]
        set1.highlightLineDashLengths = [5, 2.5]
        set1.setColor(.white)
        set1.setCircleColor(.white)
        set1.circleRadius = 5.0
        set1.lineWidth = 0
        set1.drawCircleHoleEnabled = false
        set1.valueFont = .systemFont(ofSize: 9)
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
        
        ////////////
        let values2 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            if i == 4 {
                return ChartDataEntry(x: Double(i), y: 0, data: nil)
                //                return nil
            }
            
            return ChartDataEntry(x: Double(i), y: val, icon: UIImage(named: "ic_he_hl"), iconHighlight: UIImage(named: "ic_he"), data: "2133123231223 2019/12/23")
        }
        
        let set2 = LineChartDataSet(entries: values2, label: "DataSet 2")
        set2.drawIconsEnabled = true
        set2.drawCirclesEnabled = false
        set2.lineDashLengths = [5, 0]
        set2.highlightLineDashLengths = [5, 2.5]
        set2.setColor(.white)
        set2.setCircleColor(.white)
        set2.circleRadius = 5.0
        set2.lineWidth = 2
        set2.drawCircleHoleEnabled = false
        set2.valueFont = .systemFont(ofSize: 9)
        set2.formLineDashLengths = [5, 2.5]
        set2.formLineWidth = 1
        set2.formSize = 15
        set2.drawValuesEnabled = false
        let gradientColors2 = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient2 = CGGradient(colorsSpace: nil, colors: gradientColors2 as CFArray, locations: nil)!
        
        set2.fillAlpha = 1
        set2.fill = Fill(linearGradient: gradient2, angle: 90) //.linearGradient(gradient, angle: 90)
        set2.drawFilledEnabled = false
        
        /////////////
        
        let data = LineChartData(dataSets: [set1,set2])
//        let data = LineChartData(dataSet: set1)
        data.highlightEnabled = true
        chartView.data = data
    }
    
    override func optionTapped(_ option: Option) {
        switch option {
        case .toggleFilled:
            for set in chartView.data!.dataSets as! [LineChartDataSet] {
                set.drawFilledEnabled = !set.drawFilledEnabled
            }
            chartView.setNeedsDisplay()
            
        case .toggleCircles:
            for set in chartView.data!.dataSets as! [LineChartDataSet] {
                set.drawCirclesEnabled = !set.drawCirclesEnabled
            }
            chartView.setNeedsDisplay()
            
        case .toggleCubic:
            for set in chartView.data!.dataSets as! [LineChartDataSet] {
                set.mode = (set.mode == .cubicBezier) ? .linear : .cubicBezier
            }
            chartView.setNeedsDisplay()
            
        case .toggleStepped:
            for set in chartView.data!.dataSets as! [LineChartDataSet] {
                set.mode = (set.mode == .stepped) ? .linear : .stepped
            }
            chartView.setNeedsDisplay()
            
        case .toggleHorizontalCubic:
            for set in chartView.data!.dataSets as! [LineChartDataSet] {
                set.mode = (set.mode == .cubicBezier) ? .horizontalBezier : .cubicBezier
            }
            chartView.setNeedsDisplay()
            
        default:
            super.handleOption(option, forChartView: chartView)
        }
    }

    @IBAction func slidersValueChanged(_ sender: Any?) {
        sliderTextX.text = "\(Int(sliderX.value))"
        sliderTextY.text = "\(Int(sliderY.value))"
        
        self.updateChartData()
    }
}
