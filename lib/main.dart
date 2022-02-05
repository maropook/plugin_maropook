import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello/hello.dart';

import 'app_version.dart';

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
              _toPage2,
              _toPage3,
            )),
            if (_buttonId == 1) MaterialPage(child: Page1()),
            if (_buttonId == 2) MaterialPage(child: Page2()),
            if (_buttonId == 3) MaterialPage(child: Page3()),
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

  void _toPage2() {
    setState(() {
      _buttonId = 2;
    });
  }

  void _toPage3() {
    setState(() {
      _buttonId = 3;
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
                ElevatedButton(onPressed: toPage3, child: Text('Page2'))
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

class Page2 extends StatefulWidget {
  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  String _platformVersion = 'Unknown';
  String _platformVersion2 = 'Unknown2';

  Future<void> getPlatformState() async {
    String platformVersion;
    try {
      platformVersion =
          await Hello.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform verison';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> getNative() async {
    String platformVersion2;
    try {
      platformVersion2 =
          await Native.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion2 = 'Failed to get platform verison';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion2 = platformVersion2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Plugin example app')),
        body: Center(
            child: Column(
          children: [
            ElevatedButton(
                onPressed: getPlatformState, child: Text(_platformVersion)),
            ElevatedButton(
                onPressed: getNative, child: Text(_platformVersion2)),
          ],
        )));
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
