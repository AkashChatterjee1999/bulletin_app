import 'dart:ui';
import 'package:flutter/material.dart';
import '_injector_.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
var Gsearch = new TextEditingController();
var ob = new volatile_backend();
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
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: new Row(
            children: <Widget>[
              SizedBox(width:360*0.02),
              Container(
                height: ht*0.07,
                width: wd*0.6,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: TextField(
                  controller: Gsearch,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: "Search Groups",
                  ),
                  style: TextStyle(color: Colors.black,fontSize: 16.0),
                ),
              )
            ],
          ),
          backgroundColor: Colors.blue,
        ),
        drawer: Drawer(
          elevation: 5.0,
        ),
        body: Container(
          child: news_feed()
        ),
      ),
    );
  }
}
class news_feed extends StatefulWidget {
  @override
  _news_feedState createState() => _news_feedState();
}

class _news_feedState extends State<news_feed> {
  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Container(
     child:Column(
       children: <Widget>[
         Container(
           height: ht*0.1,
           width: wd*1,
           decoration: BoxDecoration(
             color:Colors.blue
           ),
           child: Row(
             children: <Widget>[
               Expanded(
                 child: IconButton(
                   icon: Icon(
                     Icons.desktop_windows,
                     color: Colors.white,
                     size: 30.0,
                   ),
                 ),
               ), //for news feed
               Expanded(
                 child: IconButton(
                   icon: Icon(
                     Icons.all_inclusive,
                     color: Colors.white,
                     size: 30.0,
                   ),
                   onPressed: (){
                     setState(() {
                       ob.fetchBroadcast().then((result){
                         QuerySnapshot res = result;
                       }).catchError((e){
                         print(e);
                       });
                     });
                   },
                 ),
               ),//for broadcast messages
               Expanded(
                 child: IconButton(
                   icon: Icon(
                     Icons.public,
                     color: Colors.white,
                     size: 30.0,
                   ),
                 ),
               ),//for public grps
               Expanded(
                 child: IconButton(
                   icon: Icon(
                     Icons.lock,
                     color: Colors.white,
                     size: 30.0,
                   ),
                 ),
               ),//for private grp
               Expanded(
                 child: IconButton(
                   icon: Icon(
                     Icons.person_pin_circle,
                     color: Colors.white,
                     size: 30.0,
                   ),
                 ),
               )
             ],
           ),
         )
       ],
     )
    );
  }
}
