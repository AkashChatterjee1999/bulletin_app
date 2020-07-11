import 'package:flutter/material.dart';
import 'Create_group.dart';
import 'groups.dart';
Widget Create_appbar(var ht,var wd,TextEditingController Gsearch){
  return AppBar(
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
  );
}
Widget Create_drawer(var wd,var ht,String uname,BuildContext context) {
  return Drawer(
    elevation: 5.0,
    child: ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        SizedBox(height: ht * 0.02,),
        Center(
          child: Container(
            height: ht * 0.24,
            width: wd * 0.35,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/logo.png'), fit: BoxFit.contain),
            ),
          ),
        ),
        SizedBox(height: ht * 0.02,),
        SizedBox(height: ht * 0.002,
          width: wd * 0.02,
          child: Container(color: Colors.black),),
        SizedBox(height: ht * 0.02,),
        Container(
          child: Row(
            children: <Widget>[
              SizedBox(width: wd * 0.04),
              Text("Hi, " + uname,
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
              SizedBox(width: wd * 0.02,),
              CircleAvatar(
                child: Icon(Icons.person_pin, size: 32.0,),
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                maxRadius: 16.0,
              )
            ],
          ),
        ),
        SizedBox(height: ht * 0.016,),
        SizedBox(height: ht * 0.002,
          width: wd * 0.02,
          child: Container(color: Colors.black),),
        SizedBox(height: ht * 0.02,),
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
        ),
        ListTile(
          title: Text("Groups"),
          subtitle: Text("Check or add your groups here"),
          leading: Icon(Icons.group),
          onTap: () {
            Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new Groups()));
          },
        ),
        ListTile(
          title: Text("Create Group"),
          subtitle: Text("Create your group here"),
          leading: Icon(Icons.group_add),
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => new Create_group()));
          },
        ),
      ],
    ),
  );
}