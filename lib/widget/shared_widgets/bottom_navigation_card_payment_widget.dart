import 'package:flutter/material.dart';
import 'package:your_engineer/widget/shared_widgets/button_widget.dart';
import 'package:your_engineer/widget/shared_widgets/card_with_image.dart';
import 'package:your_engineer/widget/shared_widgets/text_faild_widget.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../../../app_config/app_config.dart';

class BottomNavigationCardPaymentWidget extends StatelessWidget {
  const BottomNavigationCardPaymentWidget({
    Key? key,
    required this.size,
    required this.colorScheme,
    required this.expandedIndex,
  }) : super(key: key);
  final Size size;
  final ColorScheme colorScheme;
  final int expandedIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 0, left: 0),
        child: CardWithImage(
          height: size.height * .7,
          width: size.width,
          colors: colorScheme.onSurface,
          isBorderRadiusTopLefZero: true,
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 25),
            child: Builder(
              builder: (context) {
                if (expandedIndex == 0) {
                  return buildPayWithPayPal(colorScheme, size);
                }
                return buildPayWithVisa(colorScheme, size);
              },
            ),
          ),
        ),
      ),
    );
  }
}

buildPayWithPayPal(ColorScheme colorScheme, Size size) {
  TextEditingController payPalController = TextEditingController();
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(Icons.lock, color: colorScheme.primary),
          Text(
            AppConfig.paySecurely,
            style: TextStyle(
                fontSize: size.width * .045, color: colorScheme.primary),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      SizedBox(
        height: size.height * .05,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: TextWidget(
            title: AppConfig.amount,
            fontSize: size.width * .05,
            color: colorScheme.primary),
      ),
      TextFaildWidget(
        controller: payPalController,
        label: '',
        obscure: false,
        inputType: TextInputType.text,
        icon: const Icon(Icons.abc, color: Colors.amber),
      ),
      SizedBox(
        height: size.height * .05,
      ),
      ButtonWidget(
          title: "Recharge balance", color: colorScheme.primary, onTap: () {}),
    ],
  );
}

buildPayWithVisa(ColorScheme colorScheme, Size size) {
  TextEditingController fullNAmeController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(Icons.lock, color: colorScheme.primary),
          Text(
            AppConfig.paySecurely,
            style: TextStyle(
                fontSize: size.width * .045, color: colorScheme.primary),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      SizedBox(
        height: size.height * .03,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: TextWidget(
            title: AppConfig.amount,
            fontSize: size.width * .05,
            color: colorScheme.primary),
      ),
      TextFaildWidget(
        controller: amountController,
        label: '',
        obscure: false,
        inputType: TextInputType.text,
        icon: const Icon(Icons.abc, color: Colors.amber),
      ),
      SizedBox(
        height: size.height * .03,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: TextWidget(
            title: AppConfig.fullNameInCard,
            fontSize: size.width * .05,
            color: colorScheme.primary),
      ),
      TextFaildWidget(
        controller: fullNAmeController,
        label: '',
        obscure: false,
        inputType: TextInputType.text,
        icon: const Icon(Icons.abc, color: Colors.amber),
      ),
      SizedBox(
        height: size.height * .03,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: TextWidget(
            title: AppConfig.cardNumber,
            fontSize: size.width * .05,
            color: colorScheme.primary),
      ),
      TextFaildWidget(
        controller: cardNumberController,
        label: '',
        obscure: false,
        inputType: TextInputType.text,
        icon: const Icon(Icons.abc, color: Colors.amber),
      ),
      SizedBox(
        height: size.height * .05,
      ),
      ButtonWidget(
          title: "Recharge balance", color: colorScheme.primary, onTap: () {}),
    ],
  );
}

buildTextFaild(
  TextEditingController controller,
  String label,
  bool obscure,
  TextInputType inputType,
  Icon icon,
) {
  return TextField(
    // controller: widget.searchlist,
    onSubmitted: (String v) {
      //  widget.onSearch();
    },
    textInputAction: TextInputAction.search,
    decoration: InputDecoration(
      suffixIcon: IconButton(
        icon: const Icon(
          Icons.clear,
          color: Colors.grey,
        ),
        iconSize: 20, //iconSize: widget.isSearch ? 0 : 18,
        onPressed: () {
          //  widget.clearSearch();
        },
      ),
      prefixIcon: IconButton(
        alignment: Alignment.topCenter,
        onPressed: () {
          //   widget.onSearch();
        },
        icon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
      ),
      hintText: AppConfig.search,
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
        // borderSide: const BorderSide(color: Colors.black),
      ),
    ),
  );
}
