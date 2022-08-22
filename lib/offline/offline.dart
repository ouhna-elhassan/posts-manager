import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../data/models.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'controlDB.dart';
import 'dart:io';

class OffLine extends StatefulWidget {
  OffLine({Key? key}) : super(key: key);


  @override
  State<OffLine> createState() => _OffLineState();
}

class _OffLineState extends State<OffLine> {


  List<PostOffline> listPosts = [];

  Future<void> getOffLinePosts() async {
    listPosts = await getStoredPosts();
  }

  @override
  void initState() {
    getOffLinePosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:const Text(
          'No access to internet',
          style: TextStyle(
            color: Color.fromARGB(255, 247, 150, 143)
          ),
        ),
      ),

      body: ListView.builder(
          itemCount: listPosts.length,
          itemBuilder: (context, index) {
            return Container(
                margin:const EdgeInsets.only(top: 40,left: 11,right: 11),
                padding:const EdgeInsets.only(left: 10,right: 10,top: 11,bottom: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow:const [
                      BoxShadow(
                          spreadRadius: 0,
                          blurRadius: 5,
                          color: Colors.blueGrey,
                          offset: Offset(1, 1)

                      )
                    ]
                ),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        listPosts[index].text,
                        style:const TextStyle(
                            fontSize: 23
                        ),
                      ),
                    ),
                    const SizedBox(height: 17,),
                    Image.file(File(listPosts[index].path))
                  ],
                ),
              );
          },
        ),

    );
  }
}