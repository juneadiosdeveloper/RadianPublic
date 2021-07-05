//
//  GlobalVariables.swift
//  MyRadian Valuations
//
//  Created by Disha Patel - Syno on 05/02/21.
//  Copyright © 2021 Disha Patel. All rights reserved.
//

import Foundation

class GlobalVariables {
    
    static let sharedInstance = GlobalVariables()
    private init() {}
    var strPhoneNumber: String = ""
    var strDeviceID: String = ""
    var VerificationCode: String = ""
    var LoginPIN: String = ""
    var FcmToken: String = ""
    var MobileUserId: Int = 0
    var orgID: Int = 0
    var orderId: String = ""
    var strAddressInfo: String = ""
    var UserId: Int = 0
    var ItemId: Int = 0
    var CocFlag = Bool()
    var btnCount = Int()
    var isFromFogotAccessCode = false
    var payload : [String:Any] = [:]
    var isBusinessUser = false
}

