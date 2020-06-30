import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class H_page extends StatefulWidget {
  @override
  _H_pageState createState() => _H_pageState();
}

class _H_pageState extends State<H_page> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new First_Page_home(),
    );
  }
}
class First_Page_home extends StatefulWidget {
  @override
  _First_Page_homeState createState() => _First_Page_homeState();
}

class _First_Page_homeState extends State<First_Page_home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("I got your backend"),
      ),
    );
  }
}
