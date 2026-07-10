import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImagePickerScreen(),
    );
  }
}

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker(); // 이미지 선택을 위한 picker 객체

  Future<void> pickImage() async{
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        // 이미지 선택 시 _image 변수에 저장
        _image = File(pickedFile.path);
      });
    }
  }

Future<void> takePhoto() async{
  final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

  if (pickedFile != null) {
    setState(() {
      _image = File(pickedFile.path);
    });
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300, height: 300,
            decoration: BoxDecoration(
            ),
            child: _image != null ? ClipOval(

              child: Image.file(_image!, fit : BoxFit.cover),
            ) : Center(child: Text("이미지 선택되지 않았음"),),
          ), // 이미지 출력
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: takePhoto,
                  child: Text("카메라 촬영")
              ),
              ElevatedButton(
                  onPressed: pickImage,
                  child: Text("사진첩 선택")
              )
            ],
          )
        ],
      )
    );
  }
}
