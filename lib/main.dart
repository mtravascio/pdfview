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
