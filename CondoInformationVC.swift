//
//  CondoInformationVC.swift
//  MyRadian Valuations
//
//  Created by Sagar Kalathil on 02/06/21.
//  Copyright © 2021 Disha Patel. All rights reserved.
//

import Foundation
class CondoInformationVC: BaseVC {
    @IBOutlet var txtNumberOfUnits: ReportDataTextField!
    @IBOutlet var txtUnitsRented: ReportDataTextField!
    @IBOutlet var txtUnitsForSale: ReportDataTextField!
    @IBOutlet var txtConverted: TextFieldSpinner!
    @IBOutlet var txtNoHOAReason: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        txtNoHOAReason.layer.cornerRadius = 8.0
        txtNoHOAReason.layer.masksToBounds = true
        txtNoHOAReason.layer.borderColor = Constants.Colors.slightDarkGray.cgColor
        txtNoHOAReason.layer.borderWidth = 1.0
        
        setAction()
    }
    func setAction() {
        CommonFunctions.sharedInstance.showCommonPicker(txtFld: txtConverted, strTitle: "Select Converted")
        
        
        let arrOptions = CommonFunctions.sharedInstance.getOptions(str: "NoHoaComment")
        txtNoHOAReason.text = arrOptions.Value ?? ""
        
        
    }
    
    
    //Created function in order to set value from Spinner
    func isValid()->Bool {
        if txtNumberOfUnits.getText().count == 0 {
            self.view.makeToast("Enter number of units in complex")
            return false
        }
        if txtUnitsRented.getText().count == 0 {
            self.view.makeToast("Enter units rented in complex")
            return false
        }
        if txtUnitsForSale.getText().count == 0 {
            self.view.makeToast("Enter units for sale in complex")
            return false
        }
        if txtConverted.getText().count == 0 {
            self.view.makeToast("Select Converted")
            return false
        }
        if txtNoHOAReason.text.count == 0 {
            self.view.makeToast("Enter reason for No HOA.")
            return false
        }
        
        return true
    }
}
