// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:ishrahli_app/models/user_model.dart';
// import 'package:ishrahli_app/providers/user_provider.dart';
// import 'package:ishrahli_app/screens/payment/payment_status_screen.dart';
// import 'package:ishrahli_app/util/navigators.dart';
// import 'package:ishrahli_app/widgets/global_app_bar.dart';
// import 'package:ishrahli_app/widgets/global_button.dart';
// import 'package:ishrahli_app/widgets/global_image_network_with_loading.dart';
// import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
// import 'package:provider/provider.dart';

// final String mAPIKey = dotenv.get("PAYMENT_API_KEY");

// class PaymentScreen extends StatefulWidget {
//   final double totalAmount;
//   const PaymentScreen({super.key, required this.totalAmount});

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   String response = '';
//   late final cxt = context;
//   List<MFPaymentMethod> paymentMethods = [];
//   List<bool> isSelected = [];
//   int selectedPaymentMethodIndex = -1;

//   @override
//   void initState() {
//     super.initState();
//     initiate();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   initiate() async {
//     if (mAPIKey.isEmpty) {
//       setState(() {
//         response =
//             "Missing API Token Key.. You can get it from here: https://myfatoorah.readme.io/docs/test-token";
//       });
//       return;
//     }

//     await MFSDK.init(mAPIKey, MFCountry.KUWAIT, MFEnvironment.LIVE);

//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await initiatePayment();
//       await initiateSession();
//     });
//   }

//   log(Object object) {
//     var json = const JsonEncoder.withIndent('  ').convert(object);
//     setState(() {
//       if (kDebugMode) {
//         print(json);
//       }
//       response = json;
//     });
//   }

//   // Initiate Payment
//   initiatePayment() async {
//     var request = MFInitiatePaymentRequest(
//         invoiceAmount: widget.totalAmount,
//         currencyIso: MFCurrencyISO.KUWAIT_KWD);

//     await MFSDK
//         .initiatePayment(request, MFLanguage.ENGLISH)
//         .then((value) => {
//               log(value),
//               // paymentMethods.addAll(value.paymentMethods!),
//               paymentMethods.add(value.paymentMethods!.first),
//               selectedPaymentMethodIndex = paymentMethods.isEmpty ? -1 : 0,
//               for (int i = 0; i < paymentMethods.length; i++)
//                 isSelected.add(false)
//             })
//         .catchError((error) => {log(error.message)});
//   }

//   // Execute Regular Payment
//   executeRegularPayment(int paymentMethodId, UserModel user) async {
//     var request = MFExecutePaymentRequest(
//       displayCurrencyIso: MFCurrencyISO.KUWAIT_KWD,
//       paymentMethodId: 1,
//       invoiceValue: widget.totalAmount,
//        customerName: user.firstName,
//       customerAddress: MFCustomerAddres(
//         street: user.info.street,
//         addressInstructions: user.info.city,
//         block: user.info.subStreet,
//         houseBuildingNo: user.info.home,
//       ),
//       customerMobile: user.phone,
//       customerReference: user.userId.toString(),
//       mobileCountryCode: user.countryCode.toString(),
//     );
//     await MFSDK.executePayment(request, MFLanguage.ENGLISH, (invoiceId) {
//       log(invoiceId);
//     }).then((value) {
//       if (cxt.mounted) {
//         Navigators.pushReplacement(
//             context, PaymentStatusScreen(response: value));
//       }
//     }).catchError((error) {
//       if (cxt.mounted) {
//         Navigators.pushReplacement(context, PaymentStatusScreen(error: error));
//       }
//     });

//     // if(result is MFGetPaymentStatusResponse ){
//     //   _navigateToPaymentStatus(value);

//     // }
//   }

//   // Cancel Recurring Payment
//   cancelRecurringPayment() async {
//     await MFSDK
//         .cancelRecurringPayment("Put RecurringId here", MFLanguage.ENGLISH)
//         .then((value) => log(value))
//         .catchError((error) => {log(error.message)});
//   }

//   setPaymentMethodSelected(int index, bool value) {
//     for (int i = 0; i < isSelected.length; i++) {
//       if (i == index) {
//         isSelected[i] = value;
//         if (value) {
//           selectedPaymentMethodIndex = index;
//         } else {
//           selectedPaymentMethodIndex = -1;
//         }
//       } else {
//         isSelected[i] = false;
//       }
//     }
//   }

//   executePayment() {
//     final userModel = Provider.of<UserProvider>(context, listen: false).model;
//     if (selectedPaymentMethodIndex == -1 || userModel == null) {
//       setState(() {
//         response = "Please select payment method first";
//       });
//     } else {
//       executeRegularPayment(
//           paymentMethods[selectedPaymentMethodIndex].paymentMethodId!,
//           userModel);
//     }
//   }

//   initiateSession() async {
//     MFInitiateSessionRequest initiateSessionRequest =
//         MFInitiateSessionRequest();
//     await MFSDK
//         .initiateSession(initiateSessionRequest, (bin) {
//           log(bin);
//         })
//         .then((value) => {log(value)})
//         .catchError((error) => {log(error.message)});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context).colorScheme;

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: const GlobalAppBar(
//         hasLogo: true,
//         title: 'صفحة الدفع',
//         backAction: true,
//       ),
//       body: paymentMethods.isEmpty
//           ? Center(
//               child: Container(
//                 color: Colors.white.withOpacity(0.8),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SpinKitSpinningLines(
//                       color: Theme.of(context).colorScheme.primary,
//                       size: 40,
//                     ),
//                     SizedBox(height: 10.h),
//                     const Text("الرجاء الإنتظار"),
//                   ],
//                 ),
//               ),
//             )
//           : SafeArea(
//               child: Flex(
//                 direction: Axis.vertical,
//                 children: [
//                   Expanded(
//                     child: SingleChildScrollView(
//                       padding: const EdgeInsets.all(2.5),
//                       child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Directionality(
//                               textDirection: TextDirection.ltr,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border: Border.all(
//                                     width: 1.w,
//                                     color: theme.primary.withOpacity(0.2.sp),
//                                   ),
//                                   borderRadius: BorderRadius.circular(8.r),
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     _buildSingleDetailsItem(
//                                       leading: "Payment Method",
//                                       trailing: "Grand Total(KD)",
//                                       height: 40.h,
//                                       trailingStyle: TextStyle(
//                                         fontSize: 13.sp,
//                                         overflow: TextOverflow.ellipsis,
//                                         color: const Color(0xff868686),
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                       leadingStyle: TextStyle(
//                                         fontSize: 13.sp,
//                                         overflow: TextOverflow.ellipsis,
//                                         color: theme.primary,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                     ...List.generate(
//                                         paymentMethods.length,
//                                         (index) => _buildPaymentMethodItem(
//                                             paymentMethods[index], index))
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             GlobalButton(
//                               text: 'ادفع الأن',
//                               size: Size(double.infinity.w, 50.h),
//                               margin: EdgeInsets.symmetric(vertical: 5.sp),
//                               onTap: executePayment,
//                             ),
//                           ]),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget _buildPaymentMethodItem(MFPaymentMethod paymentMethod, int index) {
//     final theme = Theme.of(context).colorScheme;
//     return TextButton(
//       onPressed: () {
//         setState(() {
//           setPaymentMethodSelected(index, true);
//         });
//       },
//       child: Padding(
//         padding: EdgeInsets.only(right: 15.sp, bottom: 0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Transform.scale(
//               scale: 1,
//               child: Radio<MFPaymentMethod>(
//                 value: paymentMethod,
//                 materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                 groupValue: selectedPaymentMethodIndex == -1
//                     ? null
//                     : paymentMethods[selectedPaymentMethodIndex],
//                 fillColor: MaterialStateProperty.all(theme.primary),
//                 onChanged: null,
//               ),
//             ),
//             SizedBox(
//                 width: 40,
//                 child: globalCashedImageNetworkWithLoading(
//                     paymentMethod.imageUrl,
//                     radius: 0)),
//             SizedBox(width: 5.w),
//             Text(
//               paymentMethod.paymentMethodEn.toString(),
//               textAlign: TextAlign.start,
//               maxLines: 1,
//               style: TextStyle(
//                 fontSize: 15.sp,
//                 color: Colors.black,
//                 overflow: TextOverflow.ellipsis,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const Spacer(),
//             Text(
//               paymentMethod.totalAmount.toString(),
//               textAlign: TextAlign.start,
//               maxLines: 1,
//               style: TextStyle(
//                 fontSize: 13.sp,
//                 color: Colors.black,
//                 overflow: TextOverflow.ellipsis,
//                 fontWeight: FontWeight.w400,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSingleDetailsItem({
//     required String leading,
//     String? title,
//     TextStyle? leadingStyle,
//     TextStyle? trailingStyle,
//     String? trailing,
//     double? height,
//     BoxDecoration? decoration,
//   }) {
//     return Container(
//       height: height ?? 30.h,
//       decoration: decoration,
//       child: ListTile(
//         // minLeadingWidth: 90.w,

//         leading: Text(
//           leading,
//           textAlign: TextAlign.center,
//           maxLines: 1,
//           style: leadingStyle ??
//               TextStyle(
//                 fontSize: 13.sp,
//                 overflow: TextOverflow.ellipsis,
//                 // color: theme.primary,
//                 fontWeight: FontWeight.w500,
//               ),
//         ),
//         title: title == null
//             ? null
//             : Text(
//                 title,
//                 textAlign: TextAlign.start,
//                 maxLines: 1,
//                 style: TextStyle(
//                   fontSize: 13.sp,
//                   overflow: TextOverflow.ellipsis,
//                   color: const Color(0xff868686),
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//         trailing: trailing == null
//             ? null
//             : Text(
//                 trailing,
//                 textAlign: TextAlign.start,
//                 maxLines: 1,
//                 style: trailingStyle ??
//                     TextStyle(
//                       fontSize: 13.sp,
//                       overflow: TextOverflow.ellipsis,
//                       // color:   Colors.black,
//                       fontWeight: FontWeight.w400,
//                     ),
//               ),
//       ),
//     );
//   }
// }
