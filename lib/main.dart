import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello/hello.dart';
import 'package:riverpod/riverpod.dart';

import 'app_version.dart';

void main() {
  runApp(ProviderScope(child: Navigator2test()));
}

final buttonIdProvider = StateProvider((ref) => 0);

class Navigator2test extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var buttonId = ref.watch(buttonIdProvider);
    return MaterialApp(
        home: Navigator(
            pages: [
          MaterialPage(child: MenuPage2()),
          if (buttonId == 1)
            MaterialPage(child: Page2())
          else if (buttonId == 2)
            MaterialPage(child: HelloPage())
        ],
            onPopPage: (route, result) {
              if (!route.didPop(result)) {
                return false;
              }
              ref.read(buttonIdProvider.state).state = 0;
              return true;
            }));
  }
}

class MenuPage2 extends ConsumerWidget {
  MenuPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('MenuPage')),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                ref.read(buttonIdProvider.state).state = 1;
              },
              child: Text('Page1')),
          ElevatedButton(
              onPressed: () {
                ref.read(buttonIdProvider.state).state = 2;
              },
              child: Text('Page2'))
        ],
      )),
    );
  }
}

class Page5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Navigator2test2 extends StatefulWidget {
  @override
  State<Navigator2test2> createState() => _Navigator2testState();
}

class _Navigator2testState extends State<Navigator2test2> {
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
  String _platformVersion = 'Unknown: HelloPlugin';
  String _platformVersion2 = 'Unknown: Native';

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

class Page3 extends StatefulWidget {
  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Navigator(
      pages: [
        MaterialPage(child: Navigator2test()),
      ],
    ));
  }
}

enum KanbanState { todo, doing, done }

class HelloPage extends StatefulWidget {
  const HelloPage({Key? key}) : super(key: key);

  @override
  State<HelloPage> createState() => _HelloState();
}

class _HelloState extends State<HelloPage> {
  String _platformVersion = 'Unknown';
  String _appVersion = 'unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initAppState();
  }

  Future<void> initAppState() async {
    String appVersion;
    try {
      appVersion = await Hello.appVersion ?? 'Unknown app version';
    } on PlatformException {
      appVersion = 'Failed to get App version.';
    }
    if (!mounted) return;
    setState(() {
      _appVersion = appVersion;
    });
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion =
          await Hello.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('platformVersion: $_platformVersion\n'),
              Text('appVersion: $_appVersion\n'),
              ElevatedButton(
                onPressed: initAppState,
                child: Text('appVersion: $_appVersion\n'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
