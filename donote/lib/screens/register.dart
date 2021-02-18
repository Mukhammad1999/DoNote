import 'package:donote/sevices/userRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final UserRepository _auth = UserRepository();
  final _rormKey = GlobalKey<FormState>();
  String eyemail = '';
  String password = '';
  String name = '';
  @override
  Widget build(BuildContext context) {
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
                          image: AssetImage('assets/signin.png'),
                        ),
                      ),
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
                        key: _rormKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.05,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  hintText: 'Name',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Name cannot be empty';
                                  }
                                  return null;
                                },
                                onChanged: (value) => name = value.trim(),
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
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Sign Up',
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () async {
                                      if (_rormKey.currentState.validate()) {
                                        print(eyemail);
                                        await _auth.signUp(
                                            eyemail, password, name);
                                      }
                                    },
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FlatButton(
                                    onPressed: () {
                                      widget.toggleView();
                                    },
                                    child: Text('Sign In'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
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
