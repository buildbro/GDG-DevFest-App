import 'package:flutter/material.dart';
import 'package:flutter_devfest/agenda/session_list.dart';
import 'package:flutter_devfest/home/index.dart';
import 'package:flutter_devfest/home/session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudScreen extends StatefulWidget {
  final HomeBloc homeBloc;

  const CloudScreen({Key key, this.homeBloc}) : super(key: key);

  @override
  _CloudScreenState createState() {
    return _CloudScreenState();

  }

}

class _CloudScreenState extends State<CloudScreen> {
  @override
  Widget build(BuildContext context) {
    var cloudSessions = sessions.where((s) => s.track == "cloud").toList();
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('schedule2019')
          .where("track", isEqualTo: "cloud")
          .snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();

        List<Session> tempList = [];
        snapshot.data.documents.forEach((doc) {
          Session sessionItem = new Session();
          sessionItem.sessionTitle = doc["sessionTitle"];
          sessionItem.sessionDesc = doc["sessionDesc"];
          sessionItem.sessionImage = doc["sessionImage"];
          sessionItem.sessionStartTime = doc["sessionStartTime"];
          sessionItem.sessionTotalTime = doc["sessionTotalTime"];
          sessionItem.sessionLink = doc["sessionLink"];
          sessionItem.speakerName = doc["speakerName"];
          sessionItem.speakerDesc = doc["speakerDesc"];
          sessionItem.speakerImage = doc["speakerImage"];
          sessionItem.speakerInfo = doc["speakerInfo"];
          sessionItem.speakerId = doc["speakerId"];
          sessionItem.track = doc["track"];
          tempList.add(sessionItem);
          print(doc["speakerImage"]);
        });
        cloudSessions = tempList.toList();
        return SessionList(
          allSessions: cloudSessions,
        );
      },
    );
  }

}
