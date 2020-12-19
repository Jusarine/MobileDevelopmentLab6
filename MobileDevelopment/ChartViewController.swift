//
//  ChartViewController.swift
//  MobileDevelopment
//
//  Created by Tatyana May on 12/19/20.
//  Copyright © 2020 Tatyana Gladka. All rights reserved.
//

import Charts
import Darwin
import UIKit

class ChartViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var lineChartView: UIView!
    @IBOutlet weak var pieChartView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawLineChart()
        drawPieChart()
        lineChartView.isHidden = false
        pieChartView.isHidden = true
    }

    @IBAction func segmentedControlPressed(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                lineChartView.isHidden = false
                pieChartView.isHidden = true
            case 1:
                pieChartView.isHidden = false
                lineChartView.isHidden = true
            default: break;
        }
    }
    
    func drawLineChart() {
        let lineChart = LineChartView()
        lineChart.frame = CGRect(x: 0,
                                 y: 0,
                                 width: self.lineChartView.frame.size.width,
                                 height: self.lineChartView.frame.size.width)
        lineChart.center = lineChartView.center
        lineChart.chartDescription?.text = nil
        
        var dataEntries: [ChartDataEntry] = []
        for x in stride(from: -6, through: 6, by: 0.1) {
            let y = pow(Darwin.M_E, x)
            let dataEntry = ChartDataEntry(x: x, y: y)
            dataEntries.append(dataEntry)
        }
       
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "y = e^x")
        lineChartDataSet.drawValuesEnabled = true
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.lineWidth = 3
        
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChart.data = lineChartData
        
        lineChartView.addSubview(lineChart)
        view.addSubview(lineChartView)
    }
    
    
    func drawPieChart() {
        let pieChart = PieChartView()
        pieChart.frame = CGRect(x: 0,
                                y: 0,
                                width: self.pieChartView.frame.size.width,
                                height: self.pieChartView.frame.size.width)
        pieChart.center = pieChartView.center
        pieChart.chartDescription?.text = nil
        
        let entries = [
            ChartDataEntry(x: Double(35), y: Double(35)),
            ChartDataEntry(x: Double(40), y: Double(40)),
            ChartDataEntry(x: Double(25), y: Double(25))
        ]
        
        let set = PieChartDataSet(values: entries, label: "Values")
        set.colors = [#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.9276446104, green: 0.8402231336, blue: 0.187943995, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)]
        
        pieChart.data = PieChartData(dataSet: set)
        pieChartView.addSubview(pieChart)
        view.addSubview(pieChartView)
    }
}
