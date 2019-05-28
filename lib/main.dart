import 'package:flutter/material.dart';
import 'customListItem.dart';
void main() => runApp(new MyApp());
//无状态组件
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Startup Name Generator',
        home: new CustomListItem(),
        theme: new ThemeData(
            primaryColor: Colors.blue, primarySwatch: Colors.blue));
  }
}