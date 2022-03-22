import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class pdfVerticalView extends StatefulWidget {
  pdfVerticalView({Key? key}) : super(key: key);
  int _actualPageNumber = 1, _allPagesCount = 0, _searchpage = 1;

  //final document= await PdfDocument.openAsset('assets/esame.pdf');

  final pdfPinchController = PdfControllerPinch(
    document: PdfDocument.openAsset('assets/esame.pdf'),
    //initialPage: 3,
  );

  @override
  State<pdfVerticalView> createState() => _pdfVerticalViewState();
}

class _pdfVerticalViewState extends State<pdfVerticalView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      appBar: AppBar(
        title: const Text("Vertical View"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                widget.pdfPinchController.previousPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut);
              },
              icon: const Icon(Icons.arrow_back)),
          IconButton(
              onPressed: () {
                widget.pdfPinchController.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeIn);
              },
              icon: const Icon(Icons.arrow_forward)),
          IconButton(
            onPressed: () => this._scaffoldKey.currentState?.showBottomSheet(
                  (ctx) => _buildBottomSheet(ctx),
                ),
            /*onPressed: () => showModalBottomSheet(
              context: context,
              builder: (ctx) => _buildBottomSheet(ctx),
            ),*/
            icon: const Icon(Icons.search),
            tooltip: 'Go To',
          )
        ],
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
//----------------------------------------------------------------------
/*              ElevatedButton(
                child: const Text(" - "),
                onPressed: () {
                  //widget.pdfController.jumpToPage(2);
                  //  -- or --
                  /*widget.pdfPinchController.animateToPage(
                      pageNumber: (widget._actualPageNumber > 1)
                          ? --widget._actualPageNumber
                          : 1,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.ease);*/
                  widget.pdfPinchController.previousPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut);
                },
              ),*/
//----------------------------------------------------------------------
              /*Text("Page: " +
                  widget._actualPageNumber.toString() +
                  "/" +
                  widget._allPagesCount.toString()),*/
//----------------------------------------------------------------------
              PdfPageNumber(
                controller: widget.pdfPinchController,
                // When `loadingState != PdfLoadingState.success`  `pagesCount` equals null_
                builder: (_, state, loadingState, pagesCount) => Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Page: " +
                        widget._actualPageNumber.toString() +
                        "/${pagesCount ?? 0}",
                    //style: const TextStyle(fontSize: 22),
                  ),
                ),
              ),
//----------------------------------------------------------------------
/*              ElevatedButton(
                child: const Text(" + "),
                onPressed: () {
                  //widget.pdfController.jumpToPage(2);
                  //  -- or --
                  /*widget.pdfPinchController.animateToPage(
                      pageNumber:
                          (widget._actualPageNumber < widget._allPagesCount)
                              ? ++widget._actualPageNumber
                              : widget._allPagesCount,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.ease);*/
                  widget.pdfPinchController.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeIn);
                },
              ),*/
//----------------------------------------------------------------------
            ],
          ),
        ],
      ),
    );
  }

  Container _buildBottomSheet(BuildContext context) {
    return Container(
      //height: 300,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: _buildPageNumberTextField(),
    );
  }

  Widget _buildPageNumberTextField() {
    return TextField(
      keyboardType: TextInputType.number,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: const InputDecoration(
        //icon: Icon(Icons.search),
        labelText: 'Go To Page:',
        border: OutlineInputBorder(),
      ),
      onSubmitted: (val) {
        widget._searchpage = int.parse(val);
        if (widget._searchpage < 1) {
          widget._searchpage = 1;
        } else if (widget._searchpage > widget._allPagesCount) {
          widget._searchpage = widget._allPagesCount;
        }
        widget.pdfPinchController.jumpToPage(widget._searchpage - 1);
        setState(() {
          widget._actualPageNumber = widget._searchpage;
        });
        Navigator.pop(context);
      },
    );
  }
}
