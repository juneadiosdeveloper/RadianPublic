//
//  CurrentListingVC.swift
//  MyRadian Valuations
//
//  Created by Sagar Kalathil on 13/05/21.
//  Copyright © 2021 Disha Patel. All rights reserved.
//

import UIKit

class CurrentListingVC: BaseVC {

    @IBOutlet var txtListedLastMonth: TextFieldSpinner!
    @IBOutlet var txtCurrentlyListed: TextFieldSpinner!
    
    @IBOutlet var txtListedMultiple: TextFieldSpinner!
    
    
    
    
    
    @IBOutlet var txtFinalPrice: ReportDataTextField!
    @IBOutlet var txtOriginalListDate: TextFieldSpinner!
    
    @IBOutlet var txtOriginalListPrice: ReportDataTextField!
    
    @IBOutlet var txtDom: ReportDataTextField!
    @IBOutlet var txtListingBroker: ReportDataTextField!
    @IBOutlet var txtListingComp: ReportDataTextField!
    @IBOutlet var txtListingPhone: ReportDataTextField!
    @IBOutlet var txtIsListedSign: TextFieldSpinner!
    @IBOutlet var txtWhyNotSale: ReportDataTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setTextFieldAction()
    }
    
    func setTextFieldAction() {
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtListedLastMonth, strTitle: "Is Listed Last month.")
        
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtCurrentlyListed, strTitle: "Is currently listed.")
        
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtListedMultiple, strTitle: "Is listed multiple times.")
        
        
        
        self.showCommonDatePicker(txtFld: txtOriginalListDate, strTitle: "Select original listed date.")
        
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtIsListedSign, strTitle: "Is listed sign visible?")
        
    }
    
    //MARK: IsValid Function
    /*
    func isValid()->Bool {
        if txtListedLastMonth.getText().count == 0 {
            self.view.makeToast("Select is listed in last 12 month.")
            return false
        }
        if txtCurrentlyListed.getText().count == 0 {
            self.view.makeToast("Select currently listed")
            return false
        }
        if txtListedMultiple.getText().count == 0 {
            self.view.makeToast("Select whether property listed multiple times in 12 months.")
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
        if txtOriginalListPrice.getText().count == 0 {
            self.view.makeToast("Enter Original List Price.")
            return false
        }
        if txtDom.getText().count == 0 {
            self.view.makeToast("Enter DOM.")
            return false
        }
        if txtListingBroker.getText().count == 0 {
            self.view.makeToast("Enter Listing broker.")
            return false
        }
        if txtListingComp.getText().count == 0 {
            self.view.makeToast("Enter Listing company.")
            return false
        }
        
        
        if txtListingPhone.getText().count == 0 {
            self.view.makeToast("Enter Listing Phone.")
            return false
        }
        if txtIsListedSign.getText().count == 0 {
            self.view.makeToast("Select is listed Sign Visible")
            return false
        }
        if txtWhyNotSale.getText().count == 0 {
            self.view.makeToast("Enter reason for not selling Property.")
            return false
        }
        
        
        return true
    }*/
    //MARK: Common Methods
    func showCommonDatePicker(txtFld: TextFieldSpinner, strTitle: String) {
        txtFld.addAction(for: .touchUpInside){ (txt) in
            let cal = NSCalendar.current
            let maxDate = cal.date(byAdding: .year, value: 100, to: Date())
            ActionSheetDatePicker.show(withTitle: strTitle, datePickerMode: .date, selectedDate: Date(), minimumDate: Date(), maximumDate: maxDate, doneBlock: { (actionsheetPicker, index, value) in
                let strValue = "\(index!)"
                let strDate = DateTimeFormatter.formattedDateConvetToString(dateString: strValue, currentFormat: Constants.dateFormat.pickerDateFormat.rawValue, convertFormat: Constants.dateFormat.txtFldDateFormat.rawValue)
                txtFld.setText(strValue: strDate ?? "")
            }, cancel: nil, origin: txtFld)
        }
    }
}
