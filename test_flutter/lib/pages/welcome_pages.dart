import 'package:flutter/material.dart';

import 'package:test_flutter/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();

  static void isFirstEntrance(bool isFirst) async {
    AuthRepository.firstLogin = isFirst;
    SharedPreferences prefs =
        await SharedPreferences.getInstance(); // Хранилище
    if (isFirst) {
      prefs.getBool('banner') ?? true;
    } else {
      prefs.setBool('banner', false);
    }
  }
}

int _widgetId = 1;

class _WelcomePageState extends State<WelcomePage> {
  Widget _renderWidget() {
    if (_widgetId == 1) {
      return _renderWidget1();
    } else if (_widgetId == 2) {
      return _renderWidget2();
    } else {
      return _renderWidget3();
    }
  }

  void _updateWidget() {
    setState(() {
      if (_widgetId == 1) {
        _widgetId = 2;
      } else if (_widgetId == 2) {
        _widgetId = 3;
      } else {
        _widgetId = 1;
      }
    });
  }

  Widget _renderWidget1() {
    return Container(
      key: Key('first'),
      width: 300,
      height: 50,
      child: const Center(
        child: Text('Welcome Page №1',
            style: TextStyle(fontSize: 24, color: Colors.black)),
      ),
    );
  }

  Widget _renderWidget2() {
    return Container(
      key: Key('second'),
      width: 300,
      height: 50,
      child: const Center(
        child: Text('Welcome Page №2',
            style: TextStyle(fontSize: 24, color: Colors.black)),
      ),
    );
  }

  Widget _renderWidget3() {
    return Container(
        key: Key('third'),
        width: 300,
        height: 126,
        child: Center(
          child: Column(
            children: [
              const Text('Welcome Page №3',
                  style: TextStyle(fontSize: 24, color: Colors.black)),
              RaisedButton(
                child: const Text('To Main'),
                onPressed: () {
                  WelcomePage.isFirstEntrance(false);
                  Navigator.popAndPushNamed(context, '/mainContent');
                },
              ),
            ],
          ),
        ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 300),
          child: Column(
            children: [
              AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: _renderWidget(),
              ),
              RaisedButton(
                child: const Text('Next'),
                onPressed: () {
                  _updateWidget();
                },
              ),
              Text('$_widgetId / 3',
                  style: TextStyle(fontSize: 24, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
