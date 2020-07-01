import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'hello.dart';
import 'login.dart';
import 'land.dart';
import '_injector_.dart';
void main() => runApp(Signup());
QuerySnapshot data;
volatile_backend ob = new volatile_backend();
bool can1 = false,can2 = false,can3 = false,can4 = false,can5 = false;
class Signup extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bulletin App',
      home: home_page(),
    );
  }
}

class home_page extends StatefulWidget {
  @override
  _home_pageState createState() => _home_pageState();
}
class _home_pageState extends State<home_page> {
  var name = TextEditingController();
  var email = TextEditingController();
  var pass = TextEditingController();
  var pass1 = TextEditingController();
  var emp_id = TextEditingController();
  /*void initState(){
    super.initState();
    setState(() {
      ob.retrieve_data().then((result){
        data = result;
        print("Data fetched");
      });
    });
  }*/
  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _build_sign_up_form_(ht,wd),
    );
  }
  Widget _build_sign_up_form_(var ht,var wd){
    return Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            SizedBox(height: ht*0.06,),
            Center(
              child: Container(
                height: ht*0.24,
                width: wd*0.35,
                decoration: BoxDecoration(
                  //border: Border.all(width: 2.0),
                  image: DecorationImage(image: AssetImage('images/logo.png'),fit: BoxFit.contain),
                ),
              ),
            ),
            SizedBox(height: ht*0.014,),
            Center(child: Text("SIGN-UP",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.blue),)),
            SizedBox(height: ht*0.02,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                  suffixIcon: Icon(Icons.person_add),
                  labelText: "NAME",
                  hintText: "Your Name",
                  errorText: name.text.toString().length==0 && can1?"Name can't be empty":null,
                  ),
                  onChanged: (text){
                    print(can1);
                    if(text.length==0 && !can1) {
                      setState(() {
                      can1 = true;
                    });
                  }
                },
              ),//For the part of name
            ),
            SizedBox(height: ht*0.03,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: emp_id,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.insert_link),
                  labelText: "EMP-ID",
                  hintText: "Your ID",
                  errorText: emp_id.text.toString().length==0 && can2?"ID can't be empty":null,
                ),
                onChanged: (text){
                  if(text.length==0 && !can2) {
                    setState(() {
                      can2 = true;
                    });
                  }
                },
              ),
            ),//For the part of Employee id
            SizedBox(height: ht*0.03,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: pass,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.lock),
                  labelText: "PASSWORD",
                  hintText: "Your Password",
                  errorText: pass.text.toString().length<10 && can3?"Password can't be < 10":null,
                ),
                obscureText: true,
                onChanged: (text){
                  if(text.length==0 && !can3) {
                    setState(() {
                      can3 = true;
                    });
                  }
                },
              ),
            ),//For the part of password
            SizedBox(height: ht*0.03,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: pass1,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.lock),
                  labelText: "CONFIRM PASSWORD",
                  hintText: "Confirm Password",
                  errorText: pass1.text.toString()!=pass.text.toString() && can4?"2 Passwords must be same":null,
                ),
                obscureText: true,
                onChanged: (text){
                  if(text!=pass.text && !can4) {
                    setState(() {
                      can4 = true;
                    });
                  }
                },
              ),
            ),//This part for confirm pass form,
            SizedBox(height: ht*0.03,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.mail),
                  labelText: "EMAIL",
                  hintText: "Your Mail",
                  errorText: !email.text.toString().contains('@') && !email.text.toString().contains('.') && can5?"Enter a valid mail":null,
                ),
                onChanged: (text){
                  if((!text.toString().contains('@') && !text.toString().contains('.')) && !can5){
                    setState(() {
                      can5 = true;
                    });
                  }
                },
              ),
            ), //This part is for mail
            SizedBox(height: ht*0.05,),
            Center(child:
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                  child:Text("SIGN UP",style: TextStyle(color: Colors.white,fontSize: 20.0),)
                ),
                onTap: (){
                    setState(() {
                      print("hi");
                      Map<String,dynamic> mp = new Map();
                      mp['name'] = name.text.toString();
                      mp['emp_id'] = emp_id.text.toString();
                      mp['pass'] = pass.text.toString();
                      mp['mail'] = email.text.toString();
                      ob.Signup(mp).then((result){
                        if(result==1){
                          if(current_user!=null)
                           print(current_user.name+" Signed up successulyy");
                          Navigator.push(context, new MaterialPageRoute(builder: (context) => new H_page()));
                        }
                        else{
                          print("Email already in use");
                        }
                      }).catchError((e){
                        print(e);
                      });
                    });
                },
              )//Sign up button
            ),
            SizedBox(height:ht*0.04),
            Row(
                children:<Widget>[
                  SizedBox(width: wd*0.25,),
                  Text("Already Signed up? ",style: TextStyle(fontSize: 14.0),),
                  SizedBox(width:10.0),
                  GestureDetector(child: Text("Login",style: TextStyle(color: Colors.blue,fontSize: 14.0),),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new Login()));
                    },
                  )//Login redirector
                ],
            ),
            SizedBox(height: ht*0.03,),

          ],
        )
    );
  }
}
