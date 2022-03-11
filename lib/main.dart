import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pdf View Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Pdf View Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  int _actualPageNumber = 1, _allPagesCount = 0;
  final String title;
  final pdfController = PdfController(
    document: PdfDocument.openAsset('assets/esame.pdf'),
    //initialPage: 3,
  );

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Center(
            child: PdfView(
              controller: widget.pdfController,
              onDocumentLoaded: (document) {
                setState(() {
                  widget._allPagesCount = document.pagesCount;
                });
              },
              onPageChanged: (page) {
                setState(() {
                  widget._actualPageNumber = page;
                });
              },
            ),
          ),
          Row(
            children: [
              /*RaisedButton(
                child: Text("Page 1"),
                onPressed: () {
                  //widget.pdfController.jumpToPage(2);
                  //  -- or --
                  widget.pdfController.animateToPage(1,
                      duration: Duration(milliseconds: 250),
                      curve: Curves.ease);
                },
              ),
              RaisedButton(
                child: Text("Page 3"),
                onPressed: () {
                  //widget.pdfController.jumpToPage(3);
                  //  -- or --
                  widget.pdfController.animateToPage(3,
                      duration: Duration(seconds: 1), curve: Curves.linear);
                },
              ),*/
              RaisedButton(
                child: Text(" + "),
                onPressed: () {
                  //widget.pdfController.jumpToPage(2);
                  //  -- or --
                  widget.pdfController.animateToPage(
                      (widget._actualPageNumber < widget._allPagesCount)
                          ? ++widget._actualPageNumber
                          : widget._allPagesCount,
                      duration: Duration(milliseconds: 250),
                      curve: Curves.ease);
                },
              ),
              RaisedButton(
                child: Text(" - "),
                onPressed: () {
                  //widget.pdfController.jumpToPage(2);
                  //  -- or --
                  widget.pdfController.animateToPage(
                      (widget._actualPageNumber > 1)
                          ? --widget._actualPageNumber
                          : 1,
                      duration: Duration(milliseconds: 250),
                      curve: Curves.ease);
                },
              ),
              Text("Page: " +
                  widget._actualPageNumber.toString() +
                  "/" +
                  widget._allPagesCount.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
