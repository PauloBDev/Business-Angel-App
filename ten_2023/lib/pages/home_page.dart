import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ten_2023/pages/auth_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future getInfo() async {
    Map<String, dynamic>? dbData = {};
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      dbData = value.data();
    });
    return dbData;
  }

  @override
  Widget build(BuildContext context) {
    getInfo();
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder(
                  future: getInfo(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      final data = snapshot.data;

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              Text(
                                'Currently logged in as ${FirebaseAuth.instance.currentUser!.email}\nUID:${FirebaseAuth.instance.currentUser!.uid}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Welcome ${data['username']} to the business angels app!',
                                style: GoogleFonts.bebasNeue(fontSize: 32),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }),
                ),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(30)),
                  child: IconButton(
                      onPressed: () {
                        signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: ((context) {
                              return const AuthPage();
                            }),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 100,
                            width: 100,
                          ),
                          Column(
                            children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black54),
                                onPressed: () {},
                                label: Text(
                                  'Manage players',
                                  style: GoogleFonts.bebasNeue(
                                      fontSize: 16, color: Colors.white),
                                ),
                                icon: const Icon(
                                  Icons.arrow_forward_sharp,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )
                        ]),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 100,
                            width: 100,
                          ),
                          Column(
                            children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black54),
                                onPressed: () {},
                                label: Text(
                                  'Manage competitions',
                                  style: GoogleFonts.bebasNeue(
                                      fontSize: 16, color: Colors.white),
                                ),
                                icon: const Icon(Icons.arrow_forward_sharp,
                                    color: Colors.white),
                              )
                            ],
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
