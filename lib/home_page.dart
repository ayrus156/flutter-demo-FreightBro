import 'dart:developer';

import 'package:flutter/material.dart';
import 'api_services.dart';

import 'group_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<GroupModel>> futureGroup;

  @override
  void initState() {
    super.initState();
    futureGroup = Services.fetchGroups();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title:
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: ListTile(
              title:
              Text("My Groups", style: TextStyle(color:Colors.black54,fontWeight: FontWeight.bold, fontSize: 25),),
              subtitle:
              Text("12 groups created", style: TextStyle(color:Colors.black54)),
            ),
          )
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Container(
          child: FutureBuilder<List<GroupModel>>(
              future: futureGroup,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error);
                }

                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
