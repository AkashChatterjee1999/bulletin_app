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
  client(String _name,String _email,String _empid){
      this.name = _name;
      this.email = _email;
      this.phoneno = "1234";
      this.emp_id = _empid;
      this.grpids = new List<String>();
      this.grp_admin_ids = List<String>();
      this.domain = new List<String>();
  }
  bool is_admin(String grp_id){
    return (this.grp_admin_ids.contains(grp_id))?true:false;
  }
  void create_grp(String grpname,String grp_img_url,String grp_desc,String grp_abt,String id,String domain,bool isprivate){
     Grp ob = new Grp();
     ob.grp_name = grpname;
     ob.wall_url = grp_img_url;
     ob.grp_id = Grp.unique_grp_id();
     ob.grp_desc = grp_desc;
     ob.domain = domain;
     ob.isprivate = isprivate;
     ob.participant_list_id = new List();
     ob.participant_list_id.add(this.emp_id);
     if(ob.isprivate){
       //TODO: Implement the logic of private group here
     }
     else{
       //TODO: return the link for hosted group id here
     }
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
class Grp{
  String grp_id;
  List<Post> Posts;
  String domain;
  bool isprivate;
  String grp_desc;
  List<String> participant_list_id;
  String grp_name;
  String wall_url;
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
  bool add_post(String cap,String uid,){
    //TODO: implement the logic of add post here remember about pictured post and text post
    //TODO: implement the logic here with injector
    return true;
  }
}