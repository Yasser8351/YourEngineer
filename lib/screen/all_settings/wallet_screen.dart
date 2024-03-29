import 'package:flutter/material.dart';
import 'package:your_engineer/screen/all_settings/transaction_moble.dart';
import 'package:your_engineer/screen/all_settings/transactions_item_widget.dart';
// import 'package:wasel/api/store.dart';

class WalletScreen extends StatefulWidget {
  // final Wallet wallet;
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  // var _showChart = false;

  List<TransactionsHistory> listHistory = [];
  getTransactionHistory() {}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        color: Colors.white,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "wallet",
              softWrap: true,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: size.height * 0.036,
                  fontWeight: FontWeight.w600),
            ),
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
                            horizontal: size.width * 0.022,
                            vertical: size.width * 0.018,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.circular(40)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add_circle,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(
                                width: size.width * 0.016,
                              ),
                              Text(
                                "recharge",
                                softWrap: true,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height * 0.019,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.032,
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
                  )
                ],
              ),
            ),
            ///////////
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              "Transactions",
              softWrap: true,
              overflow: TextOverflow.clip,
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: size.height * 0.032,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  // await _orderProvider.reload(language, false);
                },
                child: FutureBuilder<List<TransactionsHistory>>(
                    future: getTransactionHistory(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("networkError");
                        // return ErrorReTryWidget(

                        //   message: appLanguage.errorNetwork,
                        //   errorType: ErrorType.networkError,
                        //   showRetryButton: true,
                        //   retryFun: () {
                        //     setState(() {});
                        //   },
                        // );
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                          return Center(child: CircularProgressIndicator());
                        case ConnectionState.done:
                          if (snapshot.data!.length == 0)
                            return Text("No data");
                          // return ErrorReTryWidget(
                          //   message: appLanguage.errorNoDataFound,
                          //   errorType: ErrorType.noDataFound,
                          //   showRetryButton: true,
                          //   retryFun: () {
                          //     setState(() {});
                          //   },
                          // );
                          else
                            return ListView.builder(
                              itemCount: listHistory.length,
                              itemBuilder: (context, index) {
                                return TransactionItemWidget(
                                  history: listHistory[index].results,
                                  // transactionsType: listTransactionTest[index],
                                );
                              },
                            );
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
