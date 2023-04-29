import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sosu_web/src/icons/custom_icons.dart';
import 'package:sosu_web/src/network/http_client.dart';
import 'package:sosu_web/src/ui/attendance/main_attendance.dart';
import 'package:sosu_web/src/ui/counseling/main_counseling_journal.dart';
import 'package:sosu_web/src/ui/dash_board/main_dash_board.dart';
import 'package:sosu_web/src/ui/student/main_student.dart';
import 'package:sosu_web/src/ui/style/design_system.dart';
import 'package:sosu_web/src/ui/teacher/main_teacher.dart';
import 'package:sosu_web/strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.APP_NAME,
      theme: ThemeData(
        secondaryHeaderColor: Colors.amber,
        primaryColor: Colors.blueAccent,
        primarySwatch: Colors.blue,
      ),
      home: const MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  String _selectedPageKey = Strings.MAIN;
  late final List<Widget> _menus = [];
  late final Map<String, Widget> _pageMap = {};

  _MainViewState() {
    _initView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TvStyle.t2(title: _selectedPageKey, color: Colors.white)),
      body: _pageMap[_selectedPageKey],
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: _menus,
        ),
      ),
    );
  }

  ///
  /// 네비게이션 메뉴 생성 처리 함수
  /// 1. 학생정보 (버튼 클릭 X)
  ///   - 목록
  ///   - 수납
  /// 2. 출석부
  /// 3. 선생님 (버튼 클릭 X)
  ///   - 목록
  ///   - 시간표
  /// 4. 상담 일지 및 메모
  ///   - 상담 일지
  ///   - 메모
  ///
  void _initView() {
    _menus.add(DrawerHeader(
        decoration: BoxDecoration(color: Colors.blue),
        child: InkWell(
          child: Card(
            elevation: 6,
            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                    radius: 25,
                    backgroundImage: CachedNetworkImageProvider(
                        Strings.LOGO_URI,
                        maxWidth: 25,
                        maxHeight: 25)),
                TvStyle.t1_B(title: Strings.APP_NAME)
              ],
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            _setPage(Strings.MAIN);
          },
        )));
    _pageMap[Strings.MAIN] = const MainDashBoardPage();
    _initStudentMenu(_menus, _pageMap);
    _initAttendanceMenu(_menus, _pageMap);
    _initTeacherMenu(_menus, _pageMap);
    _initMemoMenu(_menus, _pageMap);
  }

  /// 페이징 변경 처리 함수
  /// [key] 페이지 맵에 구성된 키
  void _setPage(String key) {
    setState(() {
      _selectedPageKey = key;
    });
  }

  /// 학생 정보 메뉴 및 페이지 초기화 함수
  /// [menus] 네비게이션 메뉴 리스트
  /// [pageMap] 메인 페이지 맵
  void _initStudentMenu(List<Widget> menus, Map<String, Widget> pageMap) {
    String listKey = "${Strings.MENU_STUDENT}_${Strings.MENU_STUDENT_LIST}";
    String recipientKey =
        "${Strings.MENU_STUDENT}_${Strings.MENU_STUDENT_RECIPIENCE}";

    menus.add(ExpansionTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(JICons.teacher),
          const SizedBox(width: 16),
          TvStyle.t3(title: Strings.MENU_STUDENT)
        ],
      ),
      initiallyExpanded: true,
      children: [
        ListTile(
          title: TvStyle.t4(title: Strings.MENU_STUDENT_LIST),
          onTap: () {
            // 학생정보 목록 페이지 이동
            Navigator.pop(context);
            _setPage(listKey);
          },
        ),
        ListTile(
          title: TvStyle.t4(title: Strings.MENU_STUDENT_RECIPIENCE),
          onTap: () {
            // 수납 (이전 수납기록, 오늘 수납기록
            Navigator.pop(context);
            _setPage(recipientKey);
          },
        )
      ],
    ));
    // 페이지 구성
    pageMap[listKey] = const MainStudentPage();
    pageMap[recipientKey] = const MainStudentPage();
  }

  /// 출석부 메뉴 초기화 함수
  /// [menus] 네비게이션 메뉴 리스트
  /// [pageMap] 메인 페이지 맵
  void _initAttendanceMenu(List<Widget> menus, Map<String, Widget> pageMap) {
    menus.add(ListTile(
      leading: Icon(
        Icons.abc_rounded,
        color: Colors.blue,
      ),
      title: TvStyle.t3(title: Strings.MENU_ATTENDANCE),
      onTap: () {
        // 출석부 페이지로 이동
        Navigator.pop(context);
        _setPage(Strings.MENU_ATTENDANCE);
      },
    ));
    pageMap[Strings.MENU_ATTENDANCE] = MainAttendancePage();
  }

  /// 선생님 메뉴 초기화
  /// [menus] 네비게이션 메뉴 리스트
  /// [pageMap] 메인 페이지 맵
  void _initTeacherMenu(List<Widget> menus, Map<String, Widget> pageMap) {
    String listKey = "${Strings.MENU_TEACHER}_${Strings.MENU_TEACHER_LIST}";
    String timeTableKey =
        "${Strings.MENU_TEACHER}_${Strings.MENU_TEACHER_TIME_TABLE}";
    menus.add(ExpansionTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.school),
          const SizedBox(width: 16),
          TvStyle.t3(title: Strings.MENU_TEACHER)
        ],
      ),
      initiallyExpanded: true,
      children: [
        ListTile(
          title: TvStyle.t4(title: Strings.MENU_TEACHER_LIST),
          onTap: () {
            // 목록 (상세 페이지)
            Navigator.pop(context);
            _setPage(listKey);
          },
        ),
        ListTile(
          title: TvStyle.t4(title: Strings.MENU_TEACHER_TIME_TABLE),
          onTap: () {
            // 시간표 (이번달 전체 선생님 시간표,
            // BottomSheetDialog 로 선생님들 선택해서 해당 시간표 볼수 있도록), 시간표 다운로드
            Navigator.pop(context);
            _setPage(timeTableKey);
          },
        )
      ],
    ));
    pageMap[listKey] = MainTeacherPage(); // 선생님 목록 페이지
    pageMap[timeTableKey] = MainTeacherPage(); // 페이지 추가 예정
  }

  /// 상담일지 및 메모 메뉴
  /// [menus] 네비게이션 메뉴 리스트
  /// [pageMap] 메인 페이지 맵
  void _initMemoMenu(List<Widget> menus, Map<String, Widget> pageMap) {
    menus.add(ExpansionTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.school),
          const SizedBox(width: 16),
          TvStyle.t3(title: Strings.MENU_CJ_AND_M)
        ],
      ),
      initiallyExpanded: true,
      children: [
        ListTile(
          title: TvStyle.t4(title: Strings.MENU_CJ_AND_M_COUNSLING),
          onTap: () {
            // 목록 (상세 페이지)
            Navigator.pop(context);
            _setPage(Strings.MENU_CJ_AND_M_COUNSLING);
          },
        ),
        ListTile(
          title: TvStyle.t4(title: Strings.MENU_CJ_AND_M_MEMO),
          onTap: () {
            Navigator.pop(context);
            _setPage(Strings.MENU_CJ_AND_M_MEMO);
          },
        )
      ],
    ));
    pageMap[Strings.MENU_CJ_AND_M_COUNSLING] = MainConsultationPage();
    pageMap[Strings.MENU_CJ_AND_M_MEMO] = MainMemoPage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  HttpClient client = HttpClient();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
