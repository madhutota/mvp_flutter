import 'package:flutter/material.dart';
import 'package:mvp_flutter/di/dependency_injection.dart';
import 'package:mvp_flutter/ui/news_home.dart';

void main() {
  NewsInjector.configure(Flavor.PROD);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
     home: Scaffold(body: NewsHomePage(),),
    );
  }
}