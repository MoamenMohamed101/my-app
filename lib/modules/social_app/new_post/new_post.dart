import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewPost extends StatelessWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
    );
  }
}
