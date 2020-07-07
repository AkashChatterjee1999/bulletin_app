import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '_injector_.dart';
import 'Mvp_classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
var Gsearch = new TextEditingController();
var ob = new volatile_backend();
int to_display = 1;
Future<List<broad_cast_msgs>> c1;
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
  void initState(){
    super.initState();
    c1 = ob.fetchBroadcast();
  }
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
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              SizedBox(height: ht*0.02,),
              Center(
                child: Container(
                  height: ht*0.24,
                  width: wd*0.35,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('images/logo.png'),fit: BoxFit.contain),
                  ),
                ),
              ),
              SizedBox(height: ht*0.02,),
              SizedBox(height: ht*0.002,width: wd*0.02,child: Container(color:Colors.black),),
              ListTile(
                title: Text("Profile"),
                subtitle: Text("This is the option for you profile"),
                leading: Icon(Icons.person),
                //TODO: implement the todo function here
              ),
              ListTile(
                title: Text("Notifications"),
                subtitle: Text("Check your notifications here"),
                leading: Icon(Icons.notifications_active),
                //TODO: implement the todo function here
              )
            ],
          ),
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
           ),
           child: Row(
             children: <Widget>[
               Expanded(
                 child: IconButton(
                   onPressed: (){
                   },
                   icon: Icon(
                     Icons.tab,
                     color: Colors.black,
                     size: 30.0,
                   ),
                 ),
               ), //for news feed
               Expanded(
                 child: IconButton(
                   icon: Icon(
                     Icons.all_inclusive,
                     color: Colors.black,
                     size: 30.0,
                   ),
                   onPressed: (){
                     setState(() {

                     });
                   },
                 ),
               ),//for broadcast messages
               Expanded(
                 child: IconButton(
                   hoverColor: Colors.blue,
                   onPressed: (){
                      setState(() {
                        to_display = 1;
                        c1 = ob.fetchBroadcast();
                        c1.then((result){
                          print("No. of records fetched: "+result.length.toString());
                        }).catchError((e){
                          print(e);
                        });
                      });
                   },
                   icon: Icon(
                     Icons.public,
                     color: Colors.black,
                     size: 30.0,
                   ),
                 ),
               ),//for public grps
               Expanded(
                 child: IconButton(
                   icon: Icon(
                     Icons.lock,
                     color: Colors.black,
                     size: 30.0,
                   ),
                 ),
               ),//for private grp
               Expanded(
                 child: IconButton(
                   icon: Icon(
                     Icons.person_pin_circle,
                     color: Colors.black,
                     size: 30.0,
                   ),
                 ),
               )
             ],
           ),
         ),
         FutureBuilder(
           future: c1,
           builder: (_,snapshot){
             if(snapshot.connectionState==ConnectionState.waiting)
                return CircularProgressIndicator();
             else if(snapshot.hasData){
                return __display_broadcast_msgs__(_,snapshot.data,ht,wd);
                 //else return Text("");
               }
             else return Center(child:Text("Error loading data"));
           },
         ),
       ],
     )
    );
  }
  Widget __display_broadcast_msgs__(BuildContext _,List<broad_cast_msgs> query,var ht,var wd){
    return ListView.builder(
        itemCount: query.length,
        shrinkWrap: true,
        itemBuilder: (_,i){
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: Colors.blue,width: 2.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
                child: Column(
                  children: <Widget>[
                    Text(query[i].msg_head,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                    SizedBox(height: ht*0.02,),
                    Text(query[i].msg,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w200),),
                    SizedBox(height: ht*0.02,),
                    Text("Posted on  :"+query[i].tstmp,style: TextStyle(fontSize: 10.0,fontWeight: FontWeight.w400),)
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
