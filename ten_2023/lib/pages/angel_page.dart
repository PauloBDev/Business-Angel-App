import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_page.dart';

class AngelPage extends StatefulWidget {
  var data;
  AngelPage(this.data, {super.key});

  @override
  State<AngelPage> createState() => _AngelPageState();
}

class _AngelPageState extends State<AngelPage> {
  List<String> _allUserID = [];

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future getUsersID() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) => value.docs.forEach((element) async {
              if (element.data()['u_type'] == 'guest') {
                String currID = element.reference.id;
                String currUsername = element.data()['username'];
                _allUserID.add(element.reference.id);
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(element.reference.id)
                    .collection('projects')
                    .get()
                    .then((value) {
                  value.docs.forEach(
                    (element) {
                      if (element.data().length > 0) {
                        _allUserID.add(element.reference.id);
                        print(element.data().length);
                        print(_allUserID);
                        print(
                            '[${currID} | ${currUsername}] : (${element.data()}) \n');
                      }
                    },
                  );
                  //print('ID > ${element.reference.id} : USERNAME > ${value.data()!['username']}');
                  //getUserProj(element.reference.id);
                });
              }
            }));

    return _allUserID;
  }

  Future getUserProj(String userID) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('projects')
        .get()
        .then(
          (value) => value.docs.forEach((element) async {
            print('${userID} : (${element.reference.id}) ${element.data()}');
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Welcome ${widget.data['username']}',
          style: GoogleFonts.bebasNeue(fontSize: 36),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: Colors.black87, borderRadius: BorderRadius.circular(30)),
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getUsersID(),
                builder: ((context, snapshot) {
                  //print(_allUserID);
                  if (snapshot.connectionState == ConnectionState.done &&
                      _allUserID.isEmpty) {
                    return const Text(
                        'There are currently no business ideas...');
                  }
                  return ListView.builder(
                    itemCount: _allUserID.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder(
                          future: getUserProj(_allUserID[index]),
                          builder: ((context, snapshot) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(_allUserID[index]),
                                  onTap: () {
                                    //Navigator.push(
                                    //  context,
                                    //  MaterialPageRoute(
                                    //    builder: ((context) {
                                    //      return ViewIdeiaPage(
                                    //          docID: _allUserID[index]);
                                    //    }),
                                    //  ),
                                    //);
                                  },
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  indent: 15,
                                  endIndent: 15,
                                )
                              ],
                            );
                          }));
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
