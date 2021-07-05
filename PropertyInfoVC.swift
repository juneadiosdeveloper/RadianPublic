//
//  PropertyInfoVC.swift
//  MyRadian Valuations
//
//  Created by Sagar Kalathil on 13/05/21.
//  Copyright © 2021 Disha Patel. All rights reserved.
//

import UIKit

class PropertyInfoVC: BaseVC {

    @IBOutlet var chkBxAccessDenied: Checkbox!
    @IBOutlet var txtIsSubjVisible: TextFieldSpinner!
    
    
    @IBOutlet var txtPropertyVacant: TextFieldSpinner!
    @IBOutlet var txtWhoIsOccupant: TextFieldSpinner!
    @IBOutlet var txtSecured: TextFieldSpinner!
    @IBOutlet var txtView: TextFieldSpinner!
    @IBOutlet var txtHOAorOther: TextFieldSpinner!
    
    @IBOutlet var txtHOAName: ReportDataTextField!
    @IBOutlet var txtHOAPhone: ReportDataTextField!
    @IBOutlet var txtHOAPaymentTerm: TextFieldSpinner!
    
    @IBOutlet var txtHOAFees: ReportDataTextField!
    @IBOutlet var txtHOADuesCurrent: TextFieldSpinner!
    @IBOutlet var txtHOADeliquencyAmt: ReportDataTextField!
    
    
    @IBOutlet var chkBxInsurance: Checkbox!
    @IBOutlet var chkBxLandscaping: Checkbox!
    @IBOutlet var chkBxPool: Checkbox!
    @IBOutlet var chkBxGym: Checkbox!
    @IBOutlet var chkBxOthers: Checkbox!
    @IBOutlet var txtOthers: ReportDataTextField!
    
    
    @IBOutlet var txtGuestHouseSF: ReportDataTextField!
    @IBOutlet var txtGuestHouseBasementSF: ReportDataTextField!
    @IBOutlet var txtTaxes: ReportDataTextField!
    @IBOutlet var txtDeliquentTaxes: ReportDataTextField!
    
    
    @IBOutlet var txtBuyerType: TextFieldSpinner!
    @IBOutlet var txtOwner: ReportDataTextField!
    @IBOutlet var txtIsFinancing: TextFieldSpinner!
    @IBOutlet var txtImproveCondition: TextFieldSpinner!
   
    
    @IBOutlet var txtTitleLegalIssues: TextFieldSpinner!
    @IBOutlet var txtLegalDescription: ReportDataTextField!
    @IBOutlet var txtFinanceAvailDesc: ReportDataTextField!
    
    @IBOutlet var txtSpecialAssesAmt: ReportDataTextField!
    @IBOutlet var txtChildResiding: TextFieldSpinner!
    
    
   
    var arrInsuranceOptions = ["Insurance","Landscaping", "Pool", "Gym", "Other (Please Comment below)"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setTextFieldAction()
    }
    
    @IBAction func checkBoxValueChanged(sender: Checkbox) {
        
        if sender.tag == 4{
            enableDisableOtherField(isEnable: sender.checked)
        }
    }
    
    func enableDisableOtherField(isEnable: Bool) {
        txtOthers.isEnabled = isEnable
    }
    
    
    
    func setTextFieldAction() {
        
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtIsSubjVisible, strTitle: "Is subject Visible")
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtPropertyVacant, strTitle: "Property Vacant")
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtWhoIsOccupant, strTitle: "Who is occupant")
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtSecured, strTitle: "Secured")
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtView, strTitle: "View")
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtHOAorOther, strTitle: "HOA or Other")
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtSecured, strTitle: "Secured")
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtHOAPaymentTerm, strTitle: "HOA Payment term")
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtHOADuesCurrent, strTitle: "HOA Dues current")
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtBuyerType, strTitle: "Buyer Type")
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtIsFinancing, strTitle: "Secured")
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtImproveCondition, strTitle: "Improvement Condition")
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtTitleLegalIssues, strTitle: "Title Legal Issues")
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtChildResiding, strTitle: "Child Residing")
        
        setCheckBoxValue()
    }
    
    func setCheckBoxValue() {
        chkBxAccessDenied.checked = CommonFunctions.sharedInstance.getBoolFromString(str: CommonFunctions.sharedInstance.getValue(str: "AccessDenied"))
        
        let arrCheckBox = CommonFunctions.sharedInstance.getCheckBoxArray(str: "HOAInsurance")
        
        let strCheckBoxValue = CommonFunctions.sharedInstance.getValue(str: "HOAInsurance")
        
        
        if strCheckBoxValue.lowercased().contains(arrInsuranceOptions[0].lowercased()) {
            chkBxInsurance.checked = true
        }
        
        if strCheckBoxValue.lowercased().contains(arrInsuranceOptions[1].lowercased()) {
            chkBxLandscaping.checked = true
        }
        
        if strCheckBoxValue.lowercased().contains(arrInsuranceOptions[2].lowercased()) {
            chkBxPool.checked = true
        }
        
        if strCheckBoxValue.lowercased().contains(arrInsuranceOptions[3].lowercased()) {
            chkBxGym.checked = true
        }
        
        if strCheckBoxValue.lowercased().contains(arrInsuranceOptions[4].lowercased()) {
            chkBxOthers.checked = true
            enableDisableOtherField(isEnable: true)
            let arrFilter = arrCheckBox.filter({$0.Text == arrInsuranceOptions[4]})
            if arrFilter.count > 0 {
                txtOthers.setText(str: arrFilter[0].Value ?? "")
            }
        }else{
            chkBxOthers.checked = false
            enableDisableOtherField(isEnable: false)
            txtOthers.setText(str:"")
        }
        
        
        
        /*
        for i in arrInsuranceOptions {
            let arrFilter = arrCheckBox.filter({$0.Text == i})
            
            if arrFilter.count > 0  {
                let a = arrFilter[0].Selected ?? false ? true : false
                if i == "Insurance" {
                    chkBxInsurance.isSelected = a
                }else if i ==  "Landscaping" {
                    chkBxLandscaping.isSelected = a
                }else if i == "Pool" {
                    chkBxPool.isSelected = a
                }else if i == "Gym" {
                    chkBxGym.isSelected = a
                }else if i == "Other (Please Comment below)" {
                    chkBxOthers.isSelected = a
                    txtOthers.setText(str: arrFilter[0].Value ?? "")
                }
            }
        }*/
        
    }

    //MARK: IsValid Function
    func isValid()->Bool {
     
        /*
        if txtPropertyVacant.getText().count == 0 {
            self.view.makeToast("Select is listed in last 12 month.")
            return false
        }
        if txtWhoIsOccupant.getText().count == 0 {
            self.view.makeToast("Select currently listed")
            return false
        }
        if txtSecured.getText().count == 0 {
            self.view.makeToast("Select whether property listed multiple times in 12 months.")
            return false
        }
        
        if txtView.getText().count == 0 {
            self.view.makeToast("Select current list Date.")
            return false
        }
        if txtHOAorOther.getText().count == 0 {
            self.view.makeToast("Enter final list price.")
            return false
        }
        
        
        
        if txtHOAName.getText().count == 0 {
            self.view.makeToast("Enter DOM.")
            return false
        }
        if txtHOAPhone.getText().count == 0 {
            self.view.makeToast("Enter Listing broker.")
            return false
        }
        if txtHOAPaymentTerm.getText().count == 0 {
            self.view.makeToast("Enter Listing company.")
            return false
        }
        
        
        if txtHOAFees.getText().count == 0 {
            self.view.makeToast("Enter Listing Phone.")
            return false
        }
        if txtHOADuesCurrent.getText().count == 0 {
            self.view.makeToast("Select is listed Sign Visible")
            return false
        }
        if txtHOADeliquencyAmt.getText().count == 0 {
            self.view.makeToast("Enter reason for not selling Property.")
            return false
        }
        
        
        
        if txtHOAFees.getText().count == 0 {
            self.view.makeToast("Enter Listing Phone.")
            return false
        }
        if txtHOADuesCurrent.getText().count == 0 {
            self.view.makeToast("Select is listed Sign Visible")
            return false
        }
        if txtHOADeliquencyAmt.getText().count == 0 {
            self.view.makeToast("Enter reason for not selling Property.")
            return false
        }
    
        */
        
        if chkBxOthers.checked {
            if txtOthers.getText().count ==  0 {
                self.view.makeToast("Enter other reason.")
                return false
            }
        }
        
        return true
    }
    
    func getInsuranceValues() -> (String,Bool) {
        var arrStr = [String]()
        var otherReason = false
        if chkBxInsurance.checked {
            arrStr.append(arrInsuranceOptions[0])
        }
        if chkBxLandscaping.checked {
            arrStr.append(arrInsuranceOptions[1])
        }
        if chkBxPool.checked {
            arrStr.append(arrInsuranceOptions[2])
        }
        if chkBxGym.checked {
            arrStr.append(arrInsuranceOptions[3])
        }
        if chkBxOthers.checked {
            arrStr.append(arrInsuranceOptions[4])
            otherReason = true
        }
        
        let strInsurance = arrStr.joined(separator: ",")
        return (strInsurance, otherReason)
    }
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
