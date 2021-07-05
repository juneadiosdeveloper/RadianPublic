//
//  SubjectHistoryVC.swift
//  MyRadian Valuations
//
//  Created by Sagar Kalathil on 13/05/21.
//  Copyright © 2021 Sagar Kalathil. All rights reserved.
//

import UIKit

class SubjectHistoryVC: BaseVC {
    @IBOutlet var txtInpectionDate: TextFieldSpinner!
    @IBOutlet var txtInfoSource: TextFieldSpinner!
    @IBOutlet var txtPropertyType: TextFieldSpinner!
    @IBOutlet var txtApnNumber: ReportDataTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setAction()
    }
    func setAction() {
        
        txtInpectionDate.addAction(for: .touchUpInside) { (txt) in
            self.showDatePicker(sender: self.txtInpectionDate)
        }
        
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtInfoSource, strTitle: "Select Information Source")
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtPropertyType, strTitle: "Select Property Type")
        
    }
    
    
    func showDatePicker(sender: TextFieldSpinner) {
        let strTitle = "Select from date"
        let cal = NSCalendar.current
        let maxDate = cal.date(byAdding: .year, value: 100, to: Date())
        let minDate = cal.date(byAdding: .year, value: -100, to: Date())
        ActionSheetDatePicker.show(withTitle: strTitle, datePickerMode: .date, selectedDate: Date(), minimumDate: minDate, maximumDate: Date(), doneBlock: { (actionsheetPicker, index, value) in
            let strValue = "\(index!)"
            let strDate = DateTimeFormatter.formattedDateConvetToString(dateString: strValue, currentFormat: Constants.dateFormat.pickerDateFormat.rawValue, convertFormat: Constants.dateFormat.txtFldDateFormat.rawValue)
            sender.txtFld.text = strDate
        }, cancel: nil, origin: sender)
        
    }
    //Created function in order to set value from Spinner
    
    
    /*
    func isValid()->Bool {
        if txtInpectionDate.getText().count == 0 {
            self.view.makeToast("Select Date")
            return false
        }
        if txtInfoSource.getText().count == 0 {
            self.view.makeToast("Select Information Source")
            return false
        }
        if txtPropertyType.getText().count == 0 {
            self.view.makeToast("Select Property Type")
            return false
        }
        if txtApnNumber.getText().count == 0 {
            self.view.makeToast("Enter APN Number")
            return false
        }
       
        
        return true
    }*/
}
/*
extension SubjectHistoryVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Begineeee")
    }
}*/
