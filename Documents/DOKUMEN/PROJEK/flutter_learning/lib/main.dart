import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(home: new HalamanBeranda()));
}

class HalamanBeranda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: const Color.fromARGB(255, 250, 245, 210),
        child: new Center(
          child: new Text(
            "Hallo, Kemang",
            style: new TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ),
    );
  }
}
