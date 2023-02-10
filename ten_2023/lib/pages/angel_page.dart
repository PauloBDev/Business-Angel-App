import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ten_2023/pages/add_idea_page.dart';
import 'package:ten_2023/pages/view_idea_page.dart';
import 'dumb_data.dart';

import 'auth_page.dart';

class AngelPage extends StatefulWidget {
  var data;
  AngelPage(this.data, {super.key});

  @override
  State<AngelPage> createState() => _AngelPageState();
}

class _AngelPageState extends State<AngelPage> {
  void signOut() {
    FirebaseAuth.instance.signOut();
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
              child: ListView.builder(
                itemCount: ideas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(ideas[index].title),
                    subtitle: Text(ideas[index].type),
                  );
                },
                //children: ideas.map((e) {
                //  return Padding(
                //    padding: const EdgeInsets.all(8.0),
                //    child: Card(
                //      child: Row(
                //        children: [
                //          Row(
                //            mainAxisSize: MainAxisSize.min,
                //            children: [
                //              SizedBox(
                //                height: 50,
                //              ),
                //              InkWell(
                //                onTap: () {},
                //                child: Padding(
                //                  padding: const EdgeInsets.all(8.0),
                //                ),
                //              ),
                //              SizedBox(
                //                width: 2,
                //              ),
                //              Text(
                //                e.title,
                //                textAlign: TextAlign.center,
                //                style: const TextStyle(
                //                  fontSize: 32,
                //                ),
                //              )
                //            ],
                //          )
                //        ],
                //      ),
                //    ),
                //  );
                //}).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
