import 'dart:convert';
import 'package:donote/model/user.dart';
import 'package:donote/sevices/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';
import 'package:provider/provider.dart';

class EditorPage extends StatefulWidget {
  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  ZefyrController _controller;

  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    final document = _loadDocument();
    _controller = ZefyrController(document);
    _focusNode = FocusNode();
  }

  final _dormKey = GlobalKey<FormState>();
  @override
  Widget build(context) {
    final firebaseUser = context.watch<User>();
    String title;

    return StreamBuilder<Object>(
        stream: Database(uid: firebaseUser.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('DoNote'),
                actions: [
                  GestureDetector(
                    onTap: () async {
                      if (_dormKey.currentState.validate()) {
                        final content = jsonEncode(_controller.document);
                        print(title.toString());
                        Database(uid: firebaseUser.uid)
                            .saveNote(content, userData.name, title)
                            .then((value) => Navigator.pop(context));
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.save_alt_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              body: ZefyrScaffold(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05),
                      child: Form(
                        key: _dormKey,
                        child: TextFormField(
                          onChanged: (value) => title = value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'This post feals empty without title';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintStyle: GoogleFonts.yrsa(
                                fontSize: 56,
                                color: Colors.grey[400],
                              ),
                              hintText: 'Title'),
                          style: GoogleFonts.yrsa(
                            fontSize: 56,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ZefyrEditor(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        controller: _controller,
                        focusNode: _focusNode,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  NotusDocument _loadDocument() {
    // For simplicity we hardcode a simple document with one line of text
    // saying "Zefyr Quick Start".
    // (Note that delta must always end with newline.)
    final Delta delta = Delta()..insert("Start you story here...\n");
    return NotusDocument.fromDelta(delta);
  }
}
