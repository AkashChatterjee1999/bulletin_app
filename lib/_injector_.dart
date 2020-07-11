import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Mvp_classes.dart';
final db = Firestore.instance;
client current_user;
String group_id_to_display;
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
        await db.collection('users_data').document(mp['mail']).setData({
          "emp_id": mp['emp_id'],
          "name": mp['name'],
          "mail": mp['mail'],
          "pass": mp['pass'],
          "phoneno": "Not set",
          "grp_admin_ids": [],
          "domain": [],
          "grpids": [],
        });
        current_user = new client(mp['name'],mp['mail'],mp['emp_id'],mp['phoneno'],mp['grpids'],mp['grp_admin_ids'],mp['domain']);
        return 1;
      }
    catch(e){
      throw Exception('Error');
    }
  }
  Future<bool> login(String email,String pass) async{
    bool got = false;
    try {
      QuerySnapshot rep = await db.collection('users_data').getDocuments();
      for(int i=0;i<rep.documents.length;i++){
        if(rep.documents[i].data['mail']==email && rep.documents[i].data['pass']==pass){
          print("Hello authenticated");
          print(rep.documents[i].data['grpids']);
          current_user = new client(rep.documents[i].data['name'].toString(),
                                 rep.documents[i].data['mail'].toString(),
                                 rep.documents[i].data['emp_id'].toString(),
                                 rep.documents[i].data['phoneno'].toString(),
                                 rep.documents[i].data['grpids'],
                                 rep.documents[i].data['grp_admin_ids'],
                                 rep.documents[i].data['domain']);
          got = true;
          break;
        }
      }
      if(got) return true;
      else return false;
    }
    catch(e){
      throw Exception(e);
    }
  }
  Future<List<broad_cast_msgs>> fetchBroadcast() async{
    if(current_user==null)
      throw Exception("No User");
    else{
        try{
          QuerySnapshot repo = await db.collection('broadcast').getDocuments();
          print("hello documents from firebase fetched");
          List<broad_cast_msgs> lola;
          lola = broad_cast_msgs.gen_docu(repo);
          return lola;
        }
        catch(e) {
          throw Exception(e);
        }
      }
    }
    Future<bool> search(String email) async {
      try {
        QuerySnapshot response = await db.collection('mails').getDocuments();
        for (int i = 0; i < response.documents.length; i++) {
          if (response.documents[i].data['mail'] == email) {
            return true;
          }
        }
        return false;
      }
      catch (e) {
        throw Exception(e);
      }
    }
    Future<String> CreateGrp(String gname,String grp_img_url,String icon_url,String grp_desc,String domain,bool isprivate,List<String> participants) async {
      try {
        Grp new_group = current_user.create_grp(gname, grp_img_url, icon_url, grp_desc, domain, isprivate, participants);
        if(new_group==null) print("Fuck you");
        await db.collection('GroupData').document(new_group.grp_id).setData({
          "Grp_name": new_group.grp_name,
          "Grp_image_url": new_group.wall_url,
          "Grp_icon_url": new_group.icon_url,
          "Grp_desc": new_group.grp_desc,
          "Grp_domain":new_group.domain,
          "Grp_isPrivate": new_group.isprivate,
          "Participants": new_group.participant_list_id,
        });
        return new_group.grp_id;
      }
      catch(e){
        throw Exception(e);
      }
    }
    Future<Grp> fetch_grp(String id) async{
      try {
        await db.collection('GroupData').document(id).get().then((result){
          if(result.exists){
            Grp ob = Grp.serialize_Object_from_json(id,result.data);
            print("Backend Name: "+ob.grp_name);
            return ob;
          }
          else
            throw("group id not exist");
        });
      }
      catch(e){
        throw Exception(e);
      }
    }
}