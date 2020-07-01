import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Mvp_classes.dart';
final db = Firestore.instance;
client current_user;
class volatile_backend{
  Future<int> Signup(Map<String,dynamic> mp) async{
    try {
      QuerySnapshot response = await db.collection('mails').getDocuments();
        for(int i=0;i<response.documents.length;i++){
          if(response.documents[i].data['mail']==mp['mail']){
              return 2;
            }
        }
        Map<String,dynamic> lo = new Map();
        lo['mail'] = mp['mail'];
        await db.collection('mails').add(lo);
        await db.collection('users_login_data').document(mp['mail']).setData({
          "emp_id": mp['emp_id'],
          "name": mp['name'],
          "mail": mp['mail'],
          "pass": mp['pass'],
        });
        current_user = new client(mp['name'],mp['mail'],mp['emp_id']);
        return 1;
      }
    catch(e){
      throw Exception('Error');
    }
  }
  Future<bool> login(String email,String pass) async{
    bool got = false;
    try {
      QuerySnapshot rep = await db.collection('users_login_data').getDocuments();
      for(int i=0;i<rep.documents.length;i++){
        if(rep.documents[i].data['mail']==email && rep.documents[i].data['pass']==pass){
          current_user = new client(rep.documents[i].data['name'],
                                 rep.documents[i].data['mail'],
                                 rep.documents[i].data['emp_id']);
          got = true;
          break;
        }
      }
      if(got) return true;
      else return false;
    }
    catch(e){
      throw Exception('Error');
    }
  }
}