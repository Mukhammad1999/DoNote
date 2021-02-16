import 'package:donote/screens/home.dart';
import 'package:donote/sevices/authenticate.dart';
import 'package:donote/sevices/userRepo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser == null) {
      print(firebaseUser.email);
      return Authenticate();
    }
    return Home();
  }
}
