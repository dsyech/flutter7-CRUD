import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Detail extends StatefulWidget {
  Detail({this.id});
  final int id;
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String title="", completed="";
  
  getData() async {
    http.Response hasil = await http.get(
        "https://jsonplaceholder.typicode.com/todos/"+widget.id.toString(),
        headers: {"Accept": "application/json"});

    this.setState(() {
      var dataJSON = json.decode(hasil.body);
      title = dataJSON['title'];
      completed =dataJSON['completed'].toString();
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Detail"),
      ),
      body: new Container(
        padding: new EdgeInsets.all(10.0),
        child: new ListView(
        children: <Widget>[
          new Text(title, style: new TextStyle(fontSize: 20.0),),
          new Text(completed)
        ],
      ),
      )
    );
  }
}