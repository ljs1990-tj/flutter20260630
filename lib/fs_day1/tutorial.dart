import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShowcaseView Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TutorialScreen(),
    );
  }
}

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final GlobalKey _firstTargetKey = GlobalKey();
  final GlobalKey _secondTargetKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // [핵심 1] 화면 초기화 시 ShowcaseView를 시스템에 등록(register)합니다.
    ShowcaseView.register();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // [핵심 2] ShowCaseWidget.of(context) 대신 ShowcaseView.get()을 사용해 튜토리얼을 시작합니다.
      ShowcaseView.get().startShowCase([
        _firstTargetKey,
        _secondTargetKey,
      ]);
    });
  }

  @override
  void dispose() {
    // [핵심 3] 화면을 벗어날 때 메모리 누수 방지를 위해 꼭 등록을 해제(unregister)해 줍니다.
    ShowcaseView.get().unregister();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('쇼케이스 튜토리얼'),
        actions: [
          // UI 요소를 Showcase로 감싸는 방법은 기존과 동일합니다.
          Showcase(
            key: _firstTargetKey,
            title: '설정 메뉴',
            description: '여기에서 앱 설정을 변경할 수 있습니다.',
            tooltipBackgroundColor: Colors.blueAccent,
            textColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                debugPrint('설정 버튼 클릭');
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          '튜토리얼!',
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: Showcase(
        key: _secondTargetKey,
        title: '항목 추가',
        description: '새로운 여행 일정을 추가하려면\n이 버튼을 누르세요.',
        targetShapeBorder: CircleBorder(),
        child: FloatingActionButton(
          onPressed: () {
            debugPrint('추가 버튼 클릭');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}