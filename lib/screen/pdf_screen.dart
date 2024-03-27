// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// class PDFScreen extends StatefulWidget {
//   const PDFScreen({super.key, required this.filePath});
//   final filePath;

//   @override
//   State<PDFScreen> createState() => _PDFScreenState();
// }

// class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
//   final Completer<PDFViewController> _controller =
//       Completer<PDFViewController>();
//   int? pages = 0;
//   int? currentPage = 0;
//   bool isReady = false;
//   String errorMessage = '';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Display the downloaded PDF
//       body: Stack(
//         children: <Widget>[
//           PDFView(
//             // filePath: widget.filePath,
//             filePath: "http://www.pdf995.com/samples/pdf.pdf",
//             enableSwipe: false,
//             swipeHorizontal: true,
//             autoSpacing: false,
//             pageFling: true,
//             pageSnap: true,
//             defaultPage: currentPage!,
//             fitPolicy: FitPolicy.BOTH,
//             preventLinkNavigation:
//                 false, // if set to true the link is handled in flutter
//             onRender: (_pages) {
//               setState(() {
//                 pages = _pages;
//                 isReady = true;
//               });
//             },
//             onError: (error) {
//               setState(() {
//                 errorMessage = error.toString();
//                 log('$error: ${error.toString()}');
//               });
//             },
//             onPageError: (page, error) {
//               setState(() {
//                 errorMessage = '$page: ${error.toString()}';
//               });
//               log('$page: ${error.toString()}');
//             },
//             onViewCreated: (PDFViewController pdfViewController) {
//               _controller.complete(pdfViewController);
//             },
//             onLinkHandler: (String? uri) {
//               print('goto uri: $uri');
//             },
//             onPageChanged: (int? page, int? total) {
//               print('page change: $page/$total');
//               setState(() {
//                 currentPage = page;
//               });
//             },
//           ),
//           errorMessage.isEmpty
//               ? !isReady
//                   ? Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : Container()
//               : Center(
//                   child: Text(errorMessage),
//                 )
//         ],
//       ),
//     );
//   }
// }

//PDFScreen
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFScreen extends StatelessWidget {
  const PDFScreen({super.key, required this.filePath});
  final filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //"http://www.pdf995.com/samples/pdf.pdf"
        appBar: _getAppBar(context),
        body: SfPdfViewer.network(filePath));
  }
}

_getAppBar(BuildContext context) {
  return AppBar(
    title: Padding(
      padding: EdgeInsets.only(top: 10),
    ),
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.navigate_before, size: 40),
      color: Colors.white,
    ),
  );
}
