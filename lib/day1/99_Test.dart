import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[100],
          title : Text("테스트!"),
        ),
        drawer: Drawer(),
        body : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("가운데", style : TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
              SizedBox(height: 10,),
              IconButton(onPressed: (){}, icon: Icon(Icons.star, color: Colors.yellow, size: 200,)),
              SizedBox(height: 10,),
              Container(
                height: 100, width: 100,
                color: Colors.black,
                child: Center(child: Text("네모 박스!", style: TextStyle(color: Colors.white))),
              )
            ],
          ),
        )
      ),
    );
  }
}
