import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Birthday List',
      home: Scaffold(
          appBar: AppBar(title: Text('Birthday List')),
          backgroundColor: Colors.pink[400],
          body: MainCard()),
    );
  }
}

class MainCard extends StatefulWidget {
  @override
  _MainCardState createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {

  List people;

  Future<String> fetchLocalJson() async {
    final response = await rootBundle.loadString('data/data.json');
    setState(() {
      people = json.decode(response);
    });
  }

  @override
  void initState() {
    fetchLocalJson();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            Text(
              '${people.length} birthdays',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: people.length,
              itemBuilder: (BuildContext context, int index) {
              return Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(people[index]['image']),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              people[index]['name'],
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${people[index]['age']} years',
                              style: TextStyle(color: Colors.grey[400])
                            ),
                          ]
                        )
                      ]
                    )
                  )
                )
              );
              },
            )
            ),
            FlatButton.icon(
                icon: Icon(Icons.delete),
                label: Text('Delete All'),
                onPressed: (() => setState(
                  () => people.clear()
                ))
            )
          ],
        )
      )
    ));
  }
}