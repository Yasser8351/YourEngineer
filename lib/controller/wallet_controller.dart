import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import 'package:your_engineer/model/transactions_history_model.dart';
import '../app_config/api_url.dart';
import '../enum/all_enum.dart';
import '../sharedpref/user_share_pref.dart';
import '../utilits/helper.dart';

class WalletController extends GetxController {
  final _shared = SharedPrefUser();
  LoadingState loadingState = LoadingState.initial;
  List<TransactionsHistory> listTransactionsHistory = [];
  TransactionsHistoryModel transactionsHistoryModel = TransactionsHistoryModel(
      totalItems: 0, transactionsHistory: [], totalPages: 0, currentPage: 0);

  String errorMessage = "";
  int pageNumber = 0;
  int totalItems = 0;
  Future<void> getTranHistory() async {
    pageNumber++;
    changeLoadingState(LoadingState.loading);

    try {
      var token = await _shared.getToken();

      var response = await Dio()
          .get(
            ApiUrl.getTransactionsHistory(page: pageNumber),
            options: Options(
              headers: ApiUrl.getHeader(token: token),
            ),
          )
          .timeout(Duration(seconds: ApiUrl.timeoutDuration));

      myLog("response", response);

      if (response.statusCode == 200) {
        changeLoadingState(LoadingState.loaded);

        var res = await json.decode(json.encode(response.data));

        transactionsHistoryModel = TransactionsHistoryModel.fromJson(res);

        totalItems = transactionsHistoryModel.totalItems;
        listTransactionsHistory = transactionsHistoryModel.transactionsHistory;

        // listTransactionsHistory.addAll(listTransactionsHistory);

        myLog("length", listTransactionsHistory.length);

        if (listTransactionsHistory.length == 0) {
          errorMessage = "لايوجد سجل دفعيات";
          changeLoadingState(LoadingState.noDataFound);
        }
      } else {
        errorMessage = response.data['msg'];
        changeLoadingState(
          LoadingState.error,
        );
      }
    } catch (error) {
      changeLoadingState(LoadingState.error);

      handlingCatchError(
        error: error,
        changeLoadingState: () => changeLoadingState(loadingState),
        errorMessageUpdate: (message) => errorMessageUpdate(message),
      );
    }
  }

  //////////////////// methode helper ///////////////

  changeLoadingState(LoadingState _isLoading) {
    loadingState = _isLoading;

    update();
  }

  errorMessageUpdate(String error) {
    errorMessage = error;
    myLog("errorMessage", errorMessage);
    update();
  }
}
