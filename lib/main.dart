import 'package:flutter/material.dart';
import 'parts/zoom_room_URL.dart';
import 'parts/slide_show.dart';
import 'parts/countdown_timer.dart';
import 'parts/iFrame.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meetup Tool beta',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Meetup Tool  beta'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Container(
                height: 50,
                width: 800,
                child: RoomURL(),
              ),
              flex: 1,
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: 300,
                      width: 350,
                      child: Slide(),
                    ),
                    flex:1,
                  ),
                  Flexible(
                    child: Container(
                      height: 300,
                      width: 350,
                      child: CountDownTimer(),
                    ),
                    ),
                ],
              ),
              flex: 2,
            ),
            Flexible(
                child:
                  IFrame(),
              flex: 3,
              ),
          ],
        ),
      ),
    );
  }
}
