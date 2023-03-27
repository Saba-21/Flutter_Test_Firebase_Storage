import 'package:document_storage/data/db_helper.dart';
import 'package:document_storage/ui/home/home_screen_group.dart';
import 'package:document_storage/ui/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../data/firestore_service.dart';
import '../data/storage_service.dart';
import '../utility/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DBHelper().initializeDatabase();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.data == null) {
            return const LoginScreen();
          } else {
            syncTests();
            syncDocs();
            return const HomeScreenGroup();
          }
        },
      ),
    );
  }
  void syncDocs() async {
    final docs = await StorageService().getAllFiles();
    final box = await DBHelper().getDatabaseBox();
    DBHelper().updateDocuments(docs, box);
  }

  void syncTests() async {
    final tests = await FirestoreService().getTests();
    final box = await DBHelper().getDatabaseBox();
    DBHelper().updateTests(tests, box);
  }
}
