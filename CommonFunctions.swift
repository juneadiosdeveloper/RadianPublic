//
//  CommonFunctions.swift
//  MyRadian Valuations
//
//  Created by Disha Patel - Syno on 02/02/21.
//  Copyright © 2021 Disha Patel. All rights reserved.
//

import Foundation
import Alamofire
import KeychainSwift
import MessageUI
import CoreLocation
import EventKit
import AVFoundation
import FirebaseAnalytics

class CommonFunctions {
    static let sharedInstance = CommonFunctions()
    private let keychain = KeychainSwift()
    let eventStore : EKEventStore = EKEventStore()
    
    class func isConnectedToNetwork() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    //Store value in Keychain
    func storeInKeychain(key: String, value: String) {
        self.keychain.set(value, forKey: key)
    }
    
    //Fetch value from keychain
    func getFromKeychain(for key: String) -> String? {
        if let result = self.keychain.get(key) {
            return result
        } else {
            return ""
        }
    }
    
    //Clear keychain data
    func clearKeychain() {
        self.keychain.clear()
    }
    
    func logEvent(eventName name:String, parameters: [String:Any]) {
        Analytics.logEvent(name, parameters: parameters)
    }
    
    func getCurrentTimeStamp() -> String{
        /*
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second

        let today_string = String(month!) + ":" + String(day!) + ":" + String(year!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)

        return today_string*/
        
        
        let timestamp = Date.currentTimeStamp
        
        return "\(timestamp)"

    }
    
    func circularButton(btn: UIButton, isBorder: Bool = true){
        btn.layer.cornerRadius = btn.bounds.size.height/2
        btn.clipsToBounds = true
        btn.layer.borderWidth = 1.5
        //var bo = UIColor(red: 14.0/255.0, green: 42.0/255.0, blue: 72.0/255.0, alpha: 1.0)
        if isBorder {
            btn.layer.borderColor = UIColor(red: 14.0/255.0, green: 42.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor//UIColor.lightGray.cgColor
        }
    }
    
    func makeCall(with num: String?) {
        if let contactNumber = num {
            guard let number = URL(string: "tel://" + contactNumber) else { return }
            UIApplication.shared.open(number)
        }
    }
    
    func getCommonParam() -> [String:String] {
        var parameter = [String:String]()
        parameter =  ["PhoneNumber":CommonFunctions.sharedInstance.getFromKeychain(for: Constants.userDefaultKeys.PhoneNumber.rawValue),
                      "DeviceID":CommonFunctions.sharedInstance.getFromKeychain(for: Constants.userDefaultKeys.DeviceID.rawValue),
                      "MobileUserId":String(GlobalVariables.sharedInstance.MobileUserId)] as! [String : String]
        return parameter
    }
    
    func sendMail(email: String, vc:UIViewController) {
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        } else {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = (vc as! MFMailComposeViewControllerDelegate)
            composeVC.setToRecipients([email])
            composeVC.setSubject("[myradian appraisals]")
            //                composeVC.setMessageBody("Hello", isHTML: false)
            vc.present(composeVC, animated: true, completion: nil)
        }
    }
    
    func removeEvent(title: String) {
        let startDate = Calendar.current.date(byAdding: .day, value: -30, to: Date())
        let endDate = Calendar.current.date(byAdding: .day, value: 30, to: Date())

        eventStore.requestAccess(to: .event) { (granted, error) in
            if (granted) && (error == nil) {
                let predicate = self.eventStore.predicateForEvents(withStart: startDate!, end: endDate! , calendars: nil)
                let ev = self.eventStore.events(matching: predicate) as [EKEvent]
                let result = ev.filter {
                    $0.title == title
                }
                for i in 0..<result.count {
                    do {
                        try self.eventStore.remove(result[i], span: .thisEvent)
                    } catch {
                        print("Error in deleting event")
                    }
                    
                }
            }
        }
    }
    
    func setEvent(date: Date,title: String, note: String, result: @escaping (Bool) -> Void) {
        eventStore.requestAccess(to: .event) { (granted, error) in
            if (granted) && (error == nil) {
                if EKEventStore.authorizationStatus(for: .event) == .authorized {
                    let event:EKEvent = EKEvent(eventStore: self.eventStore)

                    event.title = title
                    event.startDate = date
                    event.endDate = date
                    event.notes = note
                    event.calendar = self.eventStore.defaultCalendarForNewEvents
                    do {
                        try self.eventStore.save(event, span: .thisEvent)
                        result(true)
                    } catch let error as NSError {
                        print("failed to save event with error : \(error)")
                        result(false)
                    }
                } else {
                    result(false)
                }
            }
            else{
                print("failed to save event with error : \(String(describing: error)) or access not granted")
                result(false)
            }
        }
    }
    
    func navigateToMap(lat: String, long: String, currentLocation: CLLocation, vc: BaseVC) {
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
                UIApplication.shared.open(URL(string:"comgooglemaps://?saddr=\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)&daddr=\(lat),\(long)")!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.open(URL(string:"http://maps.apple.com/?saddr=\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)&daddr=\(lat),\(long)")!, options: [:], completionHandler: nil)
            }
        } else {
            vc.showAlert(title: Constants.appName, message: "Please enable location permission for myradian apprisals.", viewController: vc)
        }
    }
    
    func createDatePicker(datePicker: UIDatePicker, toolBar: UIToolbar, view: UIView) -> (UIDatePicker, UIToolbar) {
        // DatePicker
        datePicker.backgroundColor = UIColor.white
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        datePicker.minuteInterval = 15
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat.ddMMMYYYY.rawValue
        let currentDate = NSDate()
        datePicker.minimumDate = currentDate as Date
        
        // ToolBar
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.darkGray
        toolBar.sizeToFit()
        
        return (datePicker, toolBar)
    }
    
    //Add notification dot on tabbar item
    func addRedDotAtTabBarItemIndex(tabBarVC: UITabBarController, index: Int) {
        for subview in tabBarVC.tabBar.subviews {
            if subview.tag == 1234 {
                subview.removeFromSuperview()
                break
            }
        }

        let RedDotRadius: CGFloat = 7
        let RedDotDiameter = RedDotRadius * 2
        let TopMargin:CGFloat = 4
        let TabBarItemCount = CGFloat(tabBarVC.tabBar.items!.count)

        let screenSize = UIScreen.main.bounds
        let HalfItemWidth = (screenSize.width) / (TabBarItemCount * 2)

        let  xOffset = HalfItemWidth * CGFloat(index * 2 + 1)
        let imageHalfWidth: CGFloat = (tabBarVC.tabBar.items![index]).selectedImage!.size.width / 2
        
        let redDot = UIView(frame: CGRect(x: xOffset + imageHalfWidth - 10, y: TopMargin, width: RedDotDiameter, height: RedDotDiameter))
        redDot.tag = 123 + index
        redDot.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.4470588235, blue: 0.4078431373, alpha: 1)
        redDot.layer.cornerRadius = RedDotRadius

        tabBarVC.tabBar.addSubview(redDot)
    }
    
    //Remove notification dot from tabbar item
    func removeBadgeFromTab(tabBarVC: UITabBarController, index: Int) {
        for subview in tabBarVC.tabBar.subviews {
            if subview.tag == 123 + index {
                subview.removeFromSuperview()
               // break // Added by Shishir Mishra
            }
        }
    }
    
    func setRoundCorners(view: UIView, corners: UIRectCorner) {
        let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 25, height: 25))
        let rectShape = CAShapeLayer()
        rectShape.frame = view.bounds
        rectShape.path = maskPath.cgPath
        view.layer.mask = rectShape
    }
    
    func setDashboard(vc: BaseVC) {
        if let tab = ScreenManager.getVCWithName(VC: TabBarVC(), storyboard: .main) as? TabBarVC {
            vc.sideMenuViewController!.setContentViewController(tab, animated: true)
            vc.sideMenuViewController!.hideMenuViewController()
        }
    }
    
    func showImagePickerDialogue(imagePicker: UIImagePickerController, vc: UIViewController, fromProfile: Bool) {
            let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                        if fromProfile {
                            self.openFaceDetectionCamera(vc: vc)
                        } else {
                            self.openCamera(imagePicker: imagePicker, VC: vc)
                        }
                    }))
                    
                    alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                        self.openGallary(imagePicker: imagePicker, VC: vc)
                    }))
                    
                    alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                    
                    /*If you want work actionsheet on ipad
                     then you have to use popoverPresentationController to present the actionsheet,
                     otherwise app will crash on iPad */
                    switch UIDevice.current.userInterfaceIdiom {
                    case .pad:
                        print("not valid")
            //            alert.popoverPresentationController?.sourceView = sender
            //            alert.popoverPresentationController?.sourceRect = sender.bounds
            //            alert.popoverPresentationController?.permittedArrowDirections = .up
                    default:
                        break
                    }
                    vc.present(alert, animated: true, completion: nil)
        }
        
        func openFaceDetectionCamera(vc: UIViewController) {
            if let profileVC = vc as? ProfileVC {
                if let faceVC = ScreenManager.getVCWithName(VC: FaceDetectionViewController(), storyboard: .main) as? FaceDetectionViewController {
                    faceVC.delegate = profileVC
                    vc.present(faceVC, animated: true, completion: nil)
                }
            }
        }
        
        func openCamera(imagePicker: UIImagePickerController, VC : UIViewController) {
            if AVCaptureDevice.authorizationStatus(for: .video) == AVAuthorizationStatus.authorized {
                if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
                {
                    imagePicker.sourceType = UIImagePickerController.SourceType.camera
        //            imagePicker.allowsEditing = true
                    VC.present(imagePicker, animated: true, completion: nil)
                }
                else
                {
                    let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    VC.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert  = UIAlertController(title: Constants.appName, message: "Please allow myradian appraisals app to access camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    VC.navigationController?.popViewController(animated: true)
                }))
                VC.present(alert, animated: true, completion: nil)
            }
        }
        
        func openGallary(imagePicker: UIImagePickerController, VC : UIViewController) {
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.delegate = (VC as! UIImagePickerControllerDelegate & UINavigationControllerDelegate)
    //        imagePicker.allowsEditing = true
            VC.present(imagePicker, animated: true, completion: nil)
        }
    
    func callDocumentUpload(parameter: [String:Any], imageParam: [String:UIImage], VC: BaseVC) {
        APIManager.sharedInstance.uploadImageWithData(imgParams: imageParam, params: parameter, andURLString: Constants.URLS.uploadProfileImg, withOwner: self) { (result) in
            if result.object(forKey: "Status") as? String  == "OK"{
                print("success")
            }else{
                VC.showErrorMsg(result: result, viewController: VC)
            }
        }
    }
    
    func callApiForUrl(url : String, param: [String:Any], controller: BaseVC, success: @escaping (Bool) -> Void){
        guard let token = self.getFromKeychain(for: Constants.userDefaultKeys.deviceToken.rawValue) else {return}
        APIManager.sharedInstance.sendAPIRequestForPost(params: param as [String : AnyObject], headToken: "Bearer " + token, andURLString: url, withOwner: self) { (response) in
            if response.object(forKey: "Status") as? String  == "OK"{
                success(true)
            }else{
                controller.showErrorMsg(result: response, viewController: controller)
                success(false)
            }
        }
    }
    
    //Validate password field
    class func validPasswordFld(password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$*]).{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func getOrganizationDetail(viewController: BaseVC, result: @escaping (Bool, NSDictionary?) -> Void) {
        APIManager.sharedInstance.sendAPIRequestForGet(andURLString: Constants.URLS.getOrganizationDetail, withOwner: viewController, completionHandler: { jsonResponse in
            if jsonResponse.object(forKey: "Status") as? String  == "OK"{
                result(true, jsonResponse)
            }else{
                viewController.showErrorMsg(result: jsonResponse, viewController: viewController)
                result(false, nil)
            }
        })
    }
    
    func convertToData<T>(dict: T)->NSData? {
        /*
        var json: NSData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
        */
        do {
            var json: NSData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            return json
            // use props here; no manual parsing the properties is needed
        } catch {
            print("json error: \(error.localizedDescription)")
            return nil
        }
        
    }
    //Created function in order to retrive LOE URl
    func getLOEUrl(order: OrderNotificationListModel) -> String {
        let orderGenID = order.OrderGenId ?? ""
        let itemSrNo = order.ItemSrNo ?? 0
        let serviceRequestType = order.ServiceRequestType ?? 0
        let userId = order.UserId ?? 0
        let strUrl = String("\(Constants.URLS.baseURL+Constants.URLS.lOEDocument)\("?OrderGenID=")\(orderGenID )\("&ItemSrNo=")\(itemSrNo)\("&UserId=")\(userId)\("&ServiceRequestType=")\(serviceRequestType)")
        return strUrl
    }
    
    
    
    class func convertImageToBase64(image: UIImage) -> String {
        let imageData = image.pngData()!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
    
    func isValidDocument(str: String)->Bool {
        if str.hasSuffix(".jpeg") || str.hasSuffix(".jpg") || str.hasSuffix(".png") {
            return true
        }
        return false
    }
    //MARK: Notification Handler Methods
    func redirectWithABBR(abbr: String, navController: UINavigationController, payload: [String:Any]) {
        switch abbr {
        case "ACCEPTORDER":
            if let orgID = (payload["orgId"] as? NSString)?.intValue , let itemID = (payload["id"] as? NSString)?.intValue {
                self.redirectToNewOrder(navController: navController, orgID: Int(orgID), itemID: Int(itemID))
            }
        case "GROUP" :
            //var payload = GlobalVariables.sharedInstance.payload
            if let ids = payload["BroadcastItemIds"] as? NSString  {
                Constants.kAppDelegate.strBroadcastIds = ids as String
                self.redirectToNew(navController: navController)
            }
        /*
        case "OPENORDER", "SCHEDULED", "COMPLETED" :
            if let orgID = (payload["orgId"] as? NSString)?.intValue , let itemID = (payload["id"] as? NSString)?.intValue {
                self.redirectToManageOrder(navController: navController, orgID: Int(orgID), itemID: Int(itemID))
            }*/
        case "NOTE" :
            self.redirectToMsgs(navController: navController)
        case "DOCUMENT" :
            if let orgID = (payload["orgId"] as? NSString)?.intValue , let itemID = (payload["id"] as? NSString)?.intValue {
                self.redirectToDocuments(navController: navController, orgID: Int(orgID), itemID: Int(itemID))
            }
        /*
        case "REVISION" :
            if let orgID = (payload["orgId"] as? NSString)?.intValue , let itemID = (payload["id"] as? NSString)?.intValue {
                self.redirectToRev(navController: navController, orgID: Int(orgID), itemID: Int(itemID))
            }*/
        case "LOE" :
            if let orderGenID = payload["orderGenId"] as? String , let itemNo = (payload["itemSrNo"] as? NSString)?.intValue , let userID = (payload["userId"] as? NSString)?.intValue , let serviceType = (payload["serviceRequestType"] as? NSString)?.intValue {
                
                var order = OrderNotificationListModel()
                order.OrderGenId = orderGenID
                order.ItemSrNo = Int(itemNo)
                order.UserId = Int(userID)
                order.ServiceRequestType = Int(serviceType)
                self.redirectToLOE(navController: navController, order: order)
            }
        /*
       case "LATE", "DUE":
            if let count = (payload["orderCount"] as? NSString)?.intValue {
                if count > 1 {
                    navController.tabBarController?.selectedIndex = 1
                }else{
                    if let orgID = (payload["orgId"] as? NSString)?.intValue , let itemID = (payload["id"] as? NSString)?.intValue {
                        self.redirectToManageOrder(navController: navController, orgID: Int(orgID), itemID: Int(itemID))
                    }
                }
            }*/
        default:
            break
        }
    }
    
    func redirectToDocuments(navController: UINavigationController?, orgID: Int, itemID: Int) {
        /*
        let vc = ScreenManager.getDocListingVC()
        vc.itemID = itemID
        vc.orgID = orgID
        navController?.pushVi ewController(vc, animated: true)
        */
        
        
        if let vc = ScreenManager.getVCWithName(VC: DocListingVC() , storyboard: Constants.StoryBoard.main) as? DocListingVC {
            vc.orgID = orgID
            vc.itemID = itemID
            navController?.pushViewController(vc, animated: true)
        }
    }
    
    func redirectToMsgs(navController: UINavigationController?) {
        /*
        let ObjMessageVC = ScreenManager.getMessageListViewController()
        ObjMessageVC.AbbrType = "N_MESSAGE"
        let ObjMainMessageVC = ScreenManager.getMainMessageListViewController()
        navController?.pushViewController(ObjMainMessageVC, animated: true)
        */
        if let vc = ScreenManager.getVCWithName(VC: MessageListVC() , storyboard: Constants.StoryBoard.main) as? MessageListVC {
            navController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func redirectToNewOrder(navController: UINavigationController?) {
        
        
        if let vc = ScreenManager.getVCWithName(VC: MessageListVC() , storyboard: Constants.StoryBoard.main) as? MessageListVC {
            navController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    func redirectToRev(navController: UINavigationController?, orgID: Int, itemID: Int) {
        /*
        let objRevisions = ScreenManager.getRevisionsViewControllr()
        objRevisions.ItemId = itemID
        objRevisions.OrgId  = orgID
        navController?.pushViewController(objRevisions, animated: true)*/
    }
    
    func redirectToManageOrder(navController: UINavigationController?, orgID: Int, itemID: Int) {
        /*
        let vc = ScreenManager.getManageOrderVC()
        vc.orgID = orgID
        vc.itemID = itemID
        navController?.pushViewController(vc, animated: true)*/
        
        
        
        
        if let vc = ScreenManager.getVCWithName(VC: ManageOrderVC() , storyboard: Constants.StoryBoard.main) as? ManageOrderVC {
            vc.itemID = itemID
            vc.orgID = orgID
            //GlobalVariables.sharedInstance.UserId = order.UserId!
            navController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func redirectToNew(navController: UINavigationController?) {
        if let vc = ScreenManager.getVCWithName(VC: NewVC() , storyboard: Constants.StoryBoard.main) as? NewVC {
            Constants.kAppDelegate.isAppFromFresh = false
            navController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func redirectToNewOrder(navController: UINavigationController?, orgID: Int, itemID: Int) {
        /*
        let vc = ScreenManager.getNewOrderVC()
        vc.orgID = orgID
        vc.itemID = itemID
        navController?.pushViewController(vc, animated: true)
        */
        
        if let vc = ScreenManager.getVCWithName(VC: NewOrderVC(), storyboard: .main) as? NewOrderVC {
            vc.orgID = orgID
            vc.itemID = itemID
            navController?.pushViewController(vc, animated: true)
        }
    }
    
    func redirectToLOE(navController: UINavigationController?, order : OrderNotificationListModel) {
        /*
        let ObjOLEDoc = ScreenManager.getOLEDocumentViewControllr()
        ObjOLEDoc.OrderGenID          = orderGenID
        ObjOLEDoc.ItemSrNo            = itemNo
        ObjOLEDoc.UserId              = userID
        ObjOLEDoc.ServiceRequestType  = serviceReqType
        navController?.pushViewController(ObjOLEDoc, animated: true)
        */
        
        if let vc = ScreenManager.getVCWithName(VC: CocVC() , storyboard: Constants.StoryBoard.main) as? CocVC {
            vc.isLoeScreen = true
            vc.order = order
            vc.strUrl = CommonFunctions.sharedInstance.getLOEUrl(order: order)
            navController?.pushViewController(vc, animated: true)
        }
    }
    /*
    func getJson(obj: SubjectModel, strFileName: String)->[SubjectModel] {
        var arr = [SubjectModel]()
        let url = Bundle.main.url(forResource: strFileName, withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            
            let jsonResult = try JSONSerialization.jsonObject(with: jsonData)
            
            
            if let js = jsonResult as? Dictionary<String, AnyObject> {
                print(js)
                if let person = (js["Data"] as? NSArray) as? [SubjectModel] {
                    return person
                }
            }
        }
        catch {
            print(error)
        }
        return arr
    }
    */
    func getDataFromFile() -> [OptionsModel] {
        var arr = [OptionsModel]()
        let url = Bundle.main.url(forResource: "OptionsAPI", withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            let blogPost: [OptionsModel] = try! JSONDecoder().decode([OptionsModel].self, from: jsonData)
            return blogPost
        }
        catch {
            print(error)
        }
        return arr
    }
    
    func getCheckBoxArray(str: String)-> [CheckBoxOptions] {
        let arr = Constants.kAppDelegate.arrAllOptions
        var arrFilter = arr.filter({$0.Id == str ?? ""})
        if arrFilter.count > 0 {
            return arrFilter[0].CheckboxList ?? [CheckBoxOptions]()
        }
        return [CheckBoxOptions]()
    }
    
    func getOptions(str: String)-> OptionsModel {
        let arr = Constants.kAppDelegate.arrAllOptions
        var obj = OptionsModel()
        let arrFilter = arr.filter({$0.Id == str ?? ""})
        
        if arrFilter.count > 0 {
            return arrFilter[0]
        }
        return obj
    }
    
    func getValue(str: String)-> String {
        let arr = Constants.kAppDelegate.arrAllOptions
        var obj = OptionsModel()
        let arrFilter = arr.filter({$0.Id == str ?? ""})
        
        if arrFilter.count > 0 {
            return arrFilter[0].Value ?? ""
        }
        return obj.Value ?? "NO KEY"
    }
    
    
    func showCommonPicker(txtFld: TextFieldSpinner, strTitle: String) {
        var arrOptions = dropDownarray(strKey: txtFld.strKeyName ?? "")
        
        let arr = getAllValues(dropDown: arrOptions)
        txtFld.addAction(for: .touchUpInside){ (txt) in
            ActionSheetStringPicker.show(withTitle: strTitle, rows: arr, initialSelection: 0, doneBlock: { (actionsheet, intVal, value) in
                txtFld.setText(strValue: "\(value ?? "")")
                txtFld.selectedOption = arrOptions[intVal]
            }, cancel: nil, origin: txtFld)
        }
    }
    
    func getBoolFromString(str: String)-> Bool {
        if str.lowercased().contains("true") {
            return true
        }
        return false
    }
    
    func getAllValues(dropDown: [DropDownOptions])-> [String]{
        var arrOptions = [String]()
        for i in dropDown {
            arrOptions.append(i.Text ?? "")
        }
        return arrOptions
    }
    
    func dropDownarray(strKey: String)-> [DropDownOptions] {
        let arrOptions = CommonFunctions.sharedInstance.getOptions(str: strKey)
        let arr = arrOptions.OptionList ?? [DropDownOptions]()
        return arr
    }
    
    func dropDownSubjectHistoryId()-> String {
        let arr = Constants.kAppDelegate.arrAllOptions
        let arrFilter = arr.filter({$0.Id == "ItembpoSubjectHistoryId" ?? ""})
        var obj = OptionsModel()
        if arrFilter.count > 0 {
            return arrFilter[0].Value ?? "0"
        }
        return obj.Value ?? "0"
    }
    
}
