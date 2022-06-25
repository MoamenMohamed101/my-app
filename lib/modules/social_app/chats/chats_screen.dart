import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // get
        },
        child: const Icon(Icons.add),
      ),
    ) ;
  }
}
// Center(
//       child: Text('Chats'),
//     );