//
//  ViewController.swift
//  MonthYearPicker
//
//  Created by Ho Huyen Luong on 18/11/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var lbDate: UILabel!
    
    private var selectedDate = MonthYear()

    override func viewDidLoad() {
        super.viewDidLoad()
        let dateTap = UITapGestureRecognizer(target: self, action: #selector(showDatePicker))
        dateView.addGestureRecognizer(dateTap)
    }
    
    @objc private func showDatePicker() {
        let minDate = MonthYear()
        minDate.year -= 1
        let maxDate = MonthYear()
        maxDate.year += 1
        MonthYearPickerViewController.present(vc: self, minDate: minDate, maxDate: maxDate, selectedDate: selectedDate, onDateSelected: onDateSelected)
    }
    
    private func onDateSelected(month: Int, year: Int) {
        selectedDate = MonthYear(month: month, year: year)
        lbDate.text = formatMonthYear(date: selectedDate)
    }
    
    private func formatMonthYear(date: MonthYear) -> String {
        return date.month < 10 ? "0\(date.month)/\(date.year)" : "\(date.month)/\(date.year)"
    }
}

