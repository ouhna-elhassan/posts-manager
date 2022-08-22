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
              /*
              IconButton(
                icon:const Icon(Icons.login_outlined,color: Colors.deepPurple,),
                onPressed:()async{
                  await FirebaseAuth.instance.signOut();
                  if(FirebaseAuth.instance.currentUser?.uid==null){
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setInt('loged', 0);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context)=>SingIn()),
                            (route) => false);
                  }
                }
                 ,
              ),*/
            ],
            backgroundColor: Colors.white,
          );
}