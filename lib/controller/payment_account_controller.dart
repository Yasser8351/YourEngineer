import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import '../app_config/api_url.dart';
import '../app_config/app_config.dart';
import '../debugger/my_debuger.dart';
import '../enum/all_enum.dart';
import '../model/payment_accounts_model/credit_card_model.dart';
import '../model/payment_accounts_model/paypal_model.dart';
import '../sharedpref/user_share_pref.dart';
import '../utilits/helper.dart';
import 'package:http/http.dart' as http;

class PaymentAccountsController extends GetxController {
  var loadingState = LoadingState.initial.obs;
  final _shared = SharedPrefUser();
  PaypalModel paypalModel =
      PaypalModel(id: '', email: '', createdAt: '', updatedAt: '');
  CreditCardModel creditCardModel = CreditCardModel(name: '', number: '');
  // ApiResponse apiResponse = ApiResponse();
  bool isloding = false;
  String message = "";
  String emailAccount = "";
  String creditCardAccount = "";
  // bool get status => _status;
  // bool _status = false;

  @override
  onInit() {
    super.onInit();
    getPaypal();
    getCreditcard();
  }

  Future<void> getPaypal() async {
    loadingState(LoadingState.loading);

    try {
      var token = await _shared.getToken();

      var response = await http
          .get(
            headers: ApiUrl.getHeader(token: token),
            Uri.parse(ApiUrl.getPaypal),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      myLog(
        'statusCode : ${response.statusCode} \n',
        'response : ${response.body}',
      );

      if (response.statusCode == 200) {
        paypalModel = paypalModelFromJson(response.body);
        emailAccount = paypalModel.email;
        loadingState(LoadingState.loaded);
      } else if (response.statusCode == 403) {
        message = "دخول غير مصرح به";
        loadingState(LoadingState.error);
      } else {
        loadingState(LoadingState.error);
      }
    } on SocketException {
      message = AppConfig.noNet;

      loadingState(LoadingState.error);
    } catch (error) {
      loadingState(LoadingState.error);

      if (error is TimeoutException) {
        message = AppConfig.timeOut;

        showseuessToast(error.toString());
      } else if (error.toString().contains(
          'DioError [DioErrorType.response]: Http status error [401]')) {
        showseuessToast(AppConfig.unAutaristion);
      } else {
        message = AppConfig.noNet;

        showseuessToast(error.toString());
      }

      myLog("catch error getPaypal: ", error.toString());
    }
    // return apiResponse;
  }

  Future<void> getCreditcard() async {
    loadingState(LoadingState.loading);

    try {
      var token = await _shared.getToken();

      var response = await http
          .get(
            headers: ApiUrl.getHeader(token: token),
            Uri.parse(ApiUrl.getCreditcard),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      myLog(
        'statusCode : ${response.statusCode} \n',
        'response : ${response.body}',
      );

      if (response.statusCode == 200) {
        creditCardModel = creditCardModelFromJson(response.body);

        creditCardAccount = creditCardModel.number;
        loadingState(LoadingState.loaded);
      } else if (response.statusCode == 403) {
        message = "دخول غير مصرح به";
        loadingState(LoadingState.error);
      } else {
        loadingState(LoadingState.error);
      }
    } on SocketException {
      message = AppConfig.noNet;

      loadingState(LoadingState.error);
    } catch (error) {
      loadingState(LoadingState.error);

      if (error is TimeoutException) {
        message = AppConfig.timeOut;

        showseuessToast(error.toString());
      } else if (error.toString().contains(
          'DioError [DioErrorType.response]: Http status error [401]')) {
        showseuessToast(AppConfig.unAutaristion);
      } else {
        message = AppConfig.noNet;

        showseuessToast(error.toString());
      }

      myLog("catch error getCreditcard: ", error.toString());
    }
    // return apiResponse;
  }
}
