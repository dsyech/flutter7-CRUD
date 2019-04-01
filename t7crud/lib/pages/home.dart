import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:t7crud/pages/detail.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List dataJSON;

  getData() async {
    http.Response hasil = await http.get(
        "https://jsonplaceholder.typicode.com/todos",
        headers: {"Accept": "application/json"});

    this.setState(() {
      dataJSON = json.decode(hasil.body);
      print(dataJSON);
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
      appBar: new AppBar(title: new Text("Home")),
      body: new ListView.builder(
        itemCount: dataJSON == null ? 0 : dataJSON.length,
        itemBuilder: (context, i) {
          return new Container(
              padding: EdgeInsets.all(5.0),
              child: new InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new Detail(id: dataJSON[i]['id'])));
                  },
                  child: new Card(
                    child: new Container(
                        padding: EdgeInsets.all(5.0),
                        child: new ListTile(
                          title: new Text(dataJSON[i]['title']),
                          trailing: new Icon(Icons.keyboard_arrow_right),
                        )),
                  )));
        },
      ),
    );
  }
}
