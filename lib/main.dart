import 'package:appzs/firebase_options.dart';
import 'package:appzs/index.dart';
import 'package:appzs/outer.dart';
import 'package:appzs/providerz/myappProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => MyAppProvider())],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: FirebaseAuth.instance.currentUser != null
            ? IndexPage()
            : OuterPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
