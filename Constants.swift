//
//  Constants.swift
//  MyRadian Valuations
//
//  Created by Disha Patel - Syno on 27/01/21.
//  Copyright © 2021 Disha Patel. All rights reserved.
//

import Foundation
import UIKit


struct Constants {
    

    static let appName = ""
    
    static let kScreenHeight = UIScreen.main.bounds.height
    static let kScreenWidth = UIScreen.main.bounds.width
    static let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    /*
    static let kNormalBaseUrl = "https://trainingbeta.radianvaluations.com"
    static let kBusinessBaseUrl = "https://trainingbeta.business.com"
    */
    
    enum Environment : String {
        case normal = "https://trainingbetaapi.radianvaluations.com"
        case business = "https://trainingapi.radianvaluations.com"
    }
    
    struct URLS {
        
        static var baseURL: String {
            get{
                if GlobalVariables.sharedInstance.isBusinessUser {
                    return Environment.business.rawValue + "/mobile/"
                }
                return Environment.normal.rawValue + "/mobile/"
            }
        }
        
        static var imageBaseURL: String {
            get{
                if GlobalVariables.sharedInstance.isBusinessUser {
                    return Environment.business.rawValue + "/content/images/"
                }
                return Environment.normal.rawValue + "/content/images/"
            }
        }
        static let login = "Login/SignIn"
        static let verifyOTPCOde = "Login/VerifyOTPCOde"
        static let changeAccessCode = "Login/ChangeAccessCode"
        static let generateOTPCode = "Login/GenerateOTPCode"
        static let submitCOC = "Dashboard/SaveVendorCompliance"
        static let getUserStatus = "Login/GetUserStatus"
        static let getOrganizationDetail = "Dashboard/OrganizationInfo"
        static let outOfOffice = "Dashboard/SaveVendorVacationInfo"
        static let signOut = "Login/SignOut"
        static let getNotificationStatus = "Dashboard/GetNotificationStatus"
        static let saveDeviceSetting = "Dashboard/SaveDeviceSetting"
        static let saveMessage = "Dashboard/AddMessage"
        static let getTileOrderNotes = "Dashboard/GetTileOrderNotes"
        static let deleteMessage = "Dashboard/SaveMessageMarkAsRead"
        static let bulkRead = "notification/ReadBulkNotification"
        static let manageOrder = "Dashboard/GetManageOrderDetail"
        static let newOrderDetail = "Dashboard/GetNewOrderDetail"
        static let saveConfirmOrder = "Dashboard/SaveConfirmOrder"
        static let inspection = "Dashboard/AddEditInspection"
        static let notifyBorrower = "Dashboard/NotifyBorrower"
        static let deleteDocument = "Dashboard/SaveDocumentMarkAsRead"
        static let getTileOrderDocuments = "Dashboard/GetTileOrderDocuments"
        static let getMyProfile = "Dashboard/GetMyProfile"
        static let submitProfile = "Dashboard/SaveMyProfile"
        static let uploadProfileImg = "Dashboard/UploadDocument"
        static let licenseSubmit = "vendorprofile/UpdateVendorLI"
        static let EOSubmit = "vendorprofile/UpdateVendorEO"
        static let w9Submit = "vendorprofile/UpdateVendorW9"
        static let whatsNew = "Dashboard/whatsnew"
        static let getVendorDetails = "Dashboard/GetVendorProfileDetails"
        static let getLicensetype = "Dashboard/GetLicenseDropdownList"
        static let homeList = "Dashboard/GetNewDashboardRefereshDetails"
        static let markRead = "Dashboard/DismissRequest"
        static let newOrderList = "Dashboard/NewOrderList"
        
        static let orderList = "Dashboard/OrderList"
        static let messageList = "Dashboard/GetDashboardTileDetails"
        
        //Load Document
        static let document = "Dashboard/GetDownloadDocument"
        static let lOEDocument = "Dashboard/GetDownloadOLEDocument"
        
        static var cocLink: String {
            get{
                if GlobalVariables.sharedInstance.isBusinessUser {
                    return Environment.business.rawValue + "/Content/Docs/CodeOfConduct.pdf"
                }
                return Environment.normal.rawValue + "/Content/Docs/CodeOfConduct.pdf"
            }
        }
        
        //static let cocLink = MainUrl + "/Content/Docs/CodeOfConduct.pdf"
        
       
        
        static let signUpLink = "https://falcon.radianvaluations.com/NewVendorProfile"
        static let covidLink = "https://www.radian.com/covid-19/"
        static let appStoreLink = "https://itunes.apple.com/us/app/id1484915701"
        
        //For getting category list in
        static let getCategoryList = "Dashboard/GetCategoryList"
        static let deletePhoto = "Dashboard/DeleteMultiplephotos"
        static let uploadPhotos = "Dashboard/Uploadfile"
        
        //For getting Subject Category List
        static let getDropdownData = "Dashboard/GetSubjectHistoryDropdown"
        
        //For Saving Subject Category List
        static let saveSubjectAPI = "Dashboard/SaveSubjectHistory"
    }
    
    struct PhotoUploadKeys {
        static let FileKey = "File"
        static let DescriptionKey = "Description"
        static let DateTimeKey = "DateTimeOriginal"
        static let LatitudeKey = "GPSLatitude"
        static let LongitudeKey = "GPSLongitude"
        static let PhotoTypeIdKey = "PhotoTypeId"
        static let FileNameKey = "FileName"
        static let ImageKey = "Image"
        static let CountKey = "Count"
        }
    
    
        struct SubjectCategoryKey {
            static let kItemId = "ItemId"
            static let kUserId = "UserId"
            static let kPage = "Page"
            static let kItemBPOSubjecHistoryId = "ItembpoSubjectHistoryId"
            struct SubjectHistory {
                static let kInspectionDate = "InspectionDate"
                static let kInfoSource = "InfoSource"
                static let kAssessorParcel = "AssessorParcel"
                static let kPropertyType = "PropertyType"
            }
        
            struct CurrentListing {
                static let kListedLast12Mo = "ListedLast12Mo"
                static let kCurrentlyListed = "CurrentlyListed"
                static let kMultipleListings = "MultipleListings"
                
                static let kCurrentListPrice = "CurrentListPrice"
                static let kOriginalListDate = "OriginalListDate"
                static let kOriginalListPrice = "OriginalListPrice"
                static let kDOM = "DOM"
                static let kListingBroker = "ListingBroker"
                static let kListingCompany = "ListingCompany"
                static let kListingPhone = "ListingPhone"
                static let kForSaleSign = "ForSaleSign"
                static let kNotSoldReason = "NotSoldReason"
            }
            
            struct LatestSoldInfoKey {
                static let kSoldLast12Mo = "SoldLast12Mo"
                static let kSoldListDate = "SoldListDate"
                static let kSoldFinalListPrice = "SoldFinalListPrice"
                static let kSoldOriginalListDate = "SoldOriginalListDate"
                static let kSoldOriginalListPrice = "SoldOriginalListPrice"
                static let kSaleDate = "SaleDate"
                static let kSalePrice = "SalePrice"
                static let kSoldDOM = "SoldDOM"
                static let kSoldListingBroker = "SoldListingBroker"
                static let kSoldListingCompany = "SoldListingCompany"
                static let kSoldListingPhone = "SoldListingPhone"
            }
            
            struct PropertyInfo {
                static let kACCESSDENIED = "ACCESSDENIED"
                
                
                static let kSubjectVisibility = "SubjectVisibility"
                static let kPropertyVacant = "PropertyVacant"
                static let kOccupant = "Occupant"
                static let kSecured = "Secured"
                static let kPropertyView = "PropertyView"
                static let kHoaOrOther = "HoaOrOther"
                static let kHoaName = "HoaName"
                static let kHoaPhone = "HoaPhone"
                
                static let kHoaFeesPeriod = "HoaFeesPeriod"
                static let kHoaFeesAmount = "HoaFeesAmount"
                static let kHOADuesCurrent = "HOADuesCurrent"
                static let kHoaDlqAmt = "HoaDlqAmt"
                    
                static let kHOAINSURANCE = "HOAINSURANCE"
                
                
                
                static let kHOAOROTHERDESC = "HOAOROTHERDESC"
                        
                static let kGuestHouseSF = "GuestHouseSF"
                static let kGuestHouseBasementSF = "GuestHouseBasementSF"
                static let kTaxes = "Taxes"
                
                static let kDelinquentTaxes = "DelinquentTaxes"
                static let kTitlelegalIssues = "TitlelegalIssues"
                static let kPredominantOccupancy = "PredominantOccupancy"
                
                static let kOwnerPubRec = "OwnerPubRec"
                static let kLegalDesc = "LegalDesc"
                static let kFinanceAvail = "FinanceAvail"
                
                static let kFINANCEAVAILDESC = "FINANCEAVAILDESC"
                
                static let kImprovementStatus = "ImprovementStatus"
                static let kSpecialAssessmentsAmount = "SpecialAssessmentsAmount"
                static let kChildrenResiding = "ChildrenResiding"
            }
            
            struct CondoInformation {
                static let kUnintsInComplex = "UnintsInComplex"
                static let kUnintsRentedInComplex = "UnintsRentedInComplex"
                static let kNoOfSales = "NoOfSales"
                static let kConverted = "Converted"
                static let kNoHoaComment = "NoHoaComment"
            }
    
            
    }
    
    struct ImageName {
        static let PlaceHolder = "PlaceHolder"
        
    }
    
    struct NotificationType {
        static let kGroupNotification = "ATM"
    }
    
    
    enum Font : String {
        case boldFont = "MessinaSans-Bold"
        case regularFont = "MessinaSans-Regular"
        case semiBoldFont = "MessinaSans-SemiBold"
        case lightFont = "MessinaSans-Light"
        case blackFont = "MessinaSans-Black"
        case regularItalicFont = "MessinaSans-RegularItalic"
    }
    
    enum StoryBoard : String {
        case main = "Main"
    }
    
    enum dateFormat : String {
        case ddMMMYYYY = "dd MMM yyyy"
        case mmddyyyyhma = "MM/dd/yyyy hh:mm a"
        case mmddyyyyhmsa = "MM/dd/yyyy hh:mm:ss a"
        
        
        //"3/19/2021 10:13:09 AM"
        case completDateFormat = "dd MMM yyyy HH:mm:ss"
        
        case pickerDateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        case txtFldDateFormat = "MM/dd/yyyy"
        
    }
    
    enum userDefaultKeys : String {
        case appLaunched = "appLaunched"
        case userDetail = "user_detail"
        case deviceToken = "token"
        case userStatus = "UserStatus"
        case PhoneNumber = "PhoneNumber"
        case DeviceID = "DeviceID"
        case profieImage = "profileImage"
    }
    
    struct Validations {
        static let mobileValidation = "Please Enter Mobile No."
        static let usernameValidation = "Please Enter Username"
        static let passwordValidation = "Please Enter Password"
        static let validMobileValidation = "Please Enter Valid Mobile No."
        static let validPasswordValidation = "Password must contain one Uppercase, one Number and One special character"
    }
    
    struct Colors {
        static let passcodeDots =  UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
        static let slightDarkGray = UIColor(red: 168.0/255.0, green: 168.0/255.0, blue: 168.0/255.0, alpha: 1)
        static let lighterGray = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
    }
    
    enum Events: String {
        case UserSignedIn = "NSNotificationUserSignedIn"
        case LocationAccessAuthorisationChanged = "NSNotificationLocationAccessAuthorizationChanged"
        case UserLocationUpdated = "NSNotificationUserLocationUpdated"
        case UserProfileUpdated = "NSNotificationUserProfileUpdated"
        case NotificationReceived = "NSNotificationNotificationReceived"
        case NotificationRead = "NSNotificationNotificationRead"
        case screenLaunched = "ScreenLaunched"
        case methodInvoked = "methodInvoked"

        var NSNotificationName: NSNotification.Name {
            return NSNotification.Name(rawValue)
        }
    }
    
}
