import 'dart:convert';

import 'package:donote/model/note.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zefyr/zefyr.dart';

class Reader extends StatefulWidget {
  final Note note;
  Reader({this.note});
  @override
  _ReaderState createState() => _ReaderState();
}

class _ReaderState extends State<Reader> {
  ZefyrController _controller;
  FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    final document = _loadDocument(widget.note.body);
    _controller = ZefyrController(document);
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ZefyrScaffold(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Text(
                  widget.note.title,
                  maxLines: 2,
                  style: GoogleFonts.yrsa(
                    color: Colors.grey[600],
                    fontSize: 56,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
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
                  mode: ZefyrMode.view,
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
