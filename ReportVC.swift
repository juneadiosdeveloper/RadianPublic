//
//  ReportVC.swift
//  MyRadian Valuations
//
//  Created by Sagar Kalathil on 13/05/21.
//  Copyright © 2021 Disha Patel. All rights reserved.
//

import UIKit

class ReportVC: BaseVC {

    @IBOutlet weak var navView: NavigationBar!
    //@IBOutlet weak var scrVwContent: UIScrollView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var pgControlVw: UIPageControl!
    var objPgVc: PageVCViewController?
    var arrVcIdentifiers = [SubjectHistoryVC.className, CurrentListingVC.className, LatestSoldInfoVC.className, PropertyInfoVC.className, CondoInformationVC.className]
    var intCurrentIndex = 0 {
        didSet {
            pgControlVw.currentPage = intCurrentIndex
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pgControlVw.numberOfPages = arrVcIdentifiers.count
        navView.isTitleHidden = false
        navView.title = "Subject Category"//GlobalVariables.sharedInstance.strAddressInfo
        navView.isLogoHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
          if let vc = destination as? PageVCViewController {
            objPgVc = destination as? PageVCViewController
            objPgVc?.arrTemporary = self.arrVcIdentifiers
            objPgVc?.del = self
          }
    }
    
    @IBAction func btnNextTapped(sender: UIButton) {
        if intCurrentIndex < arrVcIdentifiers.count - 1 {
            objPgVc?.slideToPage(index: intCurrentIndex + 1)
        }
    }
    @IBAction func btnPreviousTapped(sender: UIButton) {
        if intCurrentIndex > 0 {
            //Then only perform
            objPgVc?.slideToPage(index: intCurrentIndex - 1)
        }
    }
    
    @IBAction func btnSave(sender: UIButton) {
        
        let objVC = objPgVc?.tempViewControllers[intCurrentIndex]
        if let obj = objVC as? SubjectHistoryVC {
            var parameter = [String:String]()
            parameter = CommonFunctions.sharedInstance.getCommonParam()
            parameter[Constants.SubjectCategoryKey.kItemId] = "\(GlobalVariables.sharedInstance.ItemId)"
            parameter[Constants.SubjectCategoryKey.kUserId] = "\(GlobalVariables.sharedInstance.UserId)"
            parameter[Constants.SubjectCategoryKey.kPage] = "Inspection"
            parameter[Constants.SubjectCategoryKey.kItemBPOSubjecHistoryId] = CommonFunctions.sharedInstance.dropDownSubjectHistoryId()
            
            parameter[Constants.SubjectCategoryKey.SubjectHistory.kInspectionDate] = obj.txtInpectionDate.getText()
            parameter[Constants.SubjectCategoryKey.SubjectHistory.kInfoSource] = obj.txtInfoSource.getKey()
            parameter[Constants.SubjectCategoryKey.SubjectHistory.kAssessorParcel] = obj.txtApnNumber.getText()
            parameter[Constants.SubjectCategoryKey.SubjectHistory.kPropertyType] = obj.txtPropertyType.getKey()
            
            self.callSaveSubjectCategory(arrParam: parameter)
        }
        else if let obj = objVC as? LatestSoldInfoVC {
            var parameter = [String:String]()
            parameter = CommonFunctions.sharedInstance.getCommonParam()
            parameter[Constants.SubjectCategoryKey.kItemId] = "\(GlobalVariables.sharedInstance.ItemId)"
            parameter[Constants.SubjectCategoryKey.kUserId] = "\(GlobalVariables.sharedInstance.UserId)"
            parameter[Constants.SubjectCategoryKey.kPage] = "Sold"
            parameter[Constants.SubjectCategoryKey.kItemBPOSubjecHistoryId] = CommonFunctions.sharedInstance.dropDownSubjectHistoryId()
            
            parameter[Constants.SubjectCategoryKey.LatestSoldInfoKey.kSoldLast12Mo] = obj.txtSoldLast12Months.getKey()
            parameter[Constants.SubjectCategoryKey.LatestSoldInfoKey.kSoldListDate] = obj.txtLastListDate.getText()
            parameter[Constants.SubjectCategoryKey.LatestSoldInfoKey.kSoldFinalListPrice] = obj.txtFinalPrice.getText()
            parameter[Constants.SubjectCategoryKey.LatestSoldInfoKey.kSoldOriginalListDate] = obj.txtOriginalListDate.getText()
            parameter[Constants.SubjectCategoryKey.LatestSoldInfoKey.kSoldOriginalListPrice] = obj.txtOriginalPrice.getText()
            parameter[Constants.SubjectCategoryKey.LatestSoldInfoKey.kSaleDate] = obj.txtSaleDate.getText()
            parameter[Constants.SubjectCategoryKey.LatestSoldInfoKey.kSalePrice] = obj.txtSalePrice.getText()
            parameter[Constants.SubjectCategoryKey.LatestSoldInfoKey.kSoldDOM] = obj.txtDOM.getText()
            parameter[Constants.SubjectCategoryKey.LatestSoldInfoKey.kSoldListingBroker] = obj.txtListBroker.getText()
            parameter[Constants.SubjectCategoryKey.LatestSoldInfoKey.kSoldListingCompany] = obj.txtListCompany.getText()
            parameter[Constants.SubjectCategoryKey.LatestSoldInfoKey.kSoldListingPhone] = obj.txtListPhone.getText()
            
            self.callSaveSubjectCategory(arrParam: parameter)
            
        }
        else if let obj = objVC as? CurrentListingVC {
            var parameter = [String:String]()
            parameter = CommonFunctions.sharedInstance.getCommonParam()
            parameter[Constants.SubjectCategoryKey.kItemId] = "\(GlobalVariables.sharedInstance.ItemId)"
            parameter[Constants.SubjectCategoryKey.kUserId] = "\(GlobalVariables.sharedInstance.UserId)"
            parameter[Constants.SubjectCategoryKey.kPage] = "CurrentListing"
            parameter[Constants.SubjectCategoryKey.kItemBPOSubjecHistoryId] = CommonFunctions.sharedInstance.dropDownSubjectHistoryId()
            
            
            
            parameter[Constants.SubjectCategoryKey.CurrentListing.kListedLast12Mo] = obj.txtListedLastMonth.getKey()
            parameter[Constants.SubjectCategoryKey.CurrentListing.kCurrentlyListed] = obj.txtCurrentlyListed.getKey()
            parameter[Constants.SubjectCategoryKey.CurrentListing.kMultipleListings] = obj.txtListedMultiple.getKey()
            
            parameter[Constants.SubjectCategoryKey.CurrentListing.kCurrentListPrice] = obj.txtFinalPrice.getText()
            parameter[Constants.SubjectCategoryKey.CurrentListing.kOriginalListDate] = obj.txtOriginalListDate.getText()
            parameter[Constants.SubjectCategoryKey.CurrentListing.kOriginalListPrice] = obj.txtOriginalListPrice.getText()
            parameter[Constants.SubjectCategoryKey.CurrentListing.kDOM] = obj.txtDom.getText()
            parameter[Constants.SubjectCategoryKey.CurrentListing.kListingBroker] = obj.txtListingBroker.getText()
            parameter[Constants.SubjectCategoryKey.CurrentListing.kListingCompany] = obj.txtListingComp.getText()
            parameter[Constants.SubjectCategoryKey.CurrentListing.kListingPhone] = obj.txtListingPhone.getText()
            parameter[Constants.SubjectCategoryKey.CurrentListing.kForSaleSign] = obj.txtIsListedSign.getKey()
            parameter[Constants.SubjectCategoryKey.CurrentListing.kNotSoldReason] = obj.txtWhyNotSale.getText()
            
            
            self.callSaveSubjectCategory(arrParam: parameter)
            
            
        }
        else if let obj = objVC as? PropertyInfoVC {
            
            let isValidation = obj.isValid()
            if isValidation == false {
                return
            }
            
            var parameter = [String:String]()
            parameter = CommonFunctions.sharedInstance.getCommonParam()
            parameter[Constants.SubjectCategoryKey.kItemId] = "\(GlobalVariables.sharedInstance.ItemId)"
            parameter[Constants.SubjectCategoryKey.kUserId] = "\(GlobalVariables.sharedInstance.UserId)"
            parameter[Constants.SubjectCategoryKey.kPage] = "Property"
            parameter[Constants.SubjectCategoryKey.kItemBPOSubjecHistoryId] = CommonFunctions.sharedInstance.dropDownSubjectHistoryId()
            
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kACCESSDENIED] = obj.chkBxAccessDenied.getKey()
            
            
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kSubjectVisibility] = obj.txtIsSubjVisible.getKey()
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kPropertyVacant] = obj.txtPropertyVacant.getKey()
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kOccupant] = obj.txtWhoIsOccupant.getKey()
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kSecured] = obj.txtSecured.getKey()
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kPropertyView] = obj.txtView.getKey()
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kHoaOrOther] = obj.txtHOAorOther.getKey()
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kHoaName] = obj.txtHOAName.getText()
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kHoaPhone] = obj.txtHOAPhone.getText()
            
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kHoaFeesPeriod] = obj.txtHOAPaymentTerm.getKey()
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kHoaFeesAmount] = obj.txtHOAFees.getText()
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kHOADuesCurrent] = obj.txtHOADuesCurrent.getKey()
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kHoaDlqAmt] = obj.txtHOADeliquencyAmt.getText()
                
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kHOAINSURANCE] = obj.getInsuranceValues().0
            
            /*
            parameter["HOALANDSCAPING"] = obj.chkBxLandscaping.getKey()
            parameter["HOAPOOL"] = obj.chkBxPool.getKey()
            parameter["HOAINCLUDEGYM"] = obj.chkBxGym.getKey()
            parameter["HOAOROTHER"] = obj.chkBxOthers.getKey()
            */
            
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kHOAOROTHERDESC] = (obj.getInsuranceValues().1 == true) ? obj.txtOthers.getText() : ""
                    
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kGuestHouseSF] = obj.txtGuestHouseSF.getText()
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kGuestHouseBasementSF] = obj.txtGuestHouseBasementSF.getText()
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kTaxes] = obj.txtTaxes.getText()
            
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kDelinquentTaxes] = obj.txtDeliquentTaxes.getText()
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kTitlelegalIssues] = obj.txtTitleLegalIssues.getKey()
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kPredominantOccupancy] = obj.txtBuyerType.getKey()
            
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kOwnerPubRec] = obj.txtOwner.getText()
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kLegalDesc] = obj.txtLegalDescription.getText()
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kFinanceAvail] = obj.txtIsFinancing.getKey()
            
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kFINANCEAVAILDESC] = obj.txtFinanceAvailDesc.getText()
            
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kImprovementStatus] = obj.txtImproveCondition.getKey()
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kSpecialAssessmentsAmount] = obj.txtSpecialAssesAmt.getText()
            parameter[Constants.SubjectCategoryKey.PropertyInfo.kChildrenResiding] = obj.txtChildResiding.getKey()
            
            print("Order ID:\(GlobalVariables.sharedInstance.orderId)")
            print("Parameters: \(parameter)")
            self.callSaveSubjectCategory(arrParam: parameter)
        }
        else if let obj = objVC as? CondoInformationVC{
            
            var parameter = [String:String]()
            parameter = CommonFunctions.sharedInstance.getCommonParam()
            parameter[Constants.SubjectCategoryKey.kItemId] = "\(GlobalVariables.sharedInstance.ItemId)"
            parameter[Constants.SubjectCategoryKey.kUserId] = "\(GlobalVariables.sharedInstance.UserId)"
            parameter[Constants.SubjectCategoryKey.kPage] = "Condo"
            parameter[Constants.SubjectCategoryKey.kItemBPOSubjecHistoryId] = CommonFunctions.sharedInstance.dropDownSubjectHistoryId()
            
            
            
            parameter[Constants.SubjectCategoryKey.CondoInformation.kUnintsInComplex] = obj.txtNumberOfUnits.getText()
            parameter[Constants.SubjectCategoryKey.CondoInformation.kUnintsRentedInComplex] = obj.txtUnitsRented.getText()
            parameter[Constants.SubjectCategoryKey.CondoInformation.kNoOfSales] = obj.txtUnitsForSale.getText()
            parameter[Constants.SubjectCategoryKey.CondoInformation.kConverted] = obj.txtConverted.getKey()
            parameter[Constants.SubjectCategoryKey.CondoInformation.kNoHoaComment] = obj.txtNoHOAReason.text
            
            
            self.callSaveSubjectCategory(arrParam: parameter)
            
        }
    }
    
    func callSaveSubjectCategory(arrParam: [String: String]) {
        guard let token = CommonFunctions.sharedInstance.getFromKeychain(for: Constants.userDefaultKeys.deviceToken.rawValue) else {return}
        APIManager.sharedInstance.sendAPIRequestForPost(params: arrParam as [String : AnyObject], headToken: "Bearer " + token , andURLString: Constants.URLS.saveSubjectAPI, withOwner: self, completionHandler: { result in
            if result.value(forKey: "Status") as? String  == "OK", let results = result.value(forKey: "Data") as? NSDictionary{
                var msg = result.value(forKey: "Message") as? String
                self.view.makeToast(msg ?? "")
                if CommonFunctions.sharedInstance.dropDownSubjectHistoryId() == "" || CommonFunctions.sharedInstance.dropDownSubjectHistoryId() == "0"{
                    self.callGetCategory()
                }
            }else{
                self.showErrorMsg(result: result, viewController: self)
            }
        })
    }
    
    func callGetCategory() {
        var parameter = [String:String]()
        parameter = CommonFunctions.sharedInstance.getCommonParam()
        parameter["Itemid"] = "\(GlobalVariables.sharedInstance.ItemId)"
        parameter["UserId"] = "\(GlobalVariables.sharedInstance.UserId)"
        
        guard let token = CommonFunctions.sharedInstance.getFromKeychain(for: Constants.userDefaultKeys.deviceToken.rawValue) else {return}
        APIManager.sharedInstance.sendAPIRequestForPost(params: parameter as [String : AnyObject], headToken: "Bearer " + token , andURLString: Constants.URLS.getDropdownData, withOwner: self, completionHandler: { result in
            if result.value(forKey: "Status") as? String  == "OK", let results = result.value(forKey: "Data") as? NSArray{
                let dictData = result.value(forKey: "Data") as? NSArray
                let data = CommonFunctions.sharedInstance.convertToData(dict: dictData)
                if let apiData = data {
                    let dictResponse = try! JSONDecoder().decode([OptionsModel].self, from: apiData as! Data)
                    Constants.kAppDelegate.arrAllOptions = dictResponse
                    
                    
                }else{
                    self.showAlert(title: Constants.appName, message: "Something went wrong!", viewController: self)
                }
            }else{
                self.showErrorMsg(result: result, viewController: self)
            }
        })
    }
}

//MARK: Protocol Created
extension ReportVC : pageControlDelete {
    func pageChanged(intValue: Int) {
        self.intCurrentIndex = intValue
        enableDisableButton()
    }
    
    func enableDisableButton() {
        btnNext.isEnabled = true
        btnBack.isEnabled = true
        if intCurrentIndex == 0 {
            btnBack.isEnabled = false
        }
        if intCurrentIndex == arrVcIdentifiers.count - 1 {
            btnNext.isEnabled = false
        }
    }
}

//MARK: Protocol Created
protocol pageControlDelete {
    func pageChanged(intValue: Int)
}
