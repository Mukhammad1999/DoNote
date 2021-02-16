import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Center(
        child: Text('This is posts'),
      ),
    ));
  }
}
