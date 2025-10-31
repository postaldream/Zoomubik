import 'package:flutter/material.dart';

void main() => runApp(ZoomubikApp());

class ZoomubikApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zoomubik',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zoomubik'),
      ),
      body: Center(
        child: Text(
          'Bienvenida a Zoomubik',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
