import 'package:flutter/material.dart';


Container ownerImage(){
  return Container(
    width: 125,
    height: 125,

    decoration: BoxDecoration(
      border: Border.all(
        color: Color.fromARGB(255, 133, 182, 222),
        width: 7
      ),
      color: Colors.blue,
      image:const DecorationImage(
        image:ExactAssetImage('assets/f1.jpeg'),
              fit: BoxFit.cover 
        ),
      borderRadius: BorderRadius.circular(100)
    ),
  );
}

Container infos(String txt,BuildContext context){
  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width*0.95,
    padding: const EdgeInsets.only(left: 19),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(27),
      boxShadow:const [
        BoxShadow(
          offset: Offset(1, 3),
          color: Color.fromARGB(255, 215, 215, 215),
          blurRadius: 7
        )
      ]
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
      txt,
      style:const TextStyle(
        fontSize: 15,
        //fontWeight: FontWeight.bold
      ),

    ),
    txt!='Sing out'?IconButton(
      onPressed:(){
      },
      icon:Icon(Icons.mode)
      ):Text('')
      ],
    )
  );
}