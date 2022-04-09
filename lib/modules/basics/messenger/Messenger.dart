import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() {
  runApp(MaterialApp(
    home: Messenger(),
  ));
}

class Messenger extends StatelessWidget {
  @override
  Widget buildchatitem() => Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    'https://static.politico.com/9e/f5/81ba3fa24bd88ef41dc060b41148/20210208-bill-gates-773.jpg'),
              ),
              CircleAvatar(
                radius: 6.5,
                backgroundColor: Colors.white,
              ),
              CircleAvatar(
                radius: 6,
                backgroundColor: Colors.green,
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bill Gates',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'I wanna you to help me please because i have error in my code',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      radius: 3,
                      backgroundColor: Colors.blue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('02.00 am')
                  ],
                )
              ],
            ),
          )
        ],
      );
  Widget buildstoryitem() => Container(
        width: 50,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://static.politico.com/9e/f5/81ba3fa24bd88ef41dc060b41148/20210208-bill-gates-773.jpg'),
                ),
                CircleAvatar(
                  radius: 6.5,
                  backgroundColor: Colors.white,
                ),
                CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.green,
                ),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'Bill Gates The Ceo of Microsoft',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                  'https://static.politico.com/9e/f5/81ba3fa24bd88ef41dc060b41148/20210208-bill-gates-773.jpg'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Chats',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            radius: 20,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.camera_alt),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: 20,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Search'),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(
                    width: 10,
                  ),
                  itemBuilder: (context, index) => buildstoryitem(),
                  itemCount: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemBuilder: (context, index) => buildchatitem(),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: 50),
            ],
          ),
        ),
      ),
    );
  }
}

