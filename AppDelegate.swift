//
//  AppDelegate.swift
//  MyRadian Valuations
//
//  Created by Disha Patel - Syno on 27/01/21.
//  Copyright © 2021 Disha Patel. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import ZKUDID
import DropDown
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?
    /*
    var currentSelectedAsset: AssetModel?
    var arrAssets = [AssetModel]()
    var arrCategoryDetails = [CategoryModel]()
    
    var arrAllPhotos = [CategoryModel]()
    var arrSubPhotos = [CategoryModel]()
    */
    
    var strBroadcastIds = String("")
    var isAppFromFresh = true
    var arrAllOptions = [OptionsModel]()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        sleep(4)
        if UserDefaults.standard.bool(forKey: Constants.userDefaultKeys.appLaunched.rawValue) != true {
            CommonFunctions.sharedInstance.clearKeychain()
            UserDefaults.standard.set(true, forKey: Constants.userDefaultKeys.appLaunched.rawValue)
        }
        
        DropDown.startListeningToKeyboard()
        
        //Setting up of  IQKeyboardManager framework
        IQKeyboardManager.shared.enable = true
        
        let UDIDString = ZKUDID.value()
        CommonFunctions.sharedInstance.storeInKeychain(key: Constants.userDefaultKeys.DeviceID.rawValue, value: UDIDString ?? "")
        print("Device IDdddddd %@",UDIDString ?? 0)
        
        //setup fierbase
        FirebaseApp.configure()
        
        //Push notification
        Messaging.messaging().delegate = self
        application.applicationIconBadgeNumber = 0
        registerForPushNotifications()
        
        if let options = launchOptions, let payload = options[UIApplication.LaunchOptionsKey.remoteNotification] as? [String:Any] {
            isAppFromFresh = true
            GlobalVariables.sharedInstance.payload = payload
        }
        
        UILabel.appearance().font = UIFont(name: Constants.Font.regularFont.rawValue, size: 16.0)
        
        window?.rootViewController = ScreenManager.getRootViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge]) {
                [weak self] granted, error in
                
                print("Permission granted: \(granted)")
                guard granted else { return }
                self?.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
           InstanceID.instanceID().instanceID { (result, error) in
               if let error = error {
                   print("Error fetching remote instance ID: \(error)")
               } else if let result = result {
                   print("Remote instance ID token: \(result.token)")
                   GlobalVariables.sharedInstance.FcmToken = result.token
               }
           }
       }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("device token : \(deviceTokenString)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("Did ReceiveRemoteNotification : \((userInfo as NSDictionary))")
        print("application badge count \(UIApplication.shared.applicationIconBadgeNumber)")
        completionHandler(UIBackgroundFetchResult.newData)
     }
    
    // PN when app is in foreground
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(UNNotificationPresentationOptions.alert)
    }
    
    //Tap on notification
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            
            if UIApplication.shared.applicationState == UIApplication.State.active || UIApplication.shared.applicationState == UIApplication.State.background || UIApplication.shared.applicationState == UIApplication.State.inactive {
                let navController = self.window?.rootViewController as? UINavigationController
                if let abbr = response.notification.request.content.userInfo["abbr"] as? String {
                    CommonFunctions.sharedInstance.redirectWithABBR(abbr: abbr, navController: navController!, payload: response.notification.request.content.userInfo as! [String : Any])
                }
                
            }
            completionHandler()
            
            /*
            if UIApplication.shared.applicationState == UIApplication.State.active || UIApplication.shared.applicationState == UIApplication.State.background || UIApplication.shared.applicationState == UIApplicationState.inactive {
                
            let navController = self.window?.rootViewController as? UINavigationController
            if let abbr = response.notification.request.content.userInfo["abbr"] as? String {
                
    
                if abbr == "ACCEPTORDER" || abbr == "GROUP" {
                    // new order and acceptance is required
                    if let itemID = (response.notification.request.content.userInfo["id"] as? NSString)?.intValue, let orgID = (response.notification.request.content.userInfo["orgId"] as? NSString)?.intValue {
                        
                        Utilities.sharedInstance.redirectToNewOrder(navController: navController, orgID: Int(orgID), itemID: Int(itemID))
                        
    
                    }
                } else if abbr == "OPENORDER" || abbr == "SCHEDULED" || abbr == "COMPLETED" {
                    // new order and acceptance is not required , reminder for scheduled appointment and completed order
                    if let itemID = (response.notification.request.content.userInfo["id"] as? NSString)?.intValue, let orgID = (response.notification.request.content.userInfo["orgId"] as? NSString)?.intValue {
    
                        
                        
                        Utilities.sharedInstance.redirectToManageOrder(navController: navController, orgID: Int(orgID), itemID: Int(itemID))
   
                    }
                } else if abbr == "NOTE"{
                    // new order note
                    
                    Utilities.sharedInstance.redirectToMsgs(navController: navController)
                    
    //
                } else if abbr == "DOCUMENT" {
                    // new document
                    
                    if let itemID = (response.notification.request.content.userInfo["id"] as? NSString)?.intValue , let orgID = (response.notification.request.content.userInfo["orgId"] as? NSString)?.intValue{
                        
                        Utilities.sharedInstance.redirectToDocuments(navController: navController, orgID: Int(orgID), itemID: Int(itemID))
    
                    }
                } else if abbr == "REVISION" {
                    if let itemID = (response.notification.request.content.userInfo["id"] as? NSString)?.intValue , let orgID = (response.notification.request.content.userInfo["orgId"] as? NSString)?.intValue {
                        
                        Utilities.sharedInstance.redirectToRev(navController: navController, orgID: Int(orgID), itemID: Int(itemID))
    
                    }
                } else if abbr == "LOE" {
                    if let orderGenID = response.notification.request.content.userInfo["orderGenId"] as? String,
                        let  itemNo = (response.notification.request.content.userInfo["itemSrNo"] as? NSString)?.intValue,
                        let userID = (response.notification.request.content.userInfo["userId"] as? NSString)?.intValue,
                        let serviceType = (response.notification.request.content.userInfo["serviceRequestType"] as? NSString)?.intValue {
                        
                        Utilities.sharedInstance.redirectToLOE(navController: navController, orderGenID: orderGenID, itemNo: Int(itemNo), userID: Int(userID), serviceReqType: Int(serviceType))
    
                    }
                } else if abbr == "LATE" || abbr == "DUE" {
                    if let count = (response.notification.request.content.userInfo["orderCount"] as? NSString)?.intValue {
                        if count > 1 {
                            // late order list
                            navController?.tabBarController?.selectedIndex = 1
                        } else {
                            //order detail
                            if let itemID = (response.notification.request.content.userInfo["id"] as? NSString)?.intValue, let orgID = (response.notification.request.content.userInfo["orgId"] as? NSString)?.intValue {
    
                                    let vc = ScreenManager.getManageOrderVC()
                                    vc.orgID = Int(orgID)
                                    vc.itemID = Int(itemID)
                                    navController?.pushViewController(vc, animated: true)
                            }
                        }
                    }
                }
                            
            }*/
            //completionHandler()
//            }
        }
}

