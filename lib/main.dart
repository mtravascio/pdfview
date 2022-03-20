import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'pdfpinchview.dart';
import 'pdfview.dart';

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
      //home: MyHomePage(title: 'Flutter Pdf View Demo'),
      //home: pdfVerticalView(),
      //home: pdfOrizontalView(),
      routes: mainRouting(),
    );
  }

  Map<String, WidgetBuilder> mainRouting() {
    return {
      '/': (context) => HomePage(),
      '/verticalview': (context) => pdfVerticalView(),
      '/orizontalview': (context) => pdfOrizontalView(),
    };
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pdf View Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('Go to the Vertical View'),
              onPressed: () {
                Navigator.pushNamed(context, '/verticalview');
              },
            ),
            ElevatedButton(
              child: const Text('Go to the Orizontal View'),
              onPressed: () {
                Navigator.pushNamed(context, '/orizontalview');
              },
            ),
          ],
        ),
      ),
    );
  }
}

/*
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  int _actualPageNumber = 1, _allPagesCount = 1;
  final String title;

  final pdfPinchController = PdfControllerPinch(
    document: PdfDocument.openAsset('assets/esame.pdf'),
    //initialPage: 3,
  );

  /* final pdfController = PdfController(
    document: PdfDocument.openAsset('assets/esame.pdf'),
    //initialPage: 3,
  );*/

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
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: PdfViewPinch(
              controller: widget.pdfPinchController,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: Text(" - "),
                onPressed: () {
                  //widget.pdfController.jumpToPage(2);
                  //  -- or --
                  widget.pdfPinchController.animateToPage(
                      pageNumber: (widget._actualPageNumber > 1)
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
              ElevatedButton(
                child: Text(" + "),
                onPressed: () {
                  //widget.pdfController.jumpToPage(2);
                  //  -- or --
                  widget.pdfPinchController.animateToPage(
                      pageNumber:
                          (widget._actualPageNumber < widget._allPagesCount)
                              ? ++widget._actualPageNumber
                              : widget._allPagesCount,
                      duration: Duration(milliseconds: 250),
                      curve: Curves.ease);
                },
              ),
            ],
          ),
        ],
      ),
    ); // End First Return
*/
/*    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
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
              ElevatedButton(
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
            ],
          ),
        ],
      ),
    ); // End Second return */
/*  
  }
}
*/