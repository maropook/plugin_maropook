import 'package:flutter/material.dart';

void main() {
  runApp(Navigator2test());
}

class Navigator2test extends StatefulWidget {
  @override
  State<Navigator2test> createState() => _Navigator2testState();
}

class _Navigator2testState extends State<Navigator2test> {
  int? _buttonId;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BooksApp',
        home: Navigator(
          pages: [
            MaterialPage(
                child: MenuPage(
              _toPage1,
              _toPage1,
              _toPage1,
            )),
            if (_buttonId == 1) MaterialPage(child: Page1()),
            if (_buttonId == 2) MaterialPage(child: Page1()),
            if (_buttonId == 3) MaterialPage(child: Page1()),
          ],
          onPopPage: (route, result) {
            if (!route.didPop(result)) {
              return false;
            }
            setState(() {
              _buttonId = null;
            });
            return true;
          },
        ));
  }

  void _toPage1() {
    setState(() {
      _buttonId = 1;
    });
  }
}

class MenuPage extends StatelessWidget {
  MenuPage(this.toPage1, this.toPage2, this.toPage3);

  final void Function()? toPage1;
  final void Function()? toPage2;
  final void Function()? toPage3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Menu Page'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: toPage1, child: Text('Page1')),
                ElevatedButton(onPressed: toPage2, child: Text('Page2')),
                ElevatedButton(onPressed: toPage2, child: Text('Page2'))
              ]),
        ));
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Page'),
      ),
      backgroundColor: Colors.red,
      body: Center(
        child: Text('More information Here'),
      ),
    );
  }
}
