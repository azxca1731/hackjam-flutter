import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final String apiKey;

  MainPage(this.apiKey);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hack Jam"),
      ),
      body: Center(
        child: Text(apiKey),
      ),
    );
  }
}
