//
//  SelectCategoryVC.swift
//  MyRadian Valuations
//
//  Created by Sagar Kalathil on 02/06/21.
//  Copyright © 2021 Disha Patel. All rights reserved.
//

import Foundation
class SelectCategoryVC: BaseVC {
    
    @IBOutlet var txtSelect: TextFieldSpinner!
    @IBOutlet var txtMLS: ReportDataTextField!
    @IBOutlet weak var navView: NavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navView.isTitleHidden = false
        navView.title = "Subject Category"//GlobalVariables.sharedInstance.strAddressInfo
        navView.isLogoHidden = true
        
        txtSelect.setText(strValue: "")
        txtMLS.setText(str: "")
    }
    
    
    
    
    //Created function in order to set value from Spinner
    
    
    
    @IBAction func btnProceedTapped(sender: UIButton) {
        if sender.tag == 0 {
            
            /*
            if let vc = ScreenManager.getVCWithName(VC: ReportVC() , storyboard: Constants.StoryBoard.main) as? ReportVC     {
                Constants.kAppDelegate.arrAllOptions = CommonFunctions.sharedInstance.getDataFromFile()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            */
            self.callGetCategory()
        }
        else if sender.tag == 1 {
            if let vc = ScreenManager.getVCWithName(VC: ReportVC() , storyboard: Constants.StoryBoard.main) as? ReportVC     {
                Constants.kAppDelegate.arrAllOptions = CommonFunctions.sharedInstance.getDataFromFile()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        
    }
    
    func callGetCategory() {
        var parameter = [String:String]()
        parameter = CommonFunctions.sharedInstance.getCommonParam()
        parameter["Itemid"] = "\(GlobalVariables.sharedInstance.ItemId)"
        //parameter["Itemid"] = "442762"
        parameter["UserId"] = "\(GlobalVariables.sharedInstance.UserId)"
        print("Parametner: \(parameter)")
        
        guard let token = CommonFunctions.sharedInstance.getFromKeychain(for: Constants.userDefaultKeys.deviceToken.rawValue) else {return}
        APIManager.sharedInstance.sendAPIRequestForPost(params: parameter as [String : AnyObject], headToken: "Bearer " + token , andURLString: Constants.URLS.getDropdownData, withOwner: self, completionHandler: { result in
            if result.value(forKey: "Status") as? String  == "OK", let results = result.value(forKey: "Data") as? NSArray{
                let dictData = result.value(forKey: "Data") as? NSArray
                let data = CommonFunctions.sharedInstance.convertToData(dict: dictData)
                if let apiData = data {
                    let dictResponse = try! JSONDecoder().decode([OptionsModel].self, from: apiData as! Data)
                    Constants.kAppDelegate.arrAllOptions = dictResponse
                    self.navigateToCategoryScreen()
                    
                }else{
                    self.showAlert(title: Constants.appName, message: "Something went wrong!", viewController: self)
                }
            }else{
                self.showErrorMsg(result: result, viewController: self)
            }
        })
    }
    
    
    func navigateToCategoryScreen() {
        if let vc = ScreenManager.getVCWithName(VC: ReportVC() , storyboard: Constants.StoryBoard.main) as? ReportVC     {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
