import 'package:appzs/outer.dart';
import 'package:appzs/tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Stream FetchAll() {
  return FirebaseFirestore.instance
      .collection('users')
      .where("Email", isNotEqualTo: FirebaseAuth.instance.currentUser!.email)
      .snapshots();
}

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    getUserName();
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.power_settings_new_rounded),
                onPressed: () async {
                  FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OuterPage())));
                },
              )
            ],
            centerTitle: false,
            elevation: 0,
            title: StreamBuilder(
                stream: getUserName(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text("Welcome, ${snapshot.data['Name']}");
                  } else {
                    return Text("Welcome");
                  }
                })),
        body: StreamBuilder(
            stream: FetchAll(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var doc = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: doc.length,
                    itemBuilder: (context, index) {
                      return ChatTile(
                        Name: doc[index]['Name'],
                        Reciever_Id: doc[index].id,
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}

Stream getUserName() {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
}
