//
//  MonthYearPickerViewController.swift
//
//  Created by Ho Huyen Luong on 17/11/2022.
//

import Foundation
import UIKit

class MonthYearPickerViewController: UIViewController  {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var monthYearPickerView: MonthYearPickerView!
    
    private var minDate = MonthYear()
    private var maxDate = MonthYear()
    private var selectedDate = MonthYear()
    private var onDateSelected: ((_ month: Int, _ year: Int) -> Void)?
    
    lazy var blurredView: UIView = {
        // 1. create container view
        let containerView = UIView()
        // 2. create custom blur view
        let blurEffect = UIBlurEffect(style: .light)
        let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.0)
        customBlurEffectView.frame = CGRect(x: 0, y: -view.bounds.height - 100, width: view.bounds.width + 100, height: view.bounds.height + view.bounds.height)
        // 3. create semi-transparent black view
        let dimmedView = UIView()
        dimmedView.backgroundColor = .black.withAlphaComponent(0.3)
        dimmedView.frame = customBlurEffectView.frame
        
        // 4. add both as subviews
        containerView.addSubview(customBlurEffectView)
        containerView.addSubview(dimmedView)
        return containerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(blurredView)
        view.sendSubviewToBack(blurredView)
        monthYearPickerView.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 248.0/255.0, alpha: 1.0)
        monthYearPickerView.setMinDate(date: minDate)
        monthYearPickerView.setMaxDate(date: maxDate)
        monthYearPickerView.selectedDate(date: selectedDate)
        monthYearPickerView.commonSetup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self.view) else { return }
        if !contentView.frame.contains(location) {
            dismiss(animated: true)
        }
    }

    @IBAction func onDone(_ sender: Any) {
        onDateSelected?(monthYearPickerView.month, monthYearPickerView.year)
        dismiss(animated: true)
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    public static func present(vc: UIViewController, minDate: MonthYear, maxDate: MonthYear, selectedDate: MonthYear, onDateSelected: @escaping (Int, Int) -> ()) {
        let monthYearPickerViewController = MonthYearPickerViewController()
        monthYearPickerViewController.minDate = minDate
        monthYearPickerViewController.maxDate = maxDate
        monthYearPickerViewController.selectedDate = selectedDate
        monthYearPickerViewController.onDateSelected = onDateSelected
        
        monthYearPickerViewController.modalPresentationStyle = .overFullScreen
        vc.present(monthYearPickerViewController, animated: true)
    }
}
