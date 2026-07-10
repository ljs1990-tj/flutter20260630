import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TravelScheduleScreen extends StatelessWidget {
  final String roomId;
  final String roomTitle;

  const TravelScheduleScreen({
    super.key,
    required this.roomId,
    required this.roomTitle,
  });

  // 샘플 데이터 (특정 roomId에 종속되는 서브컬렉션 'schedules' 데이터 구조 모델링)
  final List<Map<String, dynamic>> schedules = const [
    {
      'day': 1,
      'time': '10:00',
      'title': '공항 도착 및 렌트카 인수',
      'type': 'transport', // transport, food, spot, hotel
      'memo': '공항 5번 출구 셔틀버스 구역 확인하기',
    },
    {
      'day': 1,
      'time': '12:30',
      'title': '유명 로컬 고기국수 맛집 점심',
      'type': 'food',
      'memo': '원격 웨이팅 미리 체크하기',
    },
    {
      'day': 1,
      'time': '15:00',
      'title': '에메랄드빛 해수욕장 카페 정복',
      'type': 'spot',
      'memo': '바다 배경으로 이쁜 인생사진 남기기',
    },
    {
      'day': 2,
      'time': '09:30',
      'title': '성산일출봉 가벼운 등반',
      'type': 'spot',
      'memo': '왕복 50분 소요, 편한 신발 필수',
    },
    {
      'day': 2,
      'time': '13:00',
      'title': '성산 근처 갈치조림 맛집 식사',
      'type': 'food',
      'memo': '매콤하고 두툼한 갈치 전문점 방문',
    },
    {
      'day': 3,
      'time': '11:00',
      'title': '숙소 체크아웃 및 소품샵 투어',
      'type': 'hotel',
      'memo': '아기자기한 기념품 소량 구매하기',
    },
  ];

  // 카테고리별 직관적인 아이콘 지정 함수
  IconData _getIcon(String type) {
    switch (type) {
      case 'transport':
        return Icons.directions_car;
      case 'food':
        return Icons.restaurant;
      case 'spot':
        return Icons.photo_camera;
      case 'hotel':
        return Icons.hotel;
      default:
        return Icons.place;
    }
  }

  // 카테고리별 테마 색상 지정 함수
  Color _getColor(String type) {
    switch (type) {
      case 'transport':
        return Colors.blue;
      case 'food':
        return Colors.orange;
      case 'spot':
        return Colors.green;
      case 'hotel':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Day 1, Day 2, Day 3 시각화
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            roomTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Day 1'),
              Tab(text: 'Day 2'),
              Tab(text: 'Day 3'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildDayScheduleList(context, 1),
            _buildDayScheduleList(context, 2),
            _buildDayScheduleList(context, 3),
          ],
        ),
        // 서브컬렉션 아이템 추가(Create) 액션용 버튼
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('새 세부 일정 추가 (Create)'),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: '방문 시간 (예: 14:30)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      decoration: InputDecoration(
                        labelText: '활동 또는 장소명',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('취소'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('추가'),
                  ),
                ],
              ),
            );
          },
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Colors.white,
          child: const Icon(Icons.add_location_alt),
        ),
      ),
    );
  }

  // 각 일차별로 데이터를 분할 필터링하여 리스트 뷰를 그리는 함수
  Widget _buildDayScheduleList(BuildContext context, int dayNum) {
    final daySchedules = schedules.where((s) => s['day'] == dayNum).toList();

    if (daySchedules.isEmpty) {
      return const Center(
        child: Text(
          '등록된 세부 일정이 없습니다.\n하단 아이콘을 눌러 추가해 보세요.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      itemCount: daySchedules.length,
      itemBuilder: (context, index) {
        final item = daySchedules[index];
        final typeColor = _getColor(item['type']);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: Colors.grey[200]!),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 좌측: 타임라인 및 이모지/카테고리 서클 뱃지
                Column(
                  children: [
                    Text(
                      item['time'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CircleAvatar(
                      backgroundColor: typeColor.withOpacity(0.1),
                      radius: 20,
                      child: Icon(
                        _getIcon(item['type']),
                        color: typeColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                // 우측: 텍스트 정보 및 수정/삭제 제어 옵션 메뉴 버튼
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item['title'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Update(수정) / Delete(삭제) 시각화 팝업
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('[$value] 이벤트 요청 신호 감지'),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: '수정(Update)',
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, size: 18, color: Colors.blue),
                                    SizedBox(width: 8),
                                    Text('수정'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                value: '삭제(Delete)',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, size: 18, color: Colors.red),
                                    SizedBox(width: 8),
                                    Text('삭제', style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                            ],
                            icon: const Icon(Icons.more_vert, color: Colors.grey),
                          ),
                        ],
                      ),
                      if (item['memo'].toString().isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          item['memo'],
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}