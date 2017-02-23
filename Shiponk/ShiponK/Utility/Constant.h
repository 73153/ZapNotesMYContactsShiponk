//
//  Constant.h
//  Challenge Me


#import "AppDelegate.h"

#import "ApiCall.h"
#import "MBProgressHUD.h"



#ifndef ChallengeMe_Constant_h
#define ChallengeMe_Constant_h

#define appDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define kFontName @"OpenSans-SemiBold"
#define BASE_URL        @"http://216.55.169.45/~shiponk/master/"


//ws_logout

#define API_LOG_IN           (BASE_URL@"ws_login")
#define API_LOGOUT           (BASE_URL@"ws_logout")
#define API_SIGNUP           (BASE_URL@"ws_signup")
#define API_SOCIAL_LOGIN           (BASE_URL@"ws_social_login")
#define API_BUSINESS_TYPE           (BASE_URL@"ws_business_type")
#define API_VEHICLE_TYPE          (BASE_URL@"ws_vehicle_type")
#define API_FORGOTPASSWORD         (BASE_URL@"ws_forgot_password")
#define API_CATEGORY_LIST           (BASE_URL@"ws_get_categories")
#define API_SUB_CATEGORY_LIST         (BASE_URL@"ws_get_sub_categories")
#define API_SHIPMENT_DETAIL     (BASE_URL@"ws_shipment_detail")
#define API_SHIPMENT_LIST_FOR_TRANSPORTER (BASE_URL@"ws_shipment_list_for_transporter")
#define API_USER_PROFILE (BASE_URL@"ws_user_profile")

#define API_EDIT_USER_PROFILE     (BASE_URL@"ws_edit_user_profile")


#define API_SHIPMENT_LIST_FOR_CUSTOMER     (BASE_URL@"ws_shipment_list_for_customer")
#define API_SHIPMENT_BIDS     (BASE_URL@"ws_shipment_bids")

#define API_ACCEPT_BIDS     (BASE_URL@"ws_accept_bid")
#define API_CREATE_SHIPMENT            (BASE_URL@"ws_create_shipment")
#define API_CHANGE_PASSWORD     (BASE_URL@"ws_change_password")
#define API_DELETE_SHIPMENT     (BASE_URL@"ws_delete_shipment")
#define API_CREATE_BID     (BASE_URL@"ws_create_bid")
#define API_CATEGORY_TREE     (BASE_URL@"ws_category_tree")
#define API_VIEW_RATING     (BASE_URL@"ws_view_ratings")

#define API_ADD_RATING   (BASE_URL@"ws_add_rating")

#define API_WS_GET_LOACTIONS_TYPE   (BASE_URL@"ws_get_location_type")

#define API_PAYMENT_LIST   (BASE_URL@"ws_payment_list")

#define API_NOTIFICATION_HISTORY (BASE_URL@"ws_notification_history")
#define API_CHABGE_NOTIFICATION_STATUS (BASE_URL@"ws_change_notification_status")
#define API_TRANSPORTER_BID_LIST (BASE_URL@"ws_transporter_bid_list")

#define API_EDIT_BID (BASE_URL@"ws_edit_bid")
#define API_CANCEL_BID (BASE_URL@"ws_cancel_bid")

#define API_CUSTOMER_CANCEL_BID (BASE_URL@"ws_customer_cancel_bid")

#define API_ANIMAL_BREED (BASE_URL@"ws_animal_breed")
#define API_PAYMENT (BASE_URL@"ws_payment")
#define API_DELETE_NOTIFICATION (BASE_URL@"ws_delete_notification")
#define API_SHIPMENT_ITEM_DETAIL (BASE_URL@"ws_shipment_item_detail")
#define API_APPLY_PROMO_CODE (BASE_URL@"ws_apply_promo_code")
#define API_PAYMENT_HISTORY (BASE_URL@"ws_payment_history")


#endif
#define CommentCellFont  [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:14]

#define IS_IPHONE4 (([[UIScreen mainScreen] bounds].size.height-480)?NO:YES)
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define IS_IPHONE6 (([[UIScreen mainScreen] bounds].size.height-667)?NO:YES)
#define IS_IPHONE6plus (([[UIScreen mainScreen] bounds].size.height-736)?NO:YES)



#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define DEVICE_FRAME [[ UIScreen mainScreen ] bounds ]

#define RGB(r,g,b)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define BG_COLOR        RGB(33,60,136)
#define LightGray_COLOR [UIColor colorWithRed:(246.0/255.0) green:(246.0/255.0) blue:(249.0/255.0) alpha:1];
#define LightBlue_COLOR [UIColor colorWithRed:(45.0/255.0) green:(186.0/255.0) blue:(241.0/255.0) alpha:1];
#define DarkBlue_COLOR [UIColor colorWithRed:(28.0/255.0) green:(48.0/255.0) blue:(84.0/255.0) alpha:1];

#define RECT(x,y,w,h)  CGRectMake(x, y, w, h)
#define POINT(x,y)     CGPointMake(x, y)
#define SIZE(w,h)      CGSizeMake(w, h)
#define RANGE(loc,len) NSMakeRange(loc, len)

#define UDSetObject(value, key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:(key)];[[NSUserDefaults standardUserDefaults] synchronize]
#define UDSetValue(value, key) [[NSUserDefaults standardUserDefaults] setValue:value forKey:(key)];[[NSUserDefaults standardUserDefaults] synchronize]
#define UDSetBool(value, key) [[NSUserDefaults standardUserDefaults] setInteger:value forKey:(key)];[[NSUserDefaults standardUserDefaults] synchronize]
#define UDSetInt(value, key) [[NSUserDefaults standardUserDefaults] setFloat:value forKey:(key)];[[NSUserDefaults standardUserDefaults] synchronize]
#define UDSetFloat(value, key) [[NSUserDefaults standardUserDefaults] setBool:value forKey:(key)];[[NSUserDefaults standardUserDefaults] synchronize]

#define UDGetObject(key) [[NSUserDefaults standardUserDefaults] objectForKey:(key)]
#define UDGetValue(key) [[NSUserDefaults standardUserDefaults] valueForKey:(key)]
#define UDGetInt(key) [[NSUserDefaults standardUserDefaults] integerForKey:(key)]
#define UDGetFloat(key) [[NSUserDefaults standardUserDefaults] floatForKey:(key)]
#define UDGetBool(key) [[NSUserDefaults standardUserDefaults] boolForKey:(key)]

#define UDRemoveObject(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:(key)]

#define topDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define dt_time_formatter @"yyyy-MM-dd HH:mm:ss"
#define dt_formatter @"yyyy-mm-dd"
#define time_formatter @"HH:mm:ss"
#define APPDATA [ApplicationData sharedInstance] 
typedef enum {
    HTTPRequestTypeGeneral,
    HTTPRequestTypeUpdate,
    HTTPRequestTypeImageList,
    HTTPRequestTypeVideoList,
    HTTPRequestTypePlaceList,
    HTTPRequestTypePlaceDetail,
    HTTPRequestTypeLogin,
    HTTPRequestTypeDoctorLogin,
    HTTPRequestTypeChangePassword,
    HTTPRequestTypeActiveConcernDetail,
    HTTPRequestTypeDoctorConcernList,
    HTTPRequestTypeStaffList,
    HTTPRequestTypeDoctorInfo,
} HTTPRequestType;

typedef enum {
    jServerError = 0,
    jSuccess,
    jInvalidResponse,
    jNetworkError,
    jFailResponse,
}ErrorCode;
//Social Media ID
