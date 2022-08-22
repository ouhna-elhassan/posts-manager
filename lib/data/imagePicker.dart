import 'dart:io';
import 'package:image_picker/image_picker.dart';


Future<File> pickerImageFromGallery() async{
  final _picker = ImagePicker();
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  if(pickedFile != null){
    return File(pickedFile.path);
  }
  return File('');
}


Future<File> pickerImageFromCamera() async{
  final _picker = ImagePicker();
  final pickedFile = await _picker.pickImage(source: ImageSource.camera);
  if(pickedFile != null){
    return File(pickedFile.path);
  }
  return File('');
}