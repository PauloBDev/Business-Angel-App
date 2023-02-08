import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ten_2023/pages/add_idea_page.dart';
import 'package:ten_2023/pages/admin_page.dart';
import 'package:ten_2023/pages/auth_page.dart';

import 'angel_page.dart';
import 'guest_page.dart';

class RouterPage extends StatelessWidget {
  const RouterPage({super.key});

  Future getInfo() async {
    Map<String, dynamic>? dbData = {};
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      dbData = value.data();
      print(dbData);
    });
    return dbData;
  }

  @override
  Widget build(BuildContext context) {
    getInfo();
    return Scaffold(
      body: FutureBuilder(
        future: getInfo(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            final data = snapshot.data;
            print('RETRIEVED DATA >>>> ${data}');
            if (data['u_type'] == 'angel') {
              return AngelPage();
            }
            if (data['u_type'] == 'guest') {
              //return GuestPage();
              return IdeaAddPage();
            }
            return AdminPage();
          }
        }),
      ),
    );
  }
}
