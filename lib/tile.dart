import 'dart:ui';

import 'package:appzs/chatPage.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  ChatTile({super.key, required this.Name, required this.Reciever_Id});

  String Name;
  String Reciever_Id;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(Reciever_Id);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MessagePage(
                      Reciever: Name,
                      Reciever_Id: Reciever_Id,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 10,
              width: MediaQuery.of(context).size.height / 10,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 211, 216, 163),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Icon(Icons.person, size: 32),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    Name,
                    style: TextStyle(fontSize: 22),
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
