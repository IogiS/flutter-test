import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({ Key? key }) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 400),
          child: Column(
            children: [
              Text('Home Screen'),
              RaisedButton(
                child: Text('Log out'),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}