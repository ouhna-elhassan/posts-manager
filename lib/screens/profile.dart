import 'package:flutter/material.dart';
import '../components/profileCompnents.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:const Text(
              'Personal informations',
              style: TextStyle(
                fontSize: 21,
                //fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //const SizedBox(height: 1,),
            ownerImage(),
            const SizedBox(height: 17,),
            const Text(
              'Ouhna Elhassan',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 51,),
            infos('ouhna@gmail.com', context),
            const SizedBox(height: 15,),
            infos('Flutter developper', context),
            const SizedBox(height: 15),
            infos('terms & conditions', context),
            const SizedBox(height: 65,),
            infos('Sing out', context),
          ],
        ),
        ),
      ),
    );
  }
}