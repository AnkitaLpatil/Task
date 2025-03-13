import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasewebtrix/Pages/cardView.dart';
import 'package:firebasewebtrix/Pages/userForm.dart';
import 'package:firebasewebtrix/firebase_options.dart';
import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   if (kIsWeb) {
//     await Firebase.initializeApp(
//       options: FirebaseOptions(
//     apiKey: "AIzaSyComUJ0lBJMyeowY3Ne3g_0p6Wdsiz2y28",
// authDomain: "users-afe21.firebaseapp.com",
// projectId: "users-afe21",
// storageBucket: "users-afe21.firebasestorage.app",
// messagingSenderId: "75903377943",
// appId: "1:75903377943:web:48d0fa8bc62ff2f8e07252"
//   ),
//     );
//   } else {
//     await Firebase.initializeApp();
//   }

//   runApp(MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Users List"),
          actions: [
            Builder(
                builder: (context) => IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserAddForm()),
                        );
                      },
                    )),
          ],
        ),
        body: StreamBuilder(
          stream: _firestore.collection("users").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No users found"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var user = snapshot.data!.docs[index];
                return UserCard(user);
              },
            );
          },
        ),
      ),
    );
  }
}

