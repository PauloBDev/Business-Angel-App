import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ten_2023/pages/add_idea_page.dart';
import 'package:ten_2023/pages/view_idea_page.dart';
import 'dumb_data.dart';
import 'auth_page.dart';

class GuestPage extends StatefulWidget {
  var data;
  GuestPage(this.data, {super.key});

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
  List<String> projects = ['title 1', 'title 2'];
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
//    return SafeArea(child: Text('GUEST PAGE'));
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
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const IdeaAddPage();
                        }));
                      },
                      child: const Text(
                        "Show your idea!",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ideas.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(ideas[index].title),
                        subtitle: Text(ideas[index].type),
                        onTap: () {},
                      ),
                      const Divider(
                        color: Colors.grey,
                        indent: 15,
                        endIndent: 15,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
