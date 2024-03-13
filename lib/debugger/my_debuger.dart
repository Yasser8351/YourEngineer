import 'dart:developer';

int count = 1;

class MyDebugger {
  static const bool _isDebugMode = false;

  static void p(
      {required Object thisValue,
      String? methodName,
      required dynamic msg,
      bool isError = false}) {
    if (_isDebugMode) {
      log(
        'TAG__Method: $methodName() _Msg: [$msg]',
        sequenceNumber: count,
        name: thisValue.runtimeType.toString(),
        error: isError ? msg : null,
      );
      count++;
    }
  }
}

myLog(dynamic key, dynamic value) {
  // return log("");
  return log(" $key :  ${value.toString()}");
}
