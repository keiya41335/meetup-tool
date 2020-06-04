import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';


class RoomURL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Linkify(
        onOpen: (link)async {
          if(await canLaunch(link.url)){
            await launch(link.url);
          }else{
            throw 'Could not launch $link';
          }
        },
        text: "Zoom Meeting Room https://zoom.us/",
        style: TextStyle(color: Colors.black54),
        linkStyle: TextStyle(color: Colors.blueAccent),
      ),
    );
  }
}