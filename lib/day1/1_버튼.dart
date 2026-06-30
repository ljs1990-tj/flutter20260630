import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : Scaffold(
        body : Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.home, size : 30),
              IconButton(onPressed: (){
                print("아이콘 버튼 클릭 됨!");
              }, icon: Icon(Icons.home, size : 30)),
              ElevatedButton(onPressed: (){
                print("일반 버튼 클릭 됨!");
              }, child: Text("클릭!"))
            ],
          ),
        )
      )
    );
  }
}
