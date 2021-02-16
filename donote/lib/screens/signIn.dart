import 'package:donote/sevices/userRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final UserRepository _auth = UserRepository();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String eyemail;
    String password;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          height: MediaQuery.of(context).size.height * 0.07,
                          image: AssetImage(
                            'assets/quill.png',
                          ),
                        ),
                        Text(
                          'DoNote',
                          style: GoogleFonts.yrsa(
                              color: Colors.indigo[800],
                              fontSize: 52,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/signin.png'))),
                    )
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.45,
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[500],
                          blurRadius: 3,
                          spreadRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ]),
                  child: ListView(
                    children: [
                      Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.05,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Email cannot be empty';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => eyemail = value.trim(),
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Password cannot be empty';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => password = value.trim(),
                                ),
                                Row(
                                  children: [
                                    SignInButton(
                                      Buttons.Google,
                                      onPressed: () async {
                                        _auth.signInWithGoogle();
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
