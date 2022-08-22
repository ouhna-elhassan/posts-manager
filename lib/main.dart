import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/navBarItems.dart';
import 'firebase_options.dart';
import 'firebase/Auth.dart';
import 'screens/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isLoged = false;
 
  Future<bool> isLogedIn() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    final loged = prefs.getInt('loged');
    if (loged == 1) {
      return true;
    } else {
      await prefs.setInt('loged', 0);
      return false;
    }

  }

  @override
  void initState() {
    super.initState();
    isLogedIn();
  }

  @override
  Widget build(BuildContext context) {
    return  HomePage();//isLogedIn()==true?HomePage():SingIn()
  }

}