import 'package:appzs/index.dart';
import 'package:appzs/main.dart';
import 'package:appzs/providerz/myappProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

GlobalKey<FlipCardState> card = GlobalKey<FlipCardState>();
bool showProg = false;

class OuterPage extends StatelessWidget {
  const OuterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: Expanded(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1614849286521-4c58b2f0ff15?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGNvbG9yZnVsJTIwYmFja2dyb3VuZHxlbnwwfHwwfHx8MA%3D%3D"))),
          child: Center(
            child: SingleChildScrollView(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlipCard(
                      key: card,
                      flipOnTouch: false,
                      back: Card_Front(),
                      front: Card_back(key: key))
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}

class Card_Front extends StatefulWidget {
  @override
  State<Card_Front> createState() => _Card_FrontState();
}
//sign up form

class _Card_FrontState extends State<Card_Front> {
  bool isVisible = false;

  IconData visible = Icons.visibility;

  IconData inVisible = Icons.visibility_off;

  @override
  Widget build(context) {
    var UserName = TextEditingController();
    var Email = TextEditingController();
    var Password = TextEditingController();
    return Consumer<MyAppProvider>(
      builder: (context, val, child) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300),
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width / 1,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Join The Club", style: GoogleFonts.quicksand(fontSize: 32))
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(
                      duration: Duration(milliseconds: 1000),
                      angle: 620,
                      color: Colors.orange),
              Gap(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextField(
                      controller: UserName,
                      decoration: InputDecoration(
                          hintText: "UserName ",
                          hintStyle: GoogleFonts.quicksand(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),
                ),
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextField(
                      controller: Email,
                      decoration: InputDecoration(
                          hintText: "Email ",
                          hintStyle: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),
                ),
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: StatefulBuilder(
                    builder: (context, state) => TextField(
                        controller: Password,
                        obscureText: isVisible,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: isVisible ? Icon(inVisible) : Icon(visible),
                              onPressed: () {
                                state(() {
                                  isVisible = !isVisible;
                                }); //prog=true
                              },
                            ),
                            hintText: "Password ",
                            hintStyle: GoogleFonts.quicksand(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)))),
                  ),
                ),
              ),
              Gap(15),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 15,
                decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(10)),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            content: Container(
                                height: 100,
                                width: 100,
                                child: Center(
                                    child: CircularProgressIndicator()))));

                    createUser(
                        UserName.text, Email.text, Password.text, context);
                    UserName.clear();
                    Email.clear();
                    Password.clear();
                  },
                  child: Center(
                      child: Text(
                    "Create Account",
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  )),
                ),
              ),
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Have An Account ?",
                      style: TextStyle(fontSize: 20)),
                  GestureDetector(
                      onTap: () => card.currentState!.toggleCard(),
                      child: Text(
                        " Log In",
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ))
                ],
              ),
            ])),
      ),
    );
  }
}

class Card_back extends StatefulWidget {
  Card_back({required this.key});
  var key;

  @override
  State<Card_back> createState() => _Card_backState();
}

//login form
class _Card_backState extends State<Card_back> {
  bool isVisible = false;

  IconData visible = Icons.visibility;

  IconData inVisible = Icons.visibility_off;

  var Email = TextEditingController();
  var Password = TextEditingController();
  @override
  Widget build(context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade300,
        ),
        height: MediaQuery.of(context).size.height / 1.8,
        width: MediaQuery.of(context).size.width,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Continue Exploring", style: GoogleFonts.quicksand(fontSize: 32))
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: Duration(seconds: 1), color: Colors.orange),
          Gap(20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextField(
                  controller: Email,
                  decoration: InputDecoration(
                      hintText: "Email ",
                      hintStyle: GoogleFonts.quicksand(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
            ),
          ),
          Gap(10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: StatefulBuilder(
                builder: (context, state) => TextField(
                    controller: Password,
                    obscureText: isVisible,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(isVisible ? inVisible : visible),
                          onPressed: () {
                            state(() {
                              isVisible = !isVisible;
                            });
                          },
                        ),
                        hintText: "Password ",
                        hintStyle: GoogleFonts.quicksand(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.grey)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)))),
              ),
            ),
          ),
          Gap(15),
          GestureDetector(
            onTap: () {
              logUser(Email.text, Password.text, context);
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: Container(
                            height: 100,
                            width: 100,
                            child: Center(child: CircularProgressIndicator())),
                      ));
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 15,
              decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text("Log In",
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20))),
            ),
          ),
          Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't Have An Account ?", style: TextStyle(fontSize: 18)),
              GestureDetector(
                  onTap: () => card.currentState!.toggleCard(),
                  child: Text(
                    " Create One",
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ))
            ],
          ),
        ]),
      ),
    );
  }
}

void createUser(String Name, String Email, String Password, context) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: Email, password: Password)
        .then((value) {
      FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set(
          {"Name": Name, "Email": Email}).then((val) => Navigator.pop(context));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        action: SnackBarAction(
          label: "Login",
          onPressed: () {
            card.currentState!.toggleCard();
          },
        ),
        content: Text("User Created"),
        backgroundColor: Colors.green,
      ));
    });
  } catch (e) {
    showDialog(
        context: context,
        builder: (context) {
          showProg = false;
          return AlertDialog(
            content:
                Text("$e", style: TextStyle(fontSize: 20, color: Colors.white)),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok"))
            ],
            backgroundColor: Colors.redAccent,
          );
        }).then((value) => Navigator.pop(context));
  }
}

void logUser(String Email, String Password, context) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: Email, password: Password)
        .then((value) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }).then((value) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => IndexPage())));
  } catch (e) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ],
              backgroundColor: Colors.red,
              content: Text(e.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.white)));
        });
  }
}
