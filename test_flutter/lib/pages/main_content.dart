import 'package:flutter/material.dart';
import 'package:test_flutter/pages/goods_list.dart';
import 'package:test_flutter/pages/profile.dart';
import 'package:test_flutter/pages/welcome_pages.dart';

/// This is the main application widget.
class MainContent extends StatelessWidget {
  const MainContent({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  Widget animatedWidget = WelcomePage();
  Widget goodsLists = goodsList();
  Widget welcomePage = WelcomePage();
  Widget profile = Profile();

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Widget getBody() {
    if (this._selectedIndex == 0) {
      return this.welcomePage;
    } else if (this._selectedIndex == 1) {
      return this.profile;
    } else {
      return this.goodsLists;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      animatedWidget = getBody();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(child: child, scale: animation);
          },
          child: this.animatedWidget,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.badge),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Goods',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
