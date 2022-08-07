import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/models/requests/edit_user_info_request.dart';
import 'package:chefsandmeals_customer/src/models/requests/index.dart';
import 'package:chefsandmeals_customer/src/models/requests/login_with_social_request.dart';
import 'package:chefsandmeals_customer/src/models/requests/subscribe_email_and_phone.dart';
import 'package:chefsandmeals_customer/src/models/requests/verify_Email_otp_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/external_authentication_providers_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_country_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/index.dart';
import 'package:chefsandmeals_customer/src/models/responses/login_with_social_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/user_email_and_phone_verification_status.dart';
import 'package:chefsandmeals_customer/src/models/responses/user_info_for_edit.dart';
import 'package:chefsandmeals_customer/src/models/responses/user_info_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/verify_signup_otp_response.dart';
import 'package:chefsandmeals_customer/src/modules/apiEndpoints.dart';

import 'local_user_info_repository.dart';

abstract class IUserManagementRepository {
  Future<SignUpResponse> signUp(SignUpRequest request);

  Future<VerifySignUpOtpResponse> verifySignUpOTP(
      VerifyPhoneOtpRequest request);

  Future<ResendSignUpOtpResponse> resendVerifyOTP(PhoneRequest request);

  Future<LoginResponse> loginWithEmail(LoginRequest request);

  Future<void> logOut();

  Future<SendPasswordResetCodeByEmailResponse> sendPasswordResetCodeByEmail(
      EmailRequest request);

  Future<SendPasswordResetCodeByMobileResponse> sendPasswordResetCodeByMobile(
      PhoneRequest request);

  Future<VerifyPasswordResetCodeByMobileResponse>
      verifyPasswordResetCodeByMobile(VerifyPhoneOtpRequest request);

  Future<VerifyPasswordResetCodeByEmailResponse> verifyPasswordResetCodeByEmail(
      VerifyEmailOtpRequest request);

  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request);

  Future<ExternalAuthenticateProvidersResponse> getExternalAuthProviders();

  Future<LoginWithSocialResponse> SignInWithSocial(
      LoginWithSocialRequest request);

  Future<UserInfoResponse> getCurrentUserInfo(int id);

  Future<UserInfoForEdit> getUserInfoForEdit(int id);

  Future<GetAllCountryAndStateResponse> getAllCountry();

  Future<GetAllCountryAndStateResponse> getAllState(int cId);

  Future<bool> editProfile(EditUserInfoRequest request);

  Future<UserEmailAndPhoneVerificationStatus>
      userEmailAndPhoneVerificationStatus(int userId);

  Future<bool> sendVerificationOTPToPhone(String phone);

  Future<bool> sendVerificationOTPToEmail(String email);

  Future<bool> verifyOTPToPhone({String phone, String code});

  Future<bool> verifyOTPToEmail({String email, String code});

  Future<bool> subscribeEmailAndPhone(
      SubscribeEmailAndPhone subscribeEmailAndPhone);
}

class UserManagementRepository implements IUserManagementRepository {
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());

  final Dio _dio = Dio(BaseOptions(
    followRedirects: false,
    // will not throw errors
    validateStatus: (status) => true,
  ));

  @override
  Future<SignUpResponse> signUp(SignUpRequest request) async {
    final response = await _dio.post(CREATE_USER, data: request.toJson());

    SignUpResponse signUpResponse = SignUpResponse.fromMap(response.data);
    return signUpResponse;
  }

  @override
  Future<VerifySignUpOtpResponse> verifySignUpOTP(
      VerifyPhoneOtpRequest request) async {
    try {
      final response =
          await _dio.post(VERIFY_SIGNUP_OTP, data: request.toJson());
      VerifySignUpOtpResponse verifySignUpOtpResponse =
          VerifySignUpOtpResponse.fromMap(response.data);
      return verifySignUpOtpResponse;
    } catch (e) {
      throw Exception("Unable to Verify OTP");
    }
  }

  @override
  Future<ResendSignUpOtpResponse> resendVerifyOTP(PhoneRequest request) async {
    try {
      final response =
          await _dio.post(RESEND_SIGNUP_OTP, data: request.toJson());
      ResendSignUpOtpResponse resendSignUpOtpResponse =
          ResendSignUpOtpResponse.fromMap(response.data);

      return resendSignUpOtpResponse;
    } catch (e) {
      throw Exception("Unable to Send OTP");
    }
  }

  @override
  Future<LoginResponse> loginWithEmail(LoginRequest request) async {
    try {
      final response =
          await _dio.post(LOGIN_WITH_EMAIL, data: request.toJson());
      LoginResponse loginResponse = LoginResponse.fromMap(response.data);
      return loginResponse;
    } catch (e) {
      throw Exception("Unable to Login");
    }
  }

  @override
  Future<void> logOut() async {
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    try {
      await _dio.get(LOGOUT);
    } catch (e) {
      throw Exception("Unable to LogOut");
    }
  }

  @override
  Future<SendPasswordResetCodeByEmailResponse> sendPasswordResetCodeByEmail(
      EmailRequest request) async {
    try {
      final response = await _dio.post(SEND_PASSWORD_RESET_CODE_BY_EMAIL,
          data: request.toJson());
      SendPasswordResetCodeByEmailResponse senPasswordResetCodeByEmailResponse =
          SendPasswordResetCodeByEmailResponse.fromMap(response.data);
      return senPasswordResetCodeByEmailResponse;
    } catch (e) {
      throw Exception("Unable to send code");
    }
  }

  @override
  Future<SendPasswordResetCodeByMobileResponse> sendPasswordResetCodeByMobile(
      PhoneRequest request) async {
    try {
      final response = await _dio.post(SEND_PASSWORD_RESET_CODE_BY_MOBILE,
          data: request.toJson());
      SendPasswordResetCodeByMobileResponse
          sendPasswordResetCodeByMobileResponse =
          SendPasswordResetCodeByMobileResponse.fromMap(response.data);
      return sendPasswordResetCodeByMobileResponse;
    } catch (e) {
      throw Exception("Unable to send OTP");
    }
  }

  @override
  Future<VerifyPasswordResetCodeByMobileResponse>
      verifyPasswordResetCodeByMobile(VerifyPhoneOtpRequest request) async {
    final response = await _dio.post(VERIFY_PASSWORD_RESET_CODE_BY_MOBILE,
        data: request.toJson());
    VerifyPasswordResetCodeByMobileResponse
        verifyPasswordResetCodeByMobileResponse =
        VerifyPasswordResetCodeByMobileResponse.fromMap(response.data);
    return verifyPasswordResetCodeByMobileResponse;
  }

  @override
  Future<VerifyPasswordResetCodeByEmailResponse> verifyPasswordResetCodeByEmail(
      VerifyEmailOtpRequest request) async {
    final response = await _dio.post(VERIFY_PASSWORD_RESET_CODE_BY_EMAIL,
        data: request.toJson());
    VerifyPasswordResetCodeByEmailResponse
        verifyPasswordResetCodeByEmailResponse =
        VerifyPasswordResetCodeByEmailResponse.fromMap(response.data);
    return verifyPasswordResetCodeByEmailResponse;
  }

  @override
  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequest request) async {
    final response = await _dio.post(RESET_PASSWORD, data: request.toJson());
    ResetPasswordResponse resetPasswordResponse =
        ResetPasswordResponse.fromMap(response.data);
    return resetPasswordResponse;
  }

  @override
  Future<ExternalAuthenticateProvidersResponse>
      getExternalAuthProviders() async {
    final response = await _dio.get(GET_EXTERNAL_AUTH_PROVIDERS);
    ExternalAuthenticateProvidersResponse
        externalAuthenticateProvidersResponse =
        ExternalAuthenticateProvidersResponse.fromMap(response.data);
    return externalAuthenticateProvidersResponse;
  }

  @override
  Future<LoginWithSocialResponse> SignInWithSocial(
      LoginWithSocialRequest request) async {
    final response = await _dio.post(LOGIN_WITH_SOCIAL, data: request.toJson());
    LoginWithSocialResponse loginWithSocialResponse =
        LoginWithSocialResponse.fromMap(response.data);
    return loginWithSocialResponse;
  }

  @override
  Future<UserInfoResponse> getCurrentUserInfo(int id) async {
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response = await _dio.get("$GET_USER_INFORMATION" + "?userId=$id");
    UserInfoResponse userInfoResponse = UserInfoResponse.fromMap(response.data);
    return userInfoResponse;
  }

  @override
  Future<UserInfoForEdit> getUserInfoForEdit(int id) async {
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response =
        await _dio.get("$GET_USER_INFORMATION_FOR_EDIT" + "?userId=$id");
    UserInfoForEdit userInfoForEdit = UserInfoForEdit.fromMap(response.data);
    return userInfoForEdit;
  }

  @override
  Future<GetAllCountryAndStateResponse> getAllCountry() async {
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response = await _dio.get(GET_ALL_COUNTRY);
    GetAllCountryAndStateResponse getAllCountryResponse =
        GetAllCountryAndStateResponse.fromMap(response.data);
    return getAllCountryResponse;
  }

  @override
  Future<GetAllCountryAndStateResponse> getAllState(int cId) async {
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response = await _dio.get("$GET_ALL_STATE" + "?countryId=$cId");
    GetAllCountryAndStateResponse getAllCountryResponse =
        GetAllCountryAndStateResponse.fromMap(response.data);
    return getAllCountryResponse;
  }

  @override
  Future<bool> editProfile(EditUserInfoRequest request) async {
    var result = false;
    print("Request : ${request.toJson()}");
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response = await _dio.post(EDIT_PROFILE, data: request.toJson());
    print("STC : ${response.statusCode}");

    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }

  @override
  Future<UserEmailAndPhoneVerificationStatus>
      userEmailAndPhoneVerificationStatus(int userId) async {
    print("CALL REPO");
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response =
        await _dio.post("$EMAIL_AND_PHONE_STATUS" + "?userId=$userId");
    print("RESPONSE : ${response.data.toString()}");
    UserEmailAndPhoneVerificationStatus status =
        UserEmailAndPhoneVerificationStatus.fromMap(response.data);
    return status;
  }

  @override
  Future<bool> sendVerificationOTPToPhone(String phone) async {
    var result = false;
    final token = await _userInfoRepository.getToken();
    var data = {"phoneNumber": phone};
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response =
        await _dio.post("$PHONE_VERIFICATION_CODE_SEND", data: data);
    print("VERIFY PHONE :${response.toString()}");
    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }

  @override
  Future<bool> verifyOTPToPhone({String phone = '', String code = ''}) async {
    var result = false;
    final token = await _userInfoRepository.getToken();
    var data = {"phoneNumber": phone, "code": code};
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response = await _dio.post("$PHONE_VERIFY_CODE", data: data);
    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }

  @override
  Future<bool> sendVerificationOTPToEmail(String email) async {
    var result = false;
    final token = await _userInfoRepository.getToken();
    var data = {"email": email};
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response =
        await _dio.post("$EMAIL_VERIFICATION_CODE_SEND", data: data);
    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }

  @override
  Future<bool> verifyOTPToEmail(
      {String? email, String? code, int? userId}) async {
    var result = false;
    final token = await _userInfoRepository.getToken();
    var data = {"email": email, "confirmationCode": code, "userId": userId};
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response = await _dio.post("$EMAIL_VERIFY_CODE", data: data);
    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }

  @override
  Future<bool> subscribeEmailAndPhone(
      SubscribeEmailAndPhone subscribeEmailAndPhone) async {
    var result = false;
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response = await _dio.post("$SUBSCRIBE_EMAIL_PHONE",
        data: subscribeEmailAndPhone.toMap());
    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }
}
