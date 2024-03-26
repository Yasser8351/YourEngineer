import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import 'package:your_engineer/enum/all_enum.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';
import 'package:dio/dio.dart';

/*
 /// methode helper
  changeLoadingState(LoadingState state, LoadingType loadingType) {
    if (loadingType == LoadingType.uploadPayment) {
      loadingStateUploadPayment = state;
    } else {
      loadingStateGenerateReceipt = state;
    }

    update();
  }

  errorMessageUpdate(String error) {
    errorMessage = error;
    update();
  }


  getData() async {
    changeLoadingState(LoadingState.loading, LoadingType.login);

    try {
      var response = await transactionServices
          .getTransactionsByUser(userId: "")
          .timeout(Duration(seconds: ApiUrl.timeLimit));

      changeLoadingState(LoadingState.loaded, LoadingType.login);
      if (response.code == 0) {
        listTransactions = response.data;
      } else {}
    } catch (error) {
      log("error message : $error");

      changeLoadingState(LoadingState.error, LoadingType.login);

      
        handlingCatchError(
          error: error,
          changeLoadingState: () =>
              changeLoadingState(LoadingState.error, LoadingType.login),
          errorMessageUpdate: (message) => errorMessageUpdate(message),
        );
      
    }
  }
*/

handlingCatchError({
  String? messageNoData,
  required Object error,
  required Function() changeLoadingState,
  bool showSnackbar = false,
  // Function()? tryAgain,
  required Function(String message) errorMessageUpdate,
}) {
  changeLoadingState();

  if (error is DioError) {
    if (error.toString().contains("TimeoutException") ||
        error.toString().contains("connection timeout")) {
      errorMessageUpdate(AppConfig.noNet.tr);
    } else if (error.toString().contains("SocketException") ||
        error.toString().contains("Network is unreachable")) {
      errorMessageUpdate(AppConfig.noNet.tr);
    } else if (error.response!.statusCode == 400) {
      errorMessageUpdate(error.response!.data['message'].toString());
      // errorMessageUpdate(messageNoData ?? AppConfig.noData.tr);
    } else if (error.response!.statusCode == 500) {
      errorMessageUpdate(error.response!.data['message'].toString());
    } else {
      if (error.response != null) {
        errorMessageUpdate(error.response!.data['message']);
      }
    }
  }
}

clearText(TextEditingController controller) {
  controller.clear();
}

showErrorToast(message) {
  Get.snackbar(message, '',
      snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
}

showseuessToast(message) {
  Get.snackbar(message, '',
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green);
}

navigatorToNewScreens(BuildContext context, screen) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => screen),
  );
}

class Helper {
  static void showError({
    required BuildContext context,
    required String subtitle,
  }) {
    Flushbar(
      message: subtitle,
      backgroundColor: Colors.red,
      padding: const EdgeInsets.all(24.0),
      margin: const EdgeInsets.all(24.0),
      duration: const Duration(seconds: 3),
      // textDirection: TextDirection.rtl,
      borderRadius: BorderRadius.circular(10.0),
    ).show(context);
  }

  static void showseuess({
    required BuildContext context,
    required String subtitle,
  }) {
    Flushbar(
      message: subtitle,
      backgroundColor: Colors.green,
      padding: const EdgeInsets.all(24.0),
      margin: const EdgeInsets.all(24.0),
      duration: const Duration(seconds: 3),
      borderRadius: BorderRadius.circular(10.0),
    ).show(context);
  }
}

dateFormat(String dateString) {
  return "${DateFormat('yyyy/MM/dd hh:mm').format(DateTime.parse(dateString))}";
}

getProjectStatus(String status) {
  myLog('status', status);
  if (status.contains("Open")) {
    return ProjectStatus.open;
  } else if (status.contains('In-Progress')) {
    return ProjectStatus.inProgress;
  } else {
    return ProjectStatus.close;
  }
}

dialogApp() {
  Get.dialog(
    Dialog(
      backgroundColor: Colors.white70,
      child: WillPopScope(
        onWillPop: () async => true,
        child: Container(
          height: Get.height * .4,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.green,
                radius: Get.height * .06,
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                  size: Get.height * .05,
                ),
              ),
              SizedBox(height: Get.height * .027),
              TextWidget(
                  title: "شكرا لك \n تم تسجيل حسابك بنجاح ",
                  // "تم تسجيل حسابك بنجاح \n سيتم مراجعة حسابك وتأكيدة خلال 24 ساعة",
                  fontSize: Get.height * .02,
                  color: Colors.black),
            ],
          ),
        ),
      ),
    ),
  );
}
