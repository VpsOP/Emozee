import 'dart:convert';
import 'package:Emozee/Emoji.dart';
import 'package:Emozee/screens/detailscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emozee',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<String> _jsonStr;

  Future<String> getJson() {
    var jsonStr = rootBundle.loadString('assets/data.json');
    setState(() {
      _jsonStr = jsonStr;
    });
    return jsonStr;
  }

  @override
  void initState() {
    getJson();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Home oldWidget) {
    getJson();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff28262C),
        appBar: AppBar(
          elevation: 0,
          title: Center(
              child: Text(
            "Emozee",
            style: TextStyle(fontFamily: 'Damion', fontSize: 30),
          )),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  // bottom: Radius.circular(15),
                  )),
        ),
        body: FutureBuilder(
          future: _jsonStr,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              print(snapshot);
              return CircularProgressIndicator();
            }
            var data = json.decode(snapshot.data);
            var emozee = Emoji.emojiListfromJson(data);

            return ListView.builder(
                itemCount: emozee.length,
                itemBuilder: (BuildContext context, int index) {
                  return EmozeeTile(emozee[index]);
                });
          },
        ));
  }
}

class EmozeeTile extends StatelessWidget {
  final Emoji emozee;

  EmozeeTile(this.emozee);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff707070)),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      margin: EdgeInsets.only(bottom: 16, left: 10, right: 10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DetailPage(emozee)));
        },
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff383C42),
              ),
              height: 80,
              width: (MediaQuery.of(context).size.width * 0.25) - 11,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xff6E747E),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Center(
                  child: Text(emozee.emoji, style: TextStyle(fontSize: 35)),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  border: Border.all(
                      color: Colors.blueAccent, style: BorderStyle.none),
                  color: Color(0xff383C42)),
              height: 80,
              width: (MediaQuery.of(context).size.width * .75) - 11,
              child: Center(
                child: Text(emozee.name,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        letterSpacing: 1,
                        fontFamily: 'AgencyFB')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
