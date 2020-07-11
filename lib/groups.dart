import 'package:flutter/material.dart';
import '_injector_.dart';
import 'Create_group.dart';
import 'App_themes_languages.dart';
volatile_backend ob = new volatile_backend();
var Gsearch = new TextEditingController();
class Groups extends StatefulWidget {
  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Groups_Page(),
    );
  }
}
class Groups_Page extends StatefulWidget {
  @override
  _Groups_PageState createState() => _Groups_PageState();
}

class _Groups_PageState extends State<Groups_Page> {
  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    String uname = current_user.name.split(' ')[0].toString();
    return new Scaffold(
      appBar: Create_appbar(ht,wd,Gsearch),
      drawer: Create_drawer(wd,ht,uname,context),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(height: ht*0.02,),
          SizedBox(height:ht*0.03),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Join Groups',
                style: TextStyle(color: Colors.black,fontSize: 40.0, fontWeight: FontWeight.bold)
            ),
          ),
          SizedBox(height: ht*0.02,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Your Groups',
                style: TextStyle(color: Colors.black,fontSize: 40.0, fontWeight: FontWeight.bold)
            ),
          ),
          SizedBox(height: ht*0.02,),
        ],
      ),
    );
  }
}