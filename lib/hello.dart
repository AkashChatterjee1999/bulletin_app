
        ////////////////////////////////////////////////////////
        //                                                    //
        //    Created by: Akash Chatterjee                    //
        //          Date: 29-06-2020                          //
        //    "Lets code for a better tommorow"               //
        //                                                    //
        ////////////////////////////////////////////////////////

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
final FirebaseAuth _m_auth = FirebaseAuth.instance;
class perform_op{
  var db = Firestore.instance;
  Future<void> addQuery(Map<String,dynamic> data) async{
    await db.collection('users').add(data).catchError((e){
      print("Error loading firebsae object");
    });
  }
  retrieve_data() async{
    var result = await db.collection('users').getDocuments();
    return result;
  }
  Future<void> Sign_up(Map<String,dynamic> data) async{
    try{
       await (_m_auth.createUserWithEmailAndPassword(email: data['mail'],password: data['pass'])
          .then((authResult) => {
            db.collection("users_login_data")
              .document(data['emp_id'])
              .setData({
                "uid": authResult.user.uid,
                "emp_id":data['emp_id'],
                "name":data['name'],
                "mail":data['mail'],
                "pass":data['pass'],
              })
            }
          )).then((result){
                try {
                  print("hi there"+data['mail'].toString());
                  _m_auth.signInWithEmailAndPassword(
                      email: data['mail'], password: data['pass']).then((result){
                      print("Signed in successfully: Hi,"+data['name']);
                  });
                }
                catch(e){
                  throw Exception("Error there: "+e.toString());
              }
          });
    }
    catch(SignUpError){
      throw Exception("Error: "+SignUpError.toString());
    }
  }
  Future<bool> login(Map<String,dynamic> data) async{
      Exception ex;
      bool ans = true;
      await _m_auth.signInWithEmailAndPassword(email: data['email'], password: data['pass'])
          .then((result){
            print("Sucessfully SIgned in");
        }).catchError((e){
          ans = false;
          ex = e;
          print("hi");
          print("Error: e");
      });
      return ans;
  }
}
