import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class pdfOrizontalView extends StatefulWidget {
  pdfOrizontalView({Key? key}) : super(key: key);

  int _actualPageNumber = 1, _allPagesCount = 1;

  final pdfController = PdfController(
    document: PdfDocument.openAsset('assets/esame.pdf'),
    //initialPage: 3,
  );

  @override
  State<pdfOrizontalView> createState() => _pdfOrizontalViewState();
}

class _pdfOrizontalViewState extends State<pdfOrizontalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orizontal Scroll View'),
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
                child: const Text(" - "),
                onPressed: () {
                  //widget.pdfController.jumpToPage(2);
                  //  -- or --
                  widget.pdfController.animateToPage(
                      (widget._actualPageNumber > 1)
                          ? --widget._actualPageNumber
                          : 1,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.ease);
                },
              ),
              Text("Page: " +
                  widget._actualPageNumber.toString() +
                  "/" +
                  widget._allPagesCount.toString()),
              ElevatedButton(
                child: const Text(" + "),
                onPressed: () {
                  //widget.pdfController.jumpToPage(2);
                  //  -- or --
                  widget.pdfController.animateToPage(
                      (widget._actualPageNumber < widget._allPagesCount)
                          ? ++widget._actualPageNumber
                          : widget._allPagesCount,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.ease);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
