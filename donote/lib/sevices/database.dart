import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donote/model/note.dart';
import 'package:donote/model/user.dart';
import 'package:flutter/cupertino.dart';

class Database {
  final String uid;
  Database({this.uid});

  CollectionReference notes = FirebaseFirestore.instance.collection('notes');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future saveNote(String content, String name, String title) async {
    try {
      await notes.doc().set(
          {
            'title': title,
            'author': name,
            'body': content,
            'createdAt': DateTime.now().millisecondsSinceEpoch,
            'uid': uid,
          },
          SetOptions(
            merge: true,
          ));
    } catch (e) {
      e.toString();
    }
  }

  Future updateNote(String docId, String title, String body) async {
    try {
      await notes.doc(docId).set(
        {
          'title': title,
          'body': body,
        },
        SetOptions(
          merge: true,
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  UserData _getUserdata(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'].toString() ?? 'NonMae',
      photo: snapshot.data()['photoURL'] ?? '',
    );
  }

  Stream<UserData> get userData {
    return users.doc(uid).snapshots().map(_getUserdata);
  }

  Future saveUser(String name, String photoUrl) async {
    try {
      await users.doc(uid).set(
          {
            'createdAt': DateTime.now(),
            'name': name,
            'uid': uid,
            'photoURL': photoUrl,
          },
          SetOptions(
            merge: true,
          )).then((value) => print('hello'));
    } catch (e) {
      print(e.toString());
    }
  }

  List<Note> _getNotes(QuerySnapshot snapshot) {
    try {
      return snapshot.docs
          .map(
            (e) => Note(
                docId: e.id ?? '',
                title: e.data()['title'] ?? '',
                body: e.data()['body'] ?? '',
                author: e.data()['author'] ?? '',
                created: e.data()['createdAt'] ??
                    DateTime.now().millisecondsSinceEpoch,
                uid: e.data()['uid'] ?? ''),
          )
          .toList();
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteDocu(String doc) async {
    try {
      await notes.doc(doc).delete();
    } catch (e) {
      e.toString();
    }
  }

  Stream<List<Note>> get getWholeNotes {
    return notes.where('uid', isNotEqualTo: uid).snapshots().map(_getNotes);
  }

  Stream<List<Note>> get myNotes {
    return notes.where('uid', isEqualTo: uid).snapshots().map(_getNotes);
  }
}
