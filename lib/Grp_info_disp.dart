import 'package:bulletin_app/Create_group.dart';
import 'package:flutter/material.dart';
import '_injector_.dart';
import 'Mvp_classes.dart';
import 'App_themes_languages.dart';

TextEditingController Gsearch = new TextEditingController();
volatile_backend ob = new volatile_backend();
Future<Grp> group_to_display;
class Display_Grp extends StatefulWidget {
  @override
  _Display_GrpState createState() => _Display_GrpState();
}

class _Display_GrpState extends State<Display_Grp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Display_Grp_Page(),
    );
  }
}
class Display_Grp_Page extends StatefulWidget {
  @override
  _Display_Grp_PageState createState() => _Display_Grp_PageState();
}

class _Display_Grp_PageState extends State<Display_Grp_Page> {
  void initState() async{
    super.initState();
    group_to_display = ob.fetch_grp(group_id_to_display);
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    String uname = current_user.name.toString().split(" ")[0].toString();
    return new Scaffold(
      appBar: Create_appbar(ht, wd, Gsearch),
      drawer: Create_drawer(wd, ht, uname, context),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          FutureBuilder(
            future: group_to_display,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();
              else if (snapshot.hasData) {
                return Text(snapshot.data.toString());
              }
              else
                return Text(snapshot.hasData.toString());
            },
          )
        ],
      ),
    );
  }
}