import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:sosu_web/src/icons/teacher_icon.dart';
import 'package:sosu_web/src/network/http_client.dart';
import 'package:sosu_web/src/ui/dash_board/main_dash_board.dart';
import 'package:sosu_web/src/ui/design_system/main_design_system.dart';
import 'package:sosu_web/src/ui/settings/main_settings.dart';
import 'package:sosu_web/src/ui/student/main_student.dart';
import 'package:sosu_web/src/ui/style/design_system.dart';
import 'package:sosu_web/src/ui/table.dart';
import 'package:sosu_web/src/ui/teacher/main_teacher.dart';

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
      title: 'SOSU Web',
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

class Views {
  final SideNavigationBarItem navigation;
  final Widget page;

  Views(this.navigation, this.page);
}

class _MainViewState extends State<MainView> {
  int selectedIndex = 0; // 현재 선택한 네비게이션 위치값
  late List<Views> views = [];

  _MainViewState() {
    initNavigationViews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Row(
        children: [
          // MainSideNavigation(
          // selectedIndex: selectedIndex,
          // onTap: (index) {
          //   setState(() {
          //     selectedIndex = index;
          //   });
          // }),
          SideNavigationBar(
              selectedIndex: selectedIndex,
              items: views.map((e) => e.navigation).toList(),
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              toggler: SideBarToggler(
                  expandIcon: Icons.keyboard_arrow_left,
                  shrinkIcon: Icons.keyboard_arrow_right,
                  onToggle: () {}),
              header: SideNavigationBarHeader(
                  image: const CircleAvatar(child: Icon(Icons.school)),
                  title: TvStyle.t3_B(title: "SOSU Academy"),
                  subtitle: TvStyle.t3(title: "Hello")),
              footer: SideNavigationBarFooter(
                  label: TvStyle.t5(title: "DesignBy sieunju")),
              initiallyExpanded: false),
          Expanded(
            child: views
                .elementAt(selectedIndex)
                .page,
          )
        ],
      ),
    );
  }

  ///
  /// 네비게이션바 초기화 처리함수
  ///
  void initNavigationViews() {
    views.add(Views(SideNavigationBarItem(icon: Icons.dashboard, label: "대쉬보드"),
        MainDashBoardPage()));
    views.add(Views(SideNavigationBarItem(icon: Icons.person, label: "학생"),
        MainStudentPage()));
    views.add(Views(SideNavigationBarItem(icon: Teacher.teacher, label: "선생님"),
        MainTeacherPage()));
    views.add(Views(SideNavigationBarItem(icon: Icons.dashboard, label: "대쉬보드"),
        MainDashBoardPage()));
    views.add(Views(
        SideNavigationBarItem(icon: Icons.card_giftcard, label: "디자인 컴포넌트"),
        MainDesignSystemPage()));
    views.add(Views(
        SideNavigationBarItem(icon: Icons.table_chart, label: "테이블"),
        MainTablePage()));
    views.add(Views(SideNavigationBarItem(icon: Icons.settings, label: "셋팅"),
        MainSettingsPage()));
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
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,
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
