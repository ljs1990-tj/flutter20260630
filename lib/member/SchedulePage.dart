import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';


class SchedulePage extends StatefulWidget {
  final String memberDocId; // 로그인한 회원의 문서 ID

  const SchedulePage({super.key, required this.memberDocId});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  TextEditingController scheduleCtrl = TextEditingController();

  Future<void> addSchedule() async {
    // 문서의 하위 컬렉션(schedule)에 추가
    await fs.collection("member")
            .doc(widget.memberDocId)
            .collection("schedule")
            .add({
              "content" : scheduleCtrl.text,
              "date" : "7월 12일" // 하드코딩 대체
    });

    scheduleCtrl.clear();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('개인일정관리')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: scheduleCtrl,
                    decoration: InputDecoration(
                      labelText: '새 일정',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addSchedule,
                  child: Text('추가'),
                ),
              ],
            ),
          ),
          Expanded(
            // 해당 회원의 하위 컬렉션(schedules)만 실시간 스트림으로 가져옴
            child: StreamBuilder(
                stream: fs.collection("member")
                          .doc(widget.memberDocId)
                          .collection("schedule")
                          .snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  var docs = snapshot.data!.docs;
                  return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        var doc = docs[index];
                        return ListTile(
                          leading: Icon(Icons.check_circle),
                          title : Text(doc["content"] ?? ""),
                          trailing: IconButton(
                              onPressed: (){
                                fs.collection("member")
                                    .doc(widget.memberDocId)
                                    .collection("schedule")
                                    .doc(doc.id)
                                    .delete();
                              },
                              icon: Icon(Icons.delete, color : Colors.red[500])
                          ),
                        );
                      },
                  );
                },
            ),
          ),
        ],
      ),
    );
  }
}