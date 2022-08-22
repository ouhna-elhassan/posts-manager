import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';


Future<void> logIn(String email,String password)async{

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: '$e');
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      }
    }
}


Future<void> singUp(String email,String password,String fullName) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      String id = user!.uid;
      FirebaseFirestore db = FirebaseFirestore.instance;
      await db.collection("systeme").doc('users').collection('infos').doc(
          id)
          .set(
          {
            "fullName": fullName,
            "email": email,
            "password": password,
            "id": id,
          }
      );
      Fluttertoast.showToast(msg: 'User added');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'weak-password');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'The account already exists for that email.');
      }
    } catch (e) {
    }

}