import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : Scaffold( // 상단, 중앙, 하단을 알아서 잘 나눠준 위젯
        appBar: AppBar(
          title : Text("타이틀 영역!!"),
          backgroundColor: Colors.blue[100],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(color : Colors.blue[100]),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage("img3.png"),
                      ),
                      SizedBox(height: 10,),
                      Text("망그러진 곰", style: TextStyle(fontSize : 13, fontWeight: FontWeight.bold),),
                      Text("test@naver.com", style: TextStyle(color : Colors.deepOrange, fontSize : 13, fontWeight: FontWeight.bold),)
                    ],
                  )
              ),
              ListTile(
                leading: Icon(Icons.home),
                title : Text("홈"),
                onTap: (){},
              ),
              // Divider(height: 1, color : Colors.grey),
              ListTile(
                leading: Icon(Icons.settings),
                title : Text("옵션"),
                onTap: (){},
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title : Text("로그아웃"),
                onTap: (){},
              ),
            ],
          ),
        ),
        body : Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 100, width: double.infinity,
            color: Colors.purpleAccent,
            // margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
            padding: EdgeInsets.all(10),
            child: Text("Hello Flutter"),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.home), iconSize: 40,),
              IconButton(onPressed: (){}, icon: Icon(Icons.login), iconSize: 40,),
              IconButton(onPressed: (){}, icon: Icon(Icons.logout), iconSize: 40,)
            ],
          ),
        ),
      )
    );
  }
}
