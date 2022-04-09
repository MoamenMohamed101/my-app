import 'package:flutter/material.dart';
import 'package:first_app/models/user/user_model.dart';

class Usersscreen extends StatelessWidget {
  biulduseritem(Usermodel users) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              child: Text(
                '${users.id}',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${users.name}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${users.phone}',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      );
  List<Usermodel> users = [
    Usermodel(id: 1, name: 'Moamen', phone: '01270492019'),
    Usermodel(id: 2, name: 'Mohamed', phone: '00492019'),
    Usermodel(id: 3, name: 'Magdy', phone: '0897'),
    Usermodel(id: 4, name: 'Zakria', phone: '798789'),
    Usermodel(id: 5, name: 'Mahmoud', phone: '897897'),
    Usermodel(id: 7, name: 'Hassan', phone: '011258878'),
    Usermodel(id: 8, name: 'Hamed', phone: '01125878'),
    Usermodel(id: 9, name: 'Hoseen', phone: '01125458878'),
    Usermodel(id: 10, name: 'yasser', phone: '011255648878'),
    Usermodel(id: 11, name: 'fady', phone: '01125887878'),
    Usermodel(id: 12, name: 'Hatem', phone: '0112587878'),
    Usermodel(id: 13, name: 'wael', phone: '011258878'),
    Usermodel(id: 14, name: 'Mohamed', phone: '0112587878'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => biulduseritem(users[index]),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 20),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
          itemCount: users.length),
    );
  }
}

