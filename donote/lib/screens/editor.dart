import 'dart:convert';
import 'package:donote/model/note.dart';
import 'package:donote/sevices/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zefyr/zefyr.dart';

class Editor extends StatefulWidget {
  final Note note;
  Editor({this.note});
  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  ZefyrController _controller;
  FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    final document = _loadDocument(widget.note.body);
    _controller = ZefyrController(document);
    _focusNode = FocusNode();
  }

  final _kormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String title;
    return Scaffold(
      appBar: AppBar(
        title: Text('DoNote'),
        actions: [
          GestureDetector(
            onTap: () async {
              if (_kormKey.currentState.validate()) {
                print(title);
                if (title == null) {
                  String body = jsonEncode(_controller.document);
                  Database(uid: widget.note.uid)
                      .updateNote(widget.note.docId, widget.note.title, body)
                      .then((value) => Navigator.pop(context));
                } else {
                  String body = jsonEncode(_controller.document);
                  Database(uid: widget.note.uid)
                      .updateNote(widget.note.docId, title, body)
                      .then((value) => Navigator.pop(context));
                }
              }
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.save),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ZefyrScaffold(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Form(
                    key: _kormKey,
                    child: TextFormField(
                      initialValue: widget.note.title,
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
                          hintText: widget.note.title),
                      style: GoogleFonts.yrsa(
                        fontSize: 56,
                        color: Colors.grey[400],
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.note.author,
                  maxLines: 2,
                  style: GoogleFonts.yrsa(
                    color: Colors.grey[500],
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: ZefyrEditor(
                  controller: _controller,
                  mode: ZefyrMode.edit,
                  focusNode: _focusNode,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loadDocument(String body) {
    return NotusDocument.fromJson(jsonDecode(body));
  }
}
