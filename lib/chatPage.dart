import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessagePage extends StatelessWidget {
  MessagePage({super.key, required this.Reciever, required this.Reciever_Id});
  String Reciever;
  String Reciever_Id;
  TextEditingController Message = TextEditingController();

  ScrollController sc = ScrollController();
  @override
  Widget build(BuildContext context) {
    List room = [Reciever_Id, FirebaseAuth.instance.currentUser!.uid];

    room.sort();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(Reciever)),
      body: Column(children: [
        Expanded(
            child: Container(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chatroom')
                  .doc(room.join("_"))
                  .collection('message')
                  .orderBy('Time')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.docs;
                  return ListView.builder(
                    controller: sc,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: data[index]['From'] ==
                                  FirebaseAuth.instance.currentUser!.email
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width / 1.5),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(data[index]['Message'],
                                  style: GoogleFonts.ibmPlexMono(fontSize: 18)),
                            ),
                            decoration: BoxDecoration(
                                color: data[index]['From'] ==
                                        FirebaseAuth.instance.currentUser!.email
                                    ? Colors.orange
                                    : Colors.blue,
                                borderRadius: data[index]['From'] ==
                                        FirebaseAuth.instance.currentUser!.email
                                    ? const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20))
                                    : const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20))),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: Message,
                decoration: InputDecoration(
                    hintText: "Enter A Message",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            IconButton(
                onPressed: () {
                  List room = [
                    Reciever_Id,
                    FirebaseAuth.instance.currentUser!.uid
                  ];

                  room.sort();

                  FirebaseFirestore.instance
                      .collection("chatroom")
                      .doc(room.join("_"))
                      .collection("message")
                      .doc()
                      .set({
                    "Time": DateTime.now(),
                    "Message": Message.text,
                    "From": FirebaseAuth.instance.currentUser!.email
                  }).then((value) => Message.clear());

                  sc.animateTo(
                      duration: Duration(milliseconds: 1),
                      MediaQuery.of(context).size.height + 1000,
                      curve: Curves.bounceIn);
                },
                icon: Icon(Icons.send))
          ]),
        )
      ]),
    );
  }
}
