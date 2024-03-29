//
//  ViewController.swift
//  UIkitViews
//
//  Created by Palliboina on 28/03/24.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var myTextView: UITextView!
    
    @IBOutlet weak var mypicker: UIPickerView!
    @IBOutlet weak var pickerViewLabel: UILabel!
    var years: [String]!
    var cities: [String]!
    
    var datePicker : UIDatePicker!
    
    @IBOutlet weak var datePickerLabel: UILabel!
    
    @IBAction func getDate(_ sender: UIButton) {
        let selectedDate = datePicker.date
        let format = selectedDate.formatted(date: .complete, time: .complete)
        datePickerLabel.text = format
    }
    
    @IBAction func changeColor(_ sender: UIButton) {
        if let text = myTextView.attributedText {
            if let attrText = try? AttributedString(text, including: \.uiKit) {
                print(text,attrText)
                if let range = Range(myTextView.selectedRange,in: attrText) {
                    var newText = attrText
                    newText[range].foregroundColor = UIColor.systemRed
                    myTextView.attributedText = NSAttributedString(newText)
                }
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return years.count
        }else {
            return cities.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return years[row]
        }else{
            return cities[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var year : String! = component == 0 ? years[row] : years[mypicker.selectedRow(inComponent: 0)]
        var city : String! = component == 1 ? cities[row] : cities[mypicker.selectedRow(inComponent: 1)]
        pickerViewLabel.text = "The Year and city: \(String(year)) and \(String(city))"
    }
    
    @IBAction func reset(_ sender: UIButton) {
        ///in oth component
        let yearIndex = mypicker.selectedRow(inComponent: 0)
        let cityIndex = mypicker.selectedRow(inComponent: 1)
        pickerViewLabel.text = "The selected Year&City is \(years[yearIndex]) and \(cities[cityIndex])"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        datePicker = UIDatePicker(frame: CGRect(x: 20, y: 500, width: 60, height: 60))
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .automatic
        view.addSubview(datePicker)
        
        datePickerLabel.adjustsFontSizeToFitWidth = true
        
        mypicker.delegate = self
        mypicker.dataSource = self
        years = ["1990","1991","1992","1993","1994","1995","1996"]
        cities = ["Goa","Kodaikonal","Hyderabad","Ameerpet","KPHB","JNTUH","Nizampet"]
        
        pickerViewLabel.adjustsFontSizeToFitWidth = true
        
        if let index = years.firstIndex(of: "1992") {
            mypicker.selectRow(index, inComponent: 0, animated: true)
        }
        if let index = cities.firstIndex(of: "Hyderabad") {
            mypicker.selectRow(index, inComponent: 1, animated: true)
        }
    }
    


}

