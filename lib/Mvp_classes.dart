import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';
class client{
  String name;
  String email;
  String phoneno;
  List<String> grpids;
  List<String> grp_admin_ids;   //This list contains grp ids which this client is admin of
  List<String> domain;
  String emp_id;
  client(String _name,String _email,String _empid,String phoneno, List<dynamic> grpids, List<dynamic> grp_admin_ids, List<dynamic> Domain){
      this.name = _name;
      this.email = _email;
      this.phoneno = "1234";
      this.emp_id = _empid;
      this.grpids = List<String>();
      for(int i=0;i<grpids.length;i++) this.grpids.add(grpids[i].toString());
      this.grp_admin_ids = List<String>();
      for(int i=0;i<grp_admin_ids.length;i++) this.grp_admin_ids.add(grp_admin_ids[i].toString());
      this.domain = new List<String>();
      for(int i=0;i<domain.length;i++) this.domain.add(domain[i].toString());
      print("Client object created");
  }
  bool is_admin(String grp_id){
    return (this.grp_admin_ids.contains(grp_id))?true:false;
  }
  Grp create_grp(String grpname,String grp_img_url,String icon_url,String grp_desc,String domain,bool isprivate,List<String> participants){
     Grp ob = new Grp();
     ob.grp_name = grpname;
     ob.wall_url = grp_img_url;
     ob.icon_url = icon_url;
     ob.grp_id = Grp.unique_grp_id();
     ob.grp_desc = grp_desc;
     ob.domain = domain;
     ob.isprivate = isprivate;
     ob.participant_list_id = new List();
     ob.participant_list_id.add(this.email);
     for(int i=1;i<participants.length;i++) {
       ob.participant_list_id.add(participants[i]);
     }
     return ob;
  }
  bool remove_me(String grp_id){
    if(this.grpids.contains(grp_id)){
      int index = this.grpids.indexOf(grp_id);
      this.grpids.removeAt(index);
      return true;
    }
    return false;
  }
}
class Post{
  String caption;
  List<String> photos;
  String heading;
  String postCreatedBy;
  DateTime timeOfPost;
  String groupId;
  String empIdOfPoster;
  String dateOfPost;
  Post(String caption,String postCreatedBy,String heading,String groupId,List<String> photos,String empIdOfPoster) {
    this.caption=caption;
    this.heading=heading;
    this.postCreatedBy=postCreatedBy;
    this.heading=heading;
    this.groupId=groupId;
    this.empIdOfPoster=empIdOfPoster;
    DateTime dt = DateTime.now();
    this.photos = new List<String>();
    for(int i=0;i<photos.length;i++) this.photos.add(photos[i]);
    this.dateOfPost=dt.day.toString()+dt.month.toString()+dt.year.toString();
  }
}
class broad_cast_msgs{
  String msg;
  String tstmp;
  String msg_head;
  broad_cast_msgs(String msg_head,String msg,String tstmp){
    this.msg = msg;
    this.msg_head = msg_head;
    this.tstmp = tstmp;
  }
  static List<broad_cast_msgs> gen_docu(QuerySnapshot result){
    List<broad_cast_msgs> res = new List();
    for(int i=0;i<result.documents.length;i++){
      res.add(new broad_cast_msgs(result.documents[i].data['msg_head'].toString(),
                                   result.documents[i].data['msg'].toString(),
                                   result.documents[i].data['tstmp'].toDate().toString()));
    }
    return res;
  }
}
class Grp{
  String grp_id;
  List<Post> Posts;
  String domain;
  bool isprivate;
  String grp_desc;
  List<String> participant_list_id;
  String grp_name;
  String wall_url;
  String icon_url;
  static String unique_grp_id(){
    DateTime ob = DateTime.now();
    String id = ob.day.toString()+
                ob.month.toString()+
                ob.year.toString()+
                ob.hour.toString()+
                ob.minute.toString()+
                ob.second.toString()+
                ob.millisecond.toString()+
                ob.microsecond.toString()+
                ob.millisecondsSinceEpoch.toString()+
                ob.microsecondsSinceEpoch.toString();
    return id;
  }
  static Grp serialize_Object_from_json(String id,Map<String,dynamic> data){
    Grp ob = new Grp();
    ob.grp_id = id;
    ob.grp_name = data["Grp_name"];
    ob.wall_url = data["Grp_image_url"];
    ob.icon_url = data["Grp_icon_url"];
    ob.grp_desc = data["Grp_desc"];
    ob.domain = data["Grp_domain"];
    ob.isprivate = data["Grp_isPrivate"];
    ob.participant_list_id = new List();
    for(int i=0;i<data["Participants"].length;i++){
      ob.participant_list_id.add(data["Participants"][i]);
    }
    print(ob.grp_name+" "+ob.isprivate.toString()+" "+ob.participant_list_id.toString()+" "+ob.domain);
    return ob;
  }
  bool add_post(String cap,String uid,){
    //TODO: implement the logic of add post here remember about pictured post and text post
    //TODO: implement the logic here with injector
    return true;
  }
}