import 'package:chefsandmeals_customer/src/common/domainUrl.dart';

const GET_NEAREST_HUB_LIST = DOMAIN_URL +
    "/api/services/app/PublicPagesCommon/GetNearestHubsByUserLocation";
const GET_FILTERED_HUB_LIST =
    DOMAIN_URL + "/api/services/app/PublicPagesCommon/GetAllHubForDropdown";

const GET_POPULAR_RESTAURANT_SHORT_LIST_BY_HUB =
    DOMAIN_URL + "/api/services/app/MobileAppCommon/GetTopStoresByHub";
const GET_POPULAR_RESTAURANT_FULL_LIST_BY_HUB =
    DOMAIN_URL + "/api/services/app/MobileAppCommon/GetAllStoresByHub";
const GET_RESTAURANT_DETAILS_BY_ID =
    DOMAIN_URL + "/api/services/app/MobileAppCommon/GetStoreDetails";

const GET_POPULAR_CATEGORY_SHORT_LIST_BY_HUB = DOMAIN_URL +
    "/api/services/app/MobileAppCommon/GetTopProductCategoriesByHub";
const GET_POPULAR_CATEGORY_FULL_LIST_BY_HUB = DOMAIN_URL +
    "/api/services/app/MobileAppCommon/GetAllProductCategoriesByHub";
const GET_PRODUCT_BY_CATEGORY_AND_HUB = DOMAIN_URL +
    "/api/services/app/MobileAppCommon/GetAllProductsByHubAndCategory";

const GET_TRENDING_PRODUCT_LIST_BY_HUB =
    DOMAIN_URL + "/api/services/app/MobileAppCommon/GetTopProductsByHub";

const CREATE_USER =
    DOMAIN_URL + "/api/services/app/MobileAppCommon/CustomerRegister";

const VERIFY_SIGNUP_OTP =
    DOMAIN_URL + "/api/services/app/MobileAppCommon/VerifyRegisterOTP";

const RESEND_SIGNUP_OTP =
    DOMAIN_URL + "/api/services/app/MobileAppCommon/ResendRegisterOTP";

const LOGIN_WITH_EMAIL = DOMAIN_URL + "/api/TokenAuth/AuthenticateForApp";

const LOGOUT = DOMAIN_URL + "/api/TokenAuth/LogOut";

const SEND_PASSWORD_RESET_CODE_BY_EMAIL = DOMAIN_URL +
    "/api/services/app/MobileAppCommon/SendPasswordResetCodeByEmail";

const SEND_PASSWORD_RESET_CODE_BY_MOBILE = DOMAIN_URL +
    "/api/services/app/MobileAppCommon/SendPasswordResetCodeByPhone";

const VERIFY_PASSWORD_RESET_CODE_BY_EMAIL = DOMAIN_URL +
    "/api/services/app/MobileAppCommon/VerifyPasswordResetCodeByEmail";

const VERIFY_PASSWORD_RESET_CODE_BY_MOBILE = DOMAIN_URL +
    "/api/services/app/MobileAppCommon/VerifyPasswordResetCodeByPhone";

const RESET_PASSWORD =
    DOMAIN_URL + "/api/services/app/MobileAppCommon/ResetPassword";

const GET_EXTERNAL_AUTH_PROVIDERS =
    DOMAIN_URL + "/api/TokenAuth/GetExternalAuthenticationProviders";

const LOGIN_WITH_SOCIAL =
    DOMAIN_URL + "/api/TokenAuth/ExternalAuthenticateForApp";

const GET_TRENDING_PRODUCT =
    DOMAIN_URL + "/api/services/app/MobileAppCommon/GetTopProductsByHub";

const GET_USER_INFORMATION =
    DOMAIN_URL + "/api/services/app/Session/GetCurrentLoginInformationsForApp";

const GET_USER_INFORMATION_FOR_EDIT =
    DOMAIN_URL + "/api/services/app/MobileAppCommon/GetProfileForEdit";

const GET_ALL_COUNTRY = DOMAIN_URL +
    "/api/services/app/ContactAddresses/GetAllCountryForTableDropdown";

const GET_ALL_STATE =
    DOMAIN_URL + "/api/services/app/ContactAddresses/GetAllStateForLookupTable";

const EDIT_PROFILE =
    DOMAIN_URL + "/api/services/app/MobileAppCommon/EditProfile";

const EMAIL_AND_PHONE_STATUS =
    DOMAIN_URL + "/api/services/app/MobileAppCommon/UserPhoneAndEmailDetails";

const PHONE_VERIFICATION_CODE_SEND =
    DOMAIN_URL + "/api/services/app/Profile/SendVerificationSms";

const PHONE_VERIFY_CODE =
    DOMAIN_URL + "/api/services/app/Profile/VerifySmsCode";

const EMAIL_VERIFICATION_CODE_SEND =
    DOMAIN_URL + "/api/services/app/MobileAppCommon/SendEmailConfirmationCode";

const EMAIL_VERIFY_CODE = DOMAIN_URL +
    "/api/services/app/MobileAppCommon/VerifyEmailConfirmationCode";

const SUBSCRIBE_EMAIL_PHONE =
    DOMAIN_URL + "/api/services/app/MobileAppCommon/EmailAndSmsSubscription";

///**********Test Domain Url**************
const GET_POPULOR_STORE =
    TEST_DOMAIN_URL + "/api/services/app/MobileAppCommon/GetTopStoresByHub";

const GET_ALL_POPULOR_STORE =
    TEST_DOMAIN_URL + "/api/services/app/MobileAppCommon/GetAllStoresByHub";

const GET_TOP_PRODUCT_CATEGORY = TEST_DOMAIN_URL +
    "/api/services/app/MobileAppCommon/GetTopProductCategoriesByHub";

const GET_ALL_PRODUCT_CATEGORY = TEST_DOMAIN_URL +
    "/api/services/app/MobileAppCommon/GetAllProductCategoriesByHub";

const GET_PRODUCT_CATEGORY_AND_HUB = TEST_DOMAIN_URL +
    "/api/services/app/MobileAppCommon/GetAllProductsByHubAndCategory";

const ADD_PRODUCT_TO_CART =
    TEST_DOMAIN_URL + "/api/services/app/MobileAppCommon/AddToCart";
const ADD_PRODUCT_TO_WISHLIST =
    TEST_DOMAIN_URL + "/api/services/app/WishLists/SaveProductAsFavorite";

const UPDATE_PRODUCT_TO_CART =
    TEST_DOMAIN_URL + "/api/services/app/MobileAppCommon/UpdateCartQuantity";

const DELETE_CART_ITEM =
    TEST_DOMAIN_URL + "/api/services/app/MobileAppCommon/DeleteCartItem";
const DELETE_WISHLIST_ITEM =
    TEST_DOMAIN_URL + "/api/services/app/WishLists/Delete";

const GET_ALL_CART_ITEM = TEST_DOMAIN_URL +
    "/api/services/app/MobileAppCommon/GetAllShoppingCartItemsByContact";
const GET_ALL_WISHLIST_ITEM =
    TEST_DOMAIN_URL + "/api/services/app/WishLists/GetAllByContactAndProductId";
const GET_ALL_SYNC_CONTACT =
    TEST_DOMAIN_URL + "/api/services/app/MobileAppCommon/GetAllSyncedContact";
const POST_ALL_CONTACT =
    TEST_DOMAIN_URL + "/api/services/app/MobileAppCommon/SaveBulkContactBySync";
const POST_REFFERAL_ALL_CONTACT =
    TEST_DOMAIN_URL + "/api/services/app/MobileAppCommon/BulkContactRefer";
const POST_SINGLE_REFER =
    TEST_DOMAIN_URL + "/api/services/app/MobileAppCommon/ContactRefer";
const POST_ADD_NEW_CONTACT =
    TEST_DOMAIN_URL + "/api/services/app/MobileAppCommon/ReferNewContact";
const DELETE__CONTACT =
    TEST_DOMAIN_URL + "/api/services/app/MobileAppCommon/DeleteSyncedContact";

const GET_TAX_RATE =
    TEST_DOMAIN_URL + "/api/services/app/PublicPagesCommon/GetTaxRateByZipCode";

const GET_ALL_DELIVERY_TYPE = TEST_DOMAIN_URL +
    "/api/services/app/PublicPagesCommon/GetAllDeliveryTypeForTableDropdown";

const GET_ALL_PAYMENT_TYPE =
    TEST_DOMAIN_URL + "/api/services/app/MobileAppCommon/GetAllPaymentType";

const GET_DELIVERY_CHARGE_AND_SERVICES = TEST_DOMAIN_URL +
    "/api/services/app/StoreSettings/GetStoreSettingByStoreId";

const CREATE_ORDER =
    TEST_DOMAIN_URL + "/api/services/app/MobileAppCommon/CreateOrder";

const CREATE_ORDER_IN_SQUARE =
    TEST_DOMAIN_URL + "/api/services/app/PublicPagesCommon/CreatePayment";

///ORDER
const GET_ORDER_BY_CONTACT =
    TEST_DOMAIN_URL + "/api/services/app/MobileAppCommon/GetAllOrdersByContact";

///Address
const POST_ADD_NEW_ADDRESS =
    TEST_DOMAIN_URL + "/api/services/app/ContactAddresses/CreateOrEdit";
const GET_ALL_ADDRESS =
    TEST_DOMAIN_URL + "/api/services/app/ContactAddresses/GetAllByContactId";
const DELETE_ADDRESS =
    TEST_DOMAIN_URL + "/api/services/app/ContactAddresses/Delete";

//RecentView product

const GET_RECENT_VIEW_PRODUCT = TEST_DOMAIN_URL +
    "/api/services/app/MobileAppCommon/RecentlyViewedProducts";

const GET_RECENT_VIEW_STORE =
    TEST_DOMAIN_URL + "/api/services/app/MobileAppCommon/RecentlyViewedStores";

const CLEAR_CART =
    TEST_DOMAIN_URL + "/api/services/app/MobileAppCommon/DeleteAllCartItem";

const GET_PAYMENT_SDK_DETAILS = TEST_DOMAIN_URL +
    "/api/services/app/PublicPagesCommon/GetSquarePaymentCredentials";

abstract class ApiEndPoints {
  static const topCategoriesByStore = DOMAIN_URL +
      "/api/services/app/MobileAppCommon/GetTopProductCategoriesByStore";
  static const allCategoriesByStore = DOMAIN_URL +
      "/api/services/app/MobileAppCommon/GetAllProductCategoriesByStore";
  static const topProductsByStore =
      DOMAIN_URL + "/api/services/app/MobileAppCommon/GetAllTopProductsByStore";
  static const allProductsByStoreAndCategory = DOMAIN_URL +
      "/api/services/app/MobileAppCommon/GetAllProductsByStoreAndCategory";

  static String allProductMediasByProductId = DOMAIN_URL +
      "/api/services/app/PublicPagesCommon/GetAllProductMediasByProductId";

  static String getProductReviews = DOMAIN_URL +
      "/api/services/app/PublicPagesCommon/GetAllProductReviewsByProductBySp";
  static String customerRecommendations =
      DOMAIN_URL + "/api/services/app/ProductCustomerMaps/CreateOrEdit";
}
