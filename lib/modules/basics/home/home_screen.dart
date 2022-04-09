import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Container(
          decoration:const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image(
                image: NetworkImage(
                    'https://st3.depositphotos.com/3047333/12924/i/600/depositphotos_129246006-stock-photo-kitten-sitting-in-flowers.jpg'),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.amber.withOpacity(0.6),
                width: 200,
                child: Text(
                  'Flower Cat',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                padding: EdgeInsets.symmetric(vertical: 10),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: Icon(Icons.arrow_back_ios),
        title: Text('First App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('Iam search');
            },
          ),
          IconButton(
            icon: Icon(Icons.notification_add),
            onPressed: () {
              print('Iam notivcation');
            },
          ),
        ],
        centerTitle: true,
        elevation: 10,
      ),
    );
  }
}
