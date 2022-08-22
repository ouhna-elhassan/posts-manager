import 'package:flutter/material.dart';
import '../firebase/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'navBarItems.dart';


class Singup extends StatefulWidget {
  const Singup({Key? key}) : super(key: key);

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {

  int m=0;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _fullname = TextEditingController();

  
  int i=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            i==0?const Text(
              'Register',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 27,
              ),
            ):const CircularProgressIndicator(color: Colors.blue,),
            const SizedBox(height: 13),
            const Text(
              'Create your account',
              style: TextStyle(

                fontSize: 19,
              ),
            ),
            const SizedBox(height: 75,),
            Container(
              padding:const EdgeInsets.only(left: 19),
              margin:const EdgeInsets.only(left: 25,right: 25),
              height: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.white,
                  boxShadow:const [
                    BoxShadow(
                      color: Color(0x9B9B9BD0),
                      offset:  Offset(
                        1.0,
                        1.0,
                      ),
                      blurRadius: 11.0,
                      spreadRadius: 0.0,
                    )
                  ]
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.perm_identity_outlined,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 19,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.65,
                    child: TextFormField(
                      controller: _fullname,
                      decoration:const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Full name',
                      ),
                    ),),
                ],
              ),
            ),
            const SizedBox(height: 19,),
            Container(
              padding:const EdgeInsets.only(left: 19),
              margin:const EdgeInsets.only(left: 25,right: 25),
              height: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.white,
                  boxShadow:const [
                    BoxShadow(
                      color: Color(0x9B9B9BD0),
                      offset:  Offset(
                        1.0,
                        1.0,
                      ),
                      blurRadius: 11.0,
                      spreadRadius: 0.0,
                    )
                  ]
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.email_outlined,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 19,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.65,
                    child: TextFormField(
                      controller: _email,
                      decoration:const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Email Address',
                      ),
                    ),),
                ],
              ),
            ),
            const SizedBox(height: 19,),
            Container(
              padding:const EdgeInsets.only(left: 19),
              margin:const EdgeInsets.only(left: 25,right: 25),
              height: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.white,
                  boxShadow:const [
                    BoxShadow(
                      color: Color(0x9B9B9BD0),
                      offset:  Offset(
                        1.0,
                        1.0,
                      ),
                      blurRadius: 11.0,
                      spreadRadius: 0.0,
                    )
                  ]
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.lock_outline,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 19,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.65,
                    child: TextFormField(
                      controller: _password,
                      decoration:const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Password',
                      ),
                    ),),
                ],
              ),
            ),
            const SizedBox(height: 55,),
            Container(
              width: MediaQuery.of(context).size.width*0.90,
              padding:const EdgeInsets.only(left: 19),
              margin:const EdgeInsets.only(left: 25,right: 25),
              height: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0x9B9B9BD0),
                        spreadRadius: 0,
                        blurRadius: 11,
                        offset: Offset(1, 1)
                    )
                  ]
              ),
              child: TextButton(
                onPressed: ()async{
                  if(_fullname.text.toString()==''){
                    Fluttertoast.showToast(msg: 'set user name');
                  }
                  else{
                    await singUp(_email.text.toString(), _password.text.toString(),_fullname.text.toString());
                    if(FirebaseAuth.instance.currentUser?.uid!=null){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                      }
                    else{
                      setState((){
                        i=0;
                      });
                    }
                  }
                },
                child:const Text(
                  'Sing In',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19
                  ),
                ),
              ),
            ),
            const SizedBox(height: 19,),
            const Text(
              "Already have an account?",
              style: TextStyle(
                  color: Color(0x575D655A),
                  fontSize: 19
              ),
            ),
            const SizedBox(height: 11,),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child:const Text(
                "LogIn Now",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 19
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}