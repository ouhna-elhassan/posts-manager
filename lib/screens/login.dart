import'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../main.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/navBarItems.dart';
import '../firebase/Auth.dart';
import 'singUp.dart';


class SingIn extends StatelessWidget {
  const SingIn({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const Login(),
    );
  }
}


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  int i = 0;
  final _formKey = GlobalKey<FormState>();

  
  @override
  void initState() {
    super.initState();
    GetConnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Form(
        key: _formKey,
        child:SingleChildScrollView(//!isInternetOn?off() :
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.21,),
            i==0?const Text(
              'Welcome Back',
              style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.bold
              ),
            ):const CircularProgressIndicator(color: Colors.indigo,),
            SizedBox(height: MediaQuery.of(context).size.height*0.10,),
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
                      controller: _email,
                      decoration:const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
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
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x9B9B9BD0),
                    spreadRadius: 0,
                    blurRadius: 11,
                    offset: Offset(1, 1)
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
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      
                      decoration:const InputDecoration(
                        
                        border: InputBorder.none,
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                  ),),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.10,),
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
                  if (_formKey.currentState!.validate()){
                    setState((){
                    i=1;
                  });

                  await logIn(_email.text.toString(), _password.text.toString());
                  if(FirebaseAuth.instance.currentUser?.uid!=null){
                    final prefs = await SharedPreferences.getInstance();

// set value
                    await prefs.setInt('loged', 1);
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
              "Don't have an account?",
              style: TextStyle(
                  color: Color(0x575D655A),
                  fontSize: 19
              ),
            ),
            const SizedBox(height: 19,),
            TextButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Singup()));
                },
                child:const Text(
                  "Sing Up Now",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 19
                  ),
                ),
            )
          ],
        ),
      )
      )
      
    );
  }
  bool iswificonnected = false;
  bool isInternetOn = false;
  void GetConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (!(connectivityResult == ConnectivityResult.none)) {
      setState(() {
        isInternetOn = true;
      });
    } else{
      setState(() {
        isInternetOn = false;
      });
    }

  }
}

