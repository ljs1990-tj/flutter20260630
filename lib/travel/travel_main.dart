import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import '../firebase_options.dart';
import 'travel_schedule_screen.dart';

void main() async {
  // Flutter 프레임워크와의 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Firebase 초기화 설정
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Planner UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3F51B5), // 신뢰감을 주는 네이비/블루
          primary: const Color(0xFF3F51B5),
          secondary: const Color(0xFF00BFA5), // 산뜻한 민트 포인트
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      home: const TravelRoomListScreen(),
    );
  }
}

class TravelRoomListScreen extends StatelessWidget {
  const TravelRoomListScreen({super.key});

  // 샘플 데이터 (Firestore의 상위 컬렉션 'travel_rooms' 데이터 모델 시각화)
  final List<Map<String, String>> travelRooms = const [
    {
      'id': 'room_01',
      'title': '제주도 3박 4일 힐링 여행',
      'period': '2026.07.15 ~ 2026.07.18',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=600&auto=format&fit=crop&q=80',
    },
    {
      'id': 'room_02',
      'title': '부산 맛집 탐방 & 호캉스',
      'period': '2026.08.02 ~ 2026.08.04',
      'image': 'https://wimg.mk.co.kr/meet/neds/2021/11/image_readmed_2021_1053506_16362360634839724.jpg',
    },
    {
      'id': 'room_03',
      'title': '경주 역사 문화 투어',
      'period': '2026.09.20 ~ 2026.09.22',
      'image': 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=600&auto=format&fit=crop&q=80',
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '나의 여행 폴더',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: travelRooms.length,
        itemBuilder: (context, index) {
          final room = travelRooms[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                // 특정 여행 방의 ID와 제목을 가지고 서브컬렉션 화면으로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TravelScheduleScreen(
                      roomId: room['id']!,
                      roomTitle: room['title']!,
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 여행지 가상 이미지 영역
                  Image.network(
                    room['image']!,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 160,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image, size: 50, color: Colors.grey),
                      );
                    },
                  ),
                  // 여행 정보 텍스트 영역
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          room['title']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 8),
                            Text(
                              room['period']!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // Create(생성) 액션 테스트용 가상 버튼
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('새 여행 폴더 생성 (Create)'),
              content: const TextField(
                decoration: InputDecoration(
                  hintText: '여행 제목을 입력하세요',
                  border: OutlineInputBorder(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('취소'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('생성'),
                ),
              ],
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('여행 추가'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.white,
      ),
    );
  }
}