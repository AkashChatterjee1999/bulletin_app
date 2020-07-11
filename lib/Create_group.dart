import 'package:flutter/material.dart';
import 'App_themes_languages.dart';
import '_injector_.dart';
import 'Grp_info_disp.dart';

TextEditingController Gsearch = new TextEditingController();
TextEditingController grp_name = new TextEditingController();
TextEditingController grp_desc = new TextEditingController();
TextEditingController participas = new TextEditingController();
TextEditingController grp_domain = new TextEditingController();
var to_eror1 = false,to_eror2 = false,to_eror3 = false,to_eror4 = false;
String _group_type = "";
Future<bool> result;
List<String> participant_list_controller = new List();
volatile_backend ob = new volatile_backend();
class Create_group extends StatefulWidget {
  @override
  _Create_groupState createState() => _Create_groupState();
}

class _Create_groupState extends State<Create_group> {
  @override
  Widget build(BuildContext context) {
    if (!participant_list_controller.contains("You")) participant_list_controller.add("You");
    return MaterialApp(
      home: Create_group_Page(),
    );
  }
}
class Create_group_Page extends StatefulWidget {
  @override
  _Create_group_PageState createState() => _Create_group_PageState();
}

class _Create_group_PageState extends State<Create_group_Page> {
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
          Container(
            padding: EdgeInsets.all(10.0),
            child:Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Create Group',
                  style: TextStyle(color: Colors.black,fontSize: 40.0, fontWeight: FontWeight.bold)
              ),
            ),
          ),
          SizedBox(height: ht*0.02,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              controller: grp_name,
              decoration: InputDecoration(
                hoverColor: Colors.black,
                labelText: "Group Name",
                errorText: (grp_name.text.length<2 && to_eror1)?"Group name can't be empty":null,
                labelStyle: TextStyle(color: Colors.blue),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                hintText: "Group Name",
              ),
              onChanged: (text){
                setState(() {
                  if(text.length<=1 && !to_eror1)
                    to_eror1 = true;
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              controller: grp_desc,
              decoration: InputDecoration(
                hoverColor: Colors.black,
                labelText: "Group Description",
                errorText: (grp_desc.text.length<10 && to_eror2)?"Group Desciption can't be < 10 words":null,
                labelStyle: TextStyle(color: Colors.blue),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                hintText: "A short Description",
              ),
              onChanged: (text){
                setState(() {
                  if(text.length<10 && !to_eror2)
                    to_eror2 = true;
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              controller: grp_domain,
              decoration: InputDecoration(
                hoverColor: Colors.black,
                labelText: "Group Domain",
                errorText: (grp_domain.text.length<2 && to_eror4)?"Group Domain can't be < 2 words":null,
                labelStyle: TextStyle(color: Colors.blue),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                hintText: "Type a group domain",
              ),
              onChanged: (text){
                setState(() {
                  if(text.length<2 && !to_eror4)
                    to_eror4 = true;
                });
              },
            ),
          ),
          SizedBox(height: ht*0.05,),
          Row(
            children: <Widget>[
              Container(
                width: wd*0.4,
                child: RadioListTile(
                  title: const Text("Private Group",style: TextStyle(fontSize: 15.0),),
                  value: "Private Group",
                  groupValue: _group_type,
                  onChanged: (newValue){
                    setState(() {
                      _group_type = newValue;
                      print(newValue);
                    });
                  },
                  activeColor: Colors.blue,
                ),
              ),
              SizedBox(width:wd*0.02),
              Container(
                width: wd*0.4,
                child: RadioListTile(
                  title: const Text("Public Group",style: TextStyle(fontSize: 15.0),),
                  value: "Public Group",
                  groupValue: _group_type,
                  onChanged: (newValue){
                    setState(() {
                      _group_type = newValue;
                      print(newValue);
                    });
                  },
                  activeColor: Colors.blue,
                ),
              ),
            ],
          ),
          SizedBox(height:ht*0.04),
          Center(child: Text("Add Participants",style: TextStyle(color: Colors.black,fontSize: 20.0, fontWeight: FontWeight.bold))),
          SizedBox(height:ht*0.03),
          Row(
            children: <Widget>[
              Container(
                width: wd*0.8,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: participas,
                  decoration: InputDecoration(
                    hoverColor: Colors.black,
                    labelText: "Participant's mail-id",
                    errorText: (participas.text.length<10 && to_eror3)?"Mail id don't exist":null,
                    labelStyle: TextStyle(color: Colors.blue),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                  ),
                  onChanged: (text){
                    setState(() {
                      if(text.length<10 && !to_eror3)
                        to_eror3 = true;
                    });
                  },
                ),
              ),
              SizedBox(width:wd*0.02),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0)),color: Colors.green),
                  child: Padding(padding:EdgeInsets.symmetric(vertical: 8.0,horizontal: 12.0),child: Text("Add")),
                ),
                onTap:(){
                  if(!participant_list_controller.contains(participas.text)){
                    setState(() {
                      result = ob.search(participas.text);
                      result.then((res){
                        if(res==true)
                          participant_list_controller.add(participas.text);
                      });
                    });
                  }
                },
              )
            ],
          ),
          FutureBuilder(
            future: result,
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();
              else if(snapshot.hasData)
                return snapshot.data?Text("             User Added",style: TextStyle(color: Colors.red,fontSize: 12.0),):Text("             User not exist",style: TextStyle(color: Colors.red,fontSize: 12.0));
              else if(snapshot.hasError)
                return Text("             Error in Data collection",style: TextStyle(color: Colors.red,fontSize: 12.0));
              else
                return Text("");
            },
          ),
          SizedBox(height: ht*0.03,),
          Center(child: Text("Added Participants",style:TextStyle(fontSize: 15.0,color:Colors.blue,fontStyle: FontStyle.italic))),
          ListView.builder(
              itemCount: participant_list_controller.length,
              shrinkWrap: true,
              itemBuilder: (context,i){
                return Container(
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(participant_list_controller[i].toString()),
                  )
                );
              },
          ),
          SizedBox(height:ht*0.04),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: wd*0.3),
            child: GestureDetector(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color:Colors.blue,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add,color:Colors.white),
                      SizedBox(width:wd*0.02),
                      Text("Create Group",style:TextStyle(color:Colors.white))
                    ],
                  )
              ),
              onTap: () async{
                  bool isPrivate = _group_type.contains("Private Group");
                   await ob.CreateGrp(grp_name.text.toString(),
                      " ", " ", grp_desc.text.toString(),
                      grp_domain.text.toString(),
                      isPrivate, participant_list_controller).then((result){
                        print("Data in create group : $result");
                        if(result!=null){
                          group_id_to_display = result;
                        }
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => new Display_Grp()));
                },
            ),
          ),
          SizedBox(height:ht*0.05),
        ]
      )
    );
  }
}
