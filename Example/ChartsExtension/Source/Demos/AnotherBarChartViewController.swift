//
//  AnotherBarChartViewController.swift
//  ChartsDemo-iOS
//
//  Created by Jacob Christie on 2017-07-09.
//  Copyright © 2017 jc. All rights reserved.
//

import UIKit
import ChartsExtension

class AnotherBarChartViewController: DemoBaseViewController {
    
    @IBOutlet var chartView: BarChartView!
    @IBOutlet var sliderX: UISlider!
    @IBOutlet var sliderY: UISlider!
    @IBOutlet var sliderTextX: UITextField!
    @IBOutlet var sliderTextY: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Another Bar Chart"
        
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
        
        chartView.chartDescription?.enabled = true
        chartView.maxVisibleCount = 90
        chartView.pinchZoomEnabled = false
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = true
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.axisMaximum = 10
        xAxis.axisMinimum = 0
        xAxis.labelCount = 10
                
        chartView.legend.enabled = false
        
        sliderX.value = 10
        sliderY.value = 100
        self.slidersValueChanged(nil)
    }
    
    
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
//        self.setDataCount(Int(sliderX.value) + 1, range: Double(sliderY.value))
        self.setDataCount(7, range: Double(sliderY.value))
    }
    
    func setDataCount(_ count: Int, range: Double) {
        let yVals = (0..<count).map { (i) -> BarChartDataEntry in
            let mult = range + Double(i)
            var val = mult
            var newI = i
            if i == 5 {
                val = -mult
                newI = i-1
            }
            let barchart = BarChartDataEntry(x: Double(newI), y: val)
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
            set1.colors = ChartColorTemplates.vordiplom()
            set1.drawValuesEnabled = true
            
            let data = BarChartData(dataSet: set1)
            chartView.data = data
            chartView.fitBars = true
        }
        
        chartView.setNeedsDisplay()
    }
    
    override func optionTapped(_ option: Option) {
        super.handleOption(option, forChartView: chartView)
    }
    
    // MARK: - Actions
    @IBAction func slidersValueChanged(_ sender: Any?) {
        sliderTextX.text = "\(Int(sliderX.value))"
        sliderTextY.text = "\(Int(sliderY.value))"
        
        self.updateChartData()
    }
}
