import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ProductEdit.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore fs = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('제품 목록'),
        backgroundColor: Colors.pink[100],
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue[300],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: '목록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: '등록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '마이페이지',
          ),
        ],
      ),
      body: StreamBuilder(
          stream: fs.collection("Product").snapshots(),
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
                    leading: Icon(Icons.star),
                    title : Text(
                        doc["productName"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.category),
                            SizedBox(width: 5,),
                            Text(doc["category"]),
                            SizedBox(width: 10,),
                            Icon(Icons.money),
                            SizedBox(width: 5,),
                            Text("￦ ${doc['price']}")
                          ],
                        ),
                        Text("# ${doc["info"]}")
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductEdit(docId: doc.id),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit)
                        ),
                        IconButton(
                            onPressed: () async{
                              await fs.collection("Product").doc(doc.id).delete();
                            },
                            icon: Icon(Icons.delete, color: Colors.red[500],)
                        )
                      ],
                    ),
                  );

                },
            );
          },
      ),
    );
  }
}