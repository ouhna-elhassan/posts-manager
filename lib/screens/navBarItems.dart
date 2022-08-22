import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import '../offline/offline.dart';
import 'posts.dart';
import 'profile.dart';
import 'search.dart';
import 'addPost.dart';
import '../components/appBar.dart';
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool iswificonnected = false;
  bool isInternetOn = false;
  int curr=0;
  final List _tabs=<Widget>[
      Posts(tag: "",),
      Search(),
      Add(),
      Profile(),
  ];

  void getConnect() async {
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

  @override
  void initState() {
    super.initState();
    getConnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body:isInternetOn?_tabs[curr]:OffLine(),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.search_outlined),label: 'Search'),
                BottomNavigationBarItem(icon: Icon(Icons.add_comment_outlined),label: 'Add post'),
                BottomNavigationBarItem(icon: Icon(Icons.person_outline),label: 'Me'),
              ],
              currentIndex: curr,
              type:BottomNavigationBarType.fixed,
              onTap: (int index){
                setState(() {
                  curr=index;
                });
              },
            ),
        );
  }
}
