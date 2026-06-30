import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                title : Text("탭 바!"),
                bottom: TabBar(tabs: [
                  Tab(icon : Icon(Icons.image), text : "이미지"),
                  Tab(icon : Icon(Icons.list), text : "제품목록"),
                  Tab(icon : Icon(Icons.location_city), text : "위치"),
                ]),
              ),
              body : TabBarView(children: [
                Center(child: Image.asset("img1.png", width: double.infinity, height: double.infinity,),),
                ListView(
                  children: [
                    ListTile(leading: Image.asset("img1.png", width: 60, height: 60, fit : BoxFit.contain),
                      title : Text("아주 좋은 노트북", style : TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("150,000원, 인천 부평동"),
                      trailing: IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                      onTap: (){
                        print("제품 클릭했음!");
                      },
                    ),
                    Divider(height: 2, color: Colors.grey,),
                    ListTile(
                      leading: Image.asset("img2.png", width: 60, height: 60, fit : BoxFit.contain),
                      title : Text("꽤 괜찮은 자전거", style : TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("250,000원, 서울 강남구"),
                      trailing: IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                      onTap: (){
                        print("제품 클릭했음!");
                      },
                    ),
                  ],
                ),

                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage("img3.png"),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(onPressed: (){}, child: Text("버튼11"),),
                          ElevatedButton(onPressed: (){}, child: Text("버튼22")),
                        ],
                      ),
                    ],
                  ),
                )
              ])
          )
      ),
    );
  }
}
