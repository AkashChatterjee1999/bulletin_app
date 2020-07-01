import 'package:bulletin_app/_injector_.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'land.dart';
import 'hello.dart';
void main() => runApp(Login());
volatile_backend ob = new volatile_backend();
var email = new TextEditingController();
var pass = new TextEditingController();
bool can = false;
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
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
            Container(
                padding: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                child: Text('Welcome',
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 60.0, fontWeight: FontWeight.bold)),
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)
                              ),
                        errorText: (!email.text.contains('@') || !email.text.contains('.')) && can?"Invalid Email":null,
                      ),
                      onChanged: (text){
                        if((!text.contains('@') || !text.contains('.'))&& !can){
                          can = true;
                        }
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: pass,
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      obscureText: true,
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.blueAccent,
                        color: Colors.blue,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            print("hi");
                            var mail = email.text.toString();
                            var password = pass.text.toString();
                            print(mail+" "+password);
                            ob.login(mail, password).then((result){
                              if(result){
                                if(current_user!=null)
                                  print(current_user.email.toString() +"Logged in");
                                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new H_page()));
                                }
                              else{
                                print("Invalid username or password");
                              }
                            }).catchError((e){
                              print(e);
                            });
                          },//login backend
                          child: Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      color: Colors.transparent,
                    )
                  ],
                )),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New to Bulletin Board ?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new Signup()));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(height: 60.0,)
              ],
            )
          ],
        ));
  }
}