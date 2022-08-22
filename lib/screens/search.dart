import 'package:flutter/material.dart';
import '../data/models.dart';
import 'posts.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  final input4 = TextEditingController();
  int s=0;
  String tag='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFormField(
          controller: input4,
          decoration:const InputDecoration(
            border: InputBorder.none,
            labelText: 'Search by tag',
          ),
        ),
        actions: [
          Padding(
            padding:const EdgeInsets.only(right: 17),
            child: IconButton(
                onPressed: (){
                    setState(() {
                      s=(s+1)%2;
                    }
                  );
                },
                icon:const Icon(Icons.search,color: Colors.grey,)
            ),
          )
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const SizedBox(height: 15,),
          Container(
              height: 435,
              child:s==0? const Center(child: Text(
                'Add tag to search',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey
                ),
              ),
            ):Posts(tag: input4.text.toString(),)
          )
        ],
      ),
    );
  }
}