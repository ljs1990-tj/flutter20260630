import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : Center(
        child: Column(
          children: [
            Text(
                "Hello Flutter",
                style : TextStyle(
                    color : Colors.green,
                    fontWeight: FontWeight.bold
                )
            ),
            QrImageView(
              data: 'http://www.naver.com',
              version: QrVersions.auto,
              size: 200.0,
            ),
          ],
        ),
      )
    );
  }
}
