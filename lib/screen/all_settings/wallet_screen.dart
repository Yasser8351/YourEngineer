import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/controller/wallet_controller.dart';
import 'package:your_engineer/enum/all_enum.dart';
import 'package:your_engineer/widget/transactions_item_widget.dart';
import 'package:your_engineer/widget/shared_widgets/handling_data_view.dart';
// import 'package:wasel/api/store.dart';

class WalletScreen extends StatefulWidget {
  // final Wallet wallet;
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  // var _showChart = false;
  WalletController walletController = Get.find();

  @override
  void initState() {
    Future.delayed(Duration(), () {
      walletController.getTranHistory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Wallet",
        softWrap: true,
        overflow: TextOverflow.clip,
        style: TextStyle(
            color: Colors.white,
            fontSize: size.height * 0.03,
            fontWeight: FontWeight.w600),
      )),
      body: GetBuilder<WalletController>(
        builder: (controller) {
          return HandlingDataView(
            loadingState: controller.loadingState,
            errorMessage: controller.errorMessage,
            sizedBoxHeight: Get.height / 3,
            shimmerType: ShimmerType.shimmerListRectangular,
            tryAgan: () => controller.getTranHistory(),
            widget: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              color: Colors.white,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  ////////////
                  Container(
                    height: size.height * 0.24,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade900,
                          colorScheme.primary,
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'رصيدك الحالي :',
                              // appLanguage.currentBalance,
                              softWrap: true,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.height * 0.018,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              '   ',
                              softWrap: true,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.height * 0.018,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              "1000 \$",
                              softWrap: true,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.height * 0.038,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RechargeWidget(
                                text: "Recharge", icon: Icons.add_circle),
                            RechargeWidget(
                                text: "Remove", icon: Icons.remove_circle),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ///////////
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    AppConfig.paymentHistory.tr,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: size.height * 0.027,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.listTransactionsHistory.length,
                      itemBuilder: (context, index) {
                        return TransactionItemWidget(
                          history: controller.listTransactionsHistory[index],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RechargeWidget extends StatelessWidget {
  const RechargeWidget({super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) =>
            //         const RechargeCreditCardScreen(),
            //   ),
            // );
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Get.size.width * 0.022,
              vertical: Get.size.width * 0.018,
            ),
            decoration: BoxDecoration(
                color: Colors.white38, borderRadius: BorderRadius.circular(40)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: Get.size.width * 0.016,
                ),
                Text(
                  text,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Get.size.height * 0.019,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: Get.size.width * 0.032,
                ),
              ],
            ),
          ),
        ),
        // Image.asset(
        //   AppImage.logo,
        //   height: size.height * 0.04,
        // ),
      ],
    );
  }
}
