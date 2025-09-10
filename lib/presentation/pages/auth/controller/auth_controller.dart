import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:tanod_tractor/data/models/remeber_mode.dart';
import 'package:tanod_tractor/data/providers/network/api_provider.dart';
import 'package:tanod_tractor/domain/usecases/auth/otp_use_case.dart';
import 'package:tanod_tractor/presentation/router/route_page_strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../app/services/local_storage.dart';
import '../../../../data/models/static_page_data_model.dart';
import '../../../../data/providers/network/local_keys.dart';
import '../../../../data/repositories/login_provider/impl/remote_login_provider.dart';
import '../../../../data/repositories/login_provider/interface/ilogin_repository.dart';
import '../../../../data/repositories/static_provider/impl/remote_static_provider.dart';
import '../../../../data/repositories/static_provider/interface/static_repository.dart';
import '../../../../domain/entities/auth.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/usecases/auth/login_use_case.dart';
import '../../../../domain/usecases/auth/signup_use_case.dart';
import '../../../../main.dart';
import '../../base/base_controller.dart';

class AuthController extends GetxController with BaseController {
  ILoginRepository? loginRepository;
  var signupKey = GlobalKey<FormState>();
  var otpKey = GlobalKey<FormState>();
  IStaticRepository? iStaticRepository;
  var detailDataModel = Rxn<StaticPageDataModel>();
  var webViewController = WebViewController();

  AuthController(this._signUpUseCase, this._loginUseCase, this._otpUseCase);

  final SignUpUseCase _signUpUseCase;
  final LogInUseCase _loginUseCase;
  final OtpUseCase _otpUseCase;
  final store = Get.find<LocalStorageService>();
  PhoneNumber? phoneNumber;

  RxBool showPinView = false.obs;

  //Registration
  late TextEditingController emailC;
  TextEditingController nameC = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late TextEditingController otpC;
  late TextEditingController passwordC;
  late TextEditingController comfirmPasswordC;

  RxInt seconds = 30.obs;
  Timer? countDownTimer;

  RxBool passwordValidated = false.obs;

  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

//login
  TextEditingController emailLoginC = TextEditingController();
  TextEditingController forgotEmailController = TextEditingController();
  TextEditingController passwordLoginC = TextEditingController();

  RxBool isRememberMe = false.obs;

  var isLoggedIn = false.obs;
  var isObsureText = false.obs;
  var isPasswordValid = false.obs;
  var showSplash = true.obs;

  User? get user => store.user;

  @override
  void onInit() async {
    super.onInit();
    loginRepository = Get.put(RemoteILoginProvider());
    loginRepository = Get.put(RemoteILoginProvider());
    iStaticRepository = Get.put(RemoteStaticProvider());
    //Registration
    otpC = TextEditingController();
    emailC = TextEditingController();
    passwordC = TextEditingController();
    comfirmPasswordC = TextEditingController();

    // wether user is login or not
    isLoggedIn.value = store.user != null;
    if (isLoggedIn.value) {
      debugPrint('Token ---> ${store.user!.token}');
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //
        Future.delayed(const Duration(seconds: 1), () {
          Get.toNamed(RoutePage.dashboard);
        });
        Future.delayed(const Duration(seconds: 2), () {
          showSplash(false);
        });
      });
    } else {
      showSplash(false);
    }
    // Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    //   if (result == ConnectivityResult.none) {
    //     handleError(NoInternetException('No Internet connection'), () {});
    //   }
    // });
    getRememberMe();
  }

  startTimer() {
    seconds.value = 30;
    countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds = seconds - 1;
        seconds.refresh();
      } else {
        seconds.value = 30;
        seconds.refresh();
        countDownTimer!.cancel();
      }
    });
    update();
  }

  Future<void> signUp() async {
    emailLoginC.text = emailC.text;
    showLoading();

    try {
      await loginRepository
          ?.signUpApi(
              map: AuthEntity(
        email: emailC.text,
        name: nameC.text,
        otp: otpC.text,
        password: passwordC.text,
        fcmtoken: await FirebaseMessaging.instance.getToken(),
        confirmPassword: comfirmPasswordC.text,
      ).toMap())
          .then((value) {
        hideLoading();
        if (value != null && value.data != null) {
          showToast(value?.message ?? "");
          Get.offAllNamed(RoutePage.phone, arguments: value?.data?.id);
          clearAllFields();
        }
      });
    } catch (e) {
      hideLoading();
      handleError(e, () {});
    }
  }

  Future<void> login() async {
    showLoading();
    loginRepository
        ?.loginApi(
            map: AuthEntity(
      email: emailLoginC.text,
      fcmtoken: await FirebaseMessaging.instance.getToken(),
      password: passwordLoginC.text,
    ).toMap())
        .then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        if (value.data?.phoneVerified == false) {
          Get.toNamed(RoutePage.phone, arguments: value.data?.id);
        } else {
          box.write(tokenKeys, value.data?.rememberToken);
          box.write(roleType, value.data?.roleId);
          isLoggedIn.value = true;
          isLoggedIn.refresh();
          showToast(value.message ?? "");
          if (isRememberMe.isTrue) {
            saveRememberMe();
          } else {
            emailLoginC.clear();
            passwordLoginC.clear();
            saveRememberMe();
          }
          Get.offAllNamed(RoutePage.dashboard);

          emailLoginC.clear();
          passwordLoginC.clear();
          isRememberMe.value = false;
        }
      }
    }).onError((error, stackTrace) {
      hideLoading();
    });
  }

  Future<void> hitApiToSendEmailOtp() async {
    if (!GetUtils.isEmail(emailC.text)) {
      showToast("Please Enter Valid Email");
      return;
    }
    print(AuthEntity(
      email: emailC.text,
    ).toMap());
    showLoading();
    try {
      await _otpUseCase
          .execute(AuthEntity(
        email: emailC.text,
      ).toMap())
          .then((value) {
        hideLoading();
        showToast(value?.message ?? "");
      });
    } catch (e) {
      hideLoading();
      handleError(e, () {});
    }
  }

  Future<void> hitApiToSendOtp({userId}) async {
    if (phoneNumber == null) return;
    showLoading();
    Map<String, dynamic> map = {};
    map['user_id'] = userId;
    map['country_code'] = phoneNumber?.countryISOCode?.toLowerCase();
    map['phone_country'] = phoneNumber?.countryCode;
    map['phone'] = phoneNumber?.number;

    loginRepository?.sendOtpApi(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        startTimer();
        showPinView.value = true;
        showPinView.refresh();
        // showToast(value?.message??"");
        showToast("OTP is ${value.data?.otp}");
      }
    }).onError((error, stackTrace) {
      hideLoading();
    });
  }

  Future<void> hitApiToVerifyOtp({userId, otp}) async {
    if (phoneNumber == null) return;
    showLoading();
    Map<String, dynamic> map = {};
    map['user_id'] = userId;
    map['otp'] = otp;
    map['country_code'] = phoneNumber?.countryISOCode?.toLowerCase();
    map['phone_country'] = phoneNumber?.countryCode;
    map['phone'] = phoneNumber?.number;
    map['fcm_token'] = await FirebaseMessaging.instance.getToken();

    loginRepository?.verifyMobileOtpApi(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        showToast(value?.message ?? "");
        box.write(tokenKeys, value.data?.rememberToken);
        box.write(roleType, value.data?.roleId);
        Get.offAllNamed(RoutePage.dashboard);
      }
    }).onError((error, stackTrace) {
      hideLoading();
    });
  }

  Future<void> hitAPiForForgotPassword() async {
    showLoading();
    loginRepository?.forgotPasswordApi(
        map: {"email": forgotEmailController.text}).then((value) {
      hideLoading();
      if (value != null) {
        showToast(value.message);
        forgotEmailController.clear();
        Get.offAllNamed(RoutePage.signIn);
      }
    }).onError((error, stackTrace) {
      hideLoading();
    });
  }

  //here we save all details
  saveRememberMe() {
    box.write(
        rememberMe,
        jsonEncode(RememberModel(
            username: emailLoginC.text ?? "", password: passwordLoginC.text)));
  }

  //here we get all details
  getRememberMe() {
    if (box.read(rememberMe) != null) {
      Map<String, dynamic> map = jsonDecode(box.read(rememberMe));
      emailLoginC.text = map['username'];
      passwordLoginC.text = map['password'];
      if (emailLoginC.text.isNotEmpty && passwordLoginC.text.isNotEmpty) {
        isRememberMe.value = true;
        update();
      }
    }
  }

  logout() {
    isLoggedIn.value = false;
    store.user = null;
  }

  bool signUpValidation() {
    // final RegExp nameRegExp = RegExp(r"^[\p{L} ,.'-]*$",
    //     caseSensitive: false, unicode: true, dotAll: true);
    if (nameC.text.isEmpty) {
      handleError('Please Enter your Name', () {}, isBack: false);
      return false;
    } else if (!GetUtils.isEmail(emailC.text)) {
      handleError('Please Enter Valid Email', () {}, isBack: false);
      return false;
    // } else if (otpC.text.isEmpty) {
    //   handleError('Please Enter Valid Otp', () {}, isBack: false);
    //   return false;
    } else if (passwordC.text.length < 8) {
      handleError("Password! At Least 8 Characters ", () {}, isBack: false);
      return false;
    } else if (passwordC.text != comfirmPasswordC.text) {
      handleError("Password Don't Match", () {}, isBack: false);
      return false;
    } else if (passwordValidated.isFalse) {
      handleError("Password doesn't match with required validations", () {},
          isBack: false);
      return false;
    }
    return true;
  }

  bool loginValidation() {
    if (emailLoginC.text.isEmpty) {
      handleError('Email is Empty', () {}, isBack: false);
      return false;
    } else if (!GetUtils.isEmail(emailLoginC.text)) {
      handleError('Please Enter Valid Email', () {}, isBack: false);
      return false;
    } else if (passwordLoginC.text.length < 8) {
      handleError("Password! At Least 8 Characters ", () {}, isBack: false);
      return false;
    }
    return true;
  }

  bool passwordValidation() {
    if (passwordC.text.length < 8) {
      isPasswordValid(false);
      return false;
    } else if (passwordC.text != comfirmPasswordC.text) {
      isPasswordValid(false);

      return false;
    }
    isPasswordValid(true);
    return true;
  }

  forgotPasswordValidations() {
    if (forgotEmailController.text.isEmpty) {
      handleError('Email is Empty', () {}, isBack: false);
      return false;
    } else if (!GetUtils.isEmail(forgotEmailController.text)) {
      handleError('Please Enter Valid Email', () {}, isBack: false);
      return false;
    }
    return true;
  }

  Future hitApiToGetDetails({pageType}) async {
    showLoading("Loading");

    await iStaticRepository
        ?.pageDetails(map: {"page_type": pageType}).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        detailDataModel.value = value?.data;
        detailDataModel.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(error?.toString());
    });
  }

  clearAllFields() {
    // emailC.clear();
    nameC.clear();
    otpC.clear();
    passwordLoginC.text = passwordC.text;
    print("check all data ${passwordLoginC.text} and ${emailC.text}");
    //passwordC.clear();
    comfirmPasswordC.clear();
    update();
  }

  closeTimer() {
    if (countDownTimer != null) {
      countDownTimer?.cancel();
    }
    phoneController.clear();
    showPinView.value = false;
    seconds.value = 30;
    showPinView.refresh();
    seconds.refresh();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    closeTimer();

    super.dispose();
  }
}
