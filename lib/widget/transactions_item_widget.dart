import 'package:flutter/material.dart';
import 'package:your_engineer/model/transactions_history_model.dart';
import 'package:your_engineer/utilits/helper.dart';
// import '/util/all_enum.dart';

class TransactionItemWidget extends StatelessWidget {
  final TransactionsHistory history;
  const TransactionItemWidget({
    Key? key,
    required this.history,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(4),
        child: Material(
          elevation: 7,
          shadowColor: Colors.white30,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: Colors.black12,
              width: 0.3,
            ),
          ),
          child: Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Text(
                        //   history.user.email,
                        //   overflow: TextOverflow.clip,
                        //   style: TextStyle(
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.w600,
                        //       color: colorScheme.primary),
                        //   softWrap: true,
                        // ),
                        // SizedBox(
                        //   height: size.height * 0.01,
                        // ),
                        Text(
                          history.amount.toString() + " + ",
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color:
                                // transactionsType == TransactionsType.deposit
                                //     ? colorScheme.secondary
                                //     :
                                Colors.green.shade500,
                            // Colors.red.shade500,
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        history.user.email,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,

                          // color: colorScheme.primary,
                        ),
                        softWrap: true,
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        dateFormat(history.createdAt),
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                        softWrap: true,
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
