import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';

//ten_admin123
class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameCtrlr = TextEditingController();
  final _emailCtrlr = TextEditingController();
  final _passwordCtrlr = TextEditingController();
  final _confirmPasswordCtrlr = TextEditingController();
  static final _validUsername = RegExp(r'^[a-zA-Z0-9]+$');
  bool obscurePassword = true;

  @override
  void dispose() {
    _usernameCtrlr.dispose();
    _emailCtrlr.dispose();
    _passwordCtrlr.dispose();
    _confirmPasswordCtrlr.dispose();
    super.dispose();
  }

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailCtrlr.text.trim(), password: _passwordCtrlr.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return LoginScreen();
              },
            ),
          ),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[1000],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(children: [
              const SizedBox(
                height: 50,
                width: 50,
              ),
              Image.asset(
                'lib/images/register_page_logo_256.png',
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Sign-up',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bebasNeue(fontSize: 26),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 2),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _usernameCtrlr,
                        decoration: const InputDecoration(
                          labelText: "Username",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          prefixIcon: Icon(Icons.person_sharp),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Username cannot be blank!";
                          }
                          bool valid = _validUsername.hasMatch(value);
                          if (!valid) {
                            return "Invalid username! (Alphanumerical only)";
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 2),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailCtrlr,
                        decoration: const InputDecoration(
                          labelText: "E-mail",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          prefixIcon: Icon(Icons.email_sharp),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "E-mail cannot be blank!";
                          }
                          final bool emailValidation = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);

                          if (!emailValidation) {
                            return "Invalid e-mail format!";
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 2),
                      child: TextFormField(
                        obscureText: obscurePassword,
                        keyboardType: TextInputType.emailAddress,
                        controller: _passwordCtrlr,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          prefixIcon: const Icon(Icons.key_sharp),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            child: Icon(
                              obscurePassword
                                  ? Icons.visibility_off_sharp
                                  : Icons.visibility_sharp,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be blank!";
                          }
                          if (value.length < 8) {
                            return "Password needs to be atleast 8 characters long!";
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 2),
                      child: TextFormField(
                        obscureText: obscurePassword,
                        keyboardType: TextInputType.emailAddress,
                        controller: _confirmPasswordCtrlr,
                        decoration: InputDecoration(
                          labelText: "Confirm password",
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          prefixIcon: const Icon(Icons.key_sharp),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            child: Icon(
                              obscurePassword
                                  ? Icons.visibility_off_sharp
                                  : Icons.visibility_sharp,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value != _passwordCtrlr.text) {
                            return "Passwords do not match!";
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: (() {
                          if (_formKey.currentState!.validate()) {
                            signUp();
                            //Add this new user to DB
                            //UID as ID
                            //Set state for good msg or error
                          }
                        }),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
