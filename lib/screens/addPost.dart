import 'package:flutter/material.dart';
import '../data/models.dart';
import 'package:flutter/material.dart';
import '../apiLayer/requests.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../data/imagePicker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../components/addPostTemplate.dart';
class Add extends StatefulWidget {
  Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {

  File? _imageFile;
  final _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  List<dynamic> tags=[];
  TextEditingController input3 =TextEditingController();
  TextEditingController input2 =TextEditingController();
  TextEditingController input1 =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Padding(
          padding: EdgeInsets.only(left: 0),
          child:Text(
              'Add a post',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
                color: Colors.black
              ),
            )
          ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding:const EdgeInsets.only(left: 15,right: 15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              GestureDetector(
                child: _imageFile==null?template(context):Image.file(_imageFile!),
                onTap: () async{
                  File? _image = await pickerImageFromGallery();
                  setState(() {
                    _imageFile = _image;
                  });
                }
              ),
              const SizedBox(height: 15,),
              const Text(
                'Add tags',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 9,),
              Container(
              padding:const EdgeInsets.only(left: 5),
              width: MediaQuery.of(context).size.width*0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
                boxShadow:const [
                  BoxShadow(
                    offset: Offset(2, 5),
                    color: Color.fromARGB(255, 218, 218, 218),
                    blurRadius: 9
                  )
                ]
              ),
              child: ListTile(
                title: TextFormField(
                  controller: input3,
                  decoration:const  InputDecoration(
                    border: InputBorder.none,
                    hintText: 'write here...'
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please add tag';
                    }
                    return null;
                  },
                ),
                trailing: IconButton(
                    onPressed: (){addtag(input3.text.toString());},
                    icon:const Icon(Icons.done_outline_sharp,color: Colors.blue,)
                ),
              ),
            ),
            const SizedBox(height: 15,),
            const Text(
              'Additional details',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 9,),
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              padding:const EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
                boxShadow:const [
                  BoxShadow(
                    offset: Offset(2, 5),
                    color: Color.fromARGB(255, 218, 218, 218),
                    blurRadius: 9
                  )
                ]
              ),
              child: TextFormField(
                controller: input1,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 5,
                decoration:const  InputDecoration(
                  border: InputBorder.none,
                  hintText: 'write here...',
                ),
                validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                },
              ),
            ),
            const SizedBox(height: 15,),
            Center(
            child: Container(
              width: MediaQuery.of(context).size.width*0.93,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.circular(5)
              ),
              child: TextButton(
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      bool b = await createPost(input1.text.toString(), _imageFile.toString(), tags);
                        if(b){setState(() {
                          tags=[];
                        });}
                    }
                  },
                  child: const Text('Add',style:TextStyle(color:Colors.white))
                ),
              ),
            ),
            ],
          ),
        )
      ),

    );
  }

  void addtag(String tag){
    setState(() {
      tags.add(tag);
      Fluttertoast.showToast(msg:'tag added');
    });
  }

}