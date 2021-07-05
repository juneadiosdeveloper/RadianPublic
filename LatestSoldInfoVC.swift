//
//  LatestSoldInfoVC.swift
//  MyRadian Valuations
//
//  Created by Sagar Kalathil on 13/05/21.
//  Copyright © 2021 Disha Patel. All rights reserved.
//

import UIKit

class LatestSoldInfoVC: BaseVC {

    @IBOutlet var txtSoldLast12Months: TextFieldSpinner!
    @IBOutlet var txtLastListDate: TextFieldSpinner!
    @IBOutlet var txtFinalPrice: ReportDataTextField!
    
    @IBOutlet var txtOriginalListDate: TextFieldSpinner!
    @IBOutlet var txtOriginalPrice: ReportDataTextField!
    
    @IBOutlet var txtSaleDate: TextFieldSpinner!
    @IBOutlet var txtSalePrice: ReportDataTextField!
    
    @IBOutlet var txtDOM: ReportDataTextField!
    @IBOutlet var txtListBroker: ReportDataTextField!
    
    @IBOutlet var txtListCompany: ReportDataTextField!
    @IBOutlet var txtListPhone: ReportDataTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextFieldAction()
    }
    func setTextFieldAction() {
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtSoldLast12Months, strTitle: "Is sold in Last 12 months.")
        
        
        self.showCommonDatePicker(txtFld: txtOriginalListDate, strTitle: "Select original listed date.")
        
        self.showCommonDatePicker(txtFld: txtSaleDate, strTitle: "Select Sale date.")
        
        self.showCommonDatePicker(txtFld: txtLastListDate, strTitle: "Select last listed date.")
    }
    //MARK: IsValid Function
    /*
    func isValid()->Bool {
        if txtSoldLast12Months.getText().count == 0 {
            self.view.makeToast("Select whether property is sold in last 12 month.")
            return false
        }
        if txtLastListDate.getText().count == 0 {
            self.view.makeToast("Select last listed date.")
            return false
        }
        if txtFinalPrice.getText().count == 0 {
            self.view.makeToast("Enter final price.")
            return false
        }
        
        if txtOriginalListDate.getText().count == 0 {
            self.view.makeToast("Enter original list date.")
            return false
        }
        if txtFinalPrice.getText().count == 0 {
            self.view.makeToast("Enter final list price.")
            return false
        }
        
        
        if txtOriginalListDate.getText().count == 0 {
            self.view.makeToast("Select Original List Date.")
            return false
        }
        if txtOriginalPrice.getText().count == 0 {
            self.view.makeToast("Enter Original Price.")
            return false
        }
        
        if txtSaleDate.getText().count == 0 {
            self.view.makeToast("Enter sale date.")
            return false
        }
        if txtSalePrice.getText().count == 0 {
            self.view.makeToast("Enter sale Price.")
            return false
        }
        
        if txtDOM.getText().count == 0 {
            self.view.makeToast("Enter DOM.")
            return false
        }
        
        if txtListBroker.getText().count == 0 {
            self.view.makeToast("Enter Listing broker.")
            return false
        }
        if txtListCompany.getText().count == 0 {
            self.view.makeToast("Enter Listing company.")
            return false
        }
        
        
        if txtListPhone.getText().count == 0 {
            self.view.makeToast("Enter Listing Phone.")
            return false
        }
        
        return true
    }*/
    //MARK: Common Methods
    func showCommonDatePicker(txtFld: TextFieldSpinner, strTitle: String) {
        txtFld.addAction(for: .touchUpInside){ (txt) in
            let cal = NSCalendar.current
            let maxDate = cal.date(byAdding: .year, value: 100, to: Date())
            let minDate = cal.date(byAdding: .year, value: -100, to: Date())
            ActionSheetDatePicker.show(withTitle: strTitle, datePickerMode: .date, selectedDate: Date(), minimumDate: minDate, maximumDate: maxDate, doneBlock: { (actionsheetPicker, index, value) in
                let strValue = "\(index!)"
                let strDate = DateTimeFormatter.formattedDateConvetToString(dateString: strValue, currentFormat: Constants.dateFormat.pickerDateFormat.rawValue, convertFormat: Constants.dateFormat.txtFldDateFormat.rawValue)
                txtFld.setText(strValue: strDate ?? "")
            }, cancel: nil, origin: txtFld)
        }
    }
}
