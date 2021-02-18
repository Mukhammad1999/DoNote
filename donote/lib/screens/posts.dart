import 'package:donote/model/note.dart';
import 'package:donote/screens/editor.dart';
import 'package:donote/screens/reader.dart';
import 'package:donote/sevices/database.dart';
import 'package:donote/sevices/userRepo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = UserRepository();
    final firebaseUser = context.watch<User>();
    return StreamBuilder<List<Note>>(
        stream: Database(uid: firebaseUser.uid).myNotes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Note> notes = snapshot.data;
            return SafeArea(
                child: Container(
                    child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 18.0),
                        child: Text(
                          'MyNotes',
                          style: GoogleFonts.yrsa(
                            color: Theme.of(context).primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      FlatButton(
                          onPressed: () async {
                            await UserRepository().signOut();
                          },
                          child: Icon(
                            Icons.exit_to_app,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        Note note = notes[index];
                        return Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.02,
                              right: MediaQuery.of(context).size.width * 0.05,
                              left: MediaQuery.of(context).size.width * 0.05),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Editor(
                                  note: note,
                                ),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[400],
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            note.title,
                                            style: GoogleFonts.nunito(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            DateFormat()
                                                .add_yMd()
                                                .format(
                                                  DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          note.created),
                                                )
                                                .toString(),
                                            style: GoogleFonts.nunito(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () async {
                                        await Database(uid: firebaseUser.uid)
                                            .deleteDocu(note.docId);
                                        userRepository.signOut();
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            )));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
