import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new HalamanBeranda(),
  ));
}

class HalamanBeranda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Makanan Bergizi Gratis"),
      ),
      body: new Center(
        child: new Text("Selamat Datang di Halaman Beranda Makanan Bergizi Gratis"),
      ),
    );
  }

}