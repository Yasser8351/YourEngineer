import 'package:flutter/material.dart';

import '../../app_config/app_config.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key, required this.onTap}) : super(key: key);
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      height: 50,
      width: size.width,
      child: TextField(
        // controller: widget.searchlist,
        onSubmitted: (String v) {
          //  widget.onSearch();
        },
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          //focusColor: Colors.grey,
          // fillColor: Colors.grey,
          // disabledBorder: OutlineInputBorder(
          //   // borderSide: const BorderSide(
          //   //     color: Color.fromARGB(255, 31, 30, 30), width: 1.0),
          //   borderRadius: BorderRadius.circular(10.0),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(
          //       color: Color.fromARGB(255, 202, 202, 202), width: 1.0),
          //   borderRadius: BorderRadius.circular(10.0),
          // ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.clear,
              //   size: widget.searchlist.text.isEmpty ? 0 : 20,
              color: Colors.grey,
            ),
            iconSize: 0, //iconSize: widget.isSearch ? 0 : 18,
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
      ),
    );
  }
}
