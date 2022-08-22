import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../firebase/Auth.dart';
import '../screens/login.dart';

AppBar appBar(BuildContext context){
  return AppBar(
            automaticallyImplyLeading:false,
            shape:const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            title: const Text(
              'Dummy API: \nPosts manager ',
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            toolbarHeight:100,
            actions:const[
              CircleAvatar(
                radius: 31,
                backgroundImage: AssetImage('f1.jpeg'),
              )
            ],
            backgroundColor: Colors.white,
          );
}