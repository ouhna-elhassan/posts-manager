import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

DottedBorder template(BuildContext context){
  return DottedBorder(
      borderType: BorderType.RRect,
      radius:const Radius.circular(20),
      dashPattern: [10, 10],
      color: Colors.grey,
      strokeWidth: 2,
      child: Container(
        height: MediaQuery.of(context).size.height*0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children:const [
            Icon(
              Icons.image,
              color: Colors.deepOrange,
              size: 67,
            ),
            Text(
              'Add image Here',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
        )
      )
    );
}