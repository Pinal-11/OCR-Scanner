import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocr_scanner/page/custom_page.dart';
import 'package:ocr_scanner/page/predefined_page.dart';
import 'package:ocr_scanner/page/square_page.dart';
import 'package:ocr_scanner/services/auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Image Cropper';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(
      primaryColor: Colors.black,
      accentColor: Colors.red,
    ),
    home: HomePage(),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>

    with SingleTickerProviderStateMixin {
  TabController controller;
  bool isGallery = true;
  int index = 2;
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 1, vsync: this);
  }

  Future<void> _signOut() async {
    try {
      await widget.auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.deepPurpleAccent,
      title: Text(MyApp.title,style: TextStyle(fontSize: 18),),
      centerTitle: false,
      actions: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right:8.0),
              child: TextButton(
                onPressed: _signOut,
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right:8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                isGallery ? 'Gallery' : 'Camera',
                style: TextStyle(fontSize:17, fontWeight: FontWeight.bold),
              ),
              Switch(
                value: isGallery,
                activeColor: Colors.deepPurpleAccent,
                inactiveThumbColor: Colors.black,
                onChanged: (value) => setState(() => isGallery = value),
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              IndexedStack(
                index: index,
                children: [
                  SquarePage(isGallery: isGallery),
                  CustomPage(isGallery: isGallery),
                  PredefinedPage(isGallery: isGallery),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
    bottomNavigationBar: buildBottomBar(),
  );

  Widget buildBottomBar() {
    final style = TextStyle(color: Colors.deepPurpleAccent[100]);

    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed,
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: Text('Cropper', style: style),
          title: Text('Square'),
        ),
        BottomNavigationBarItem(
          icon: Text('Cropper', style: style),
          title: Text('Custom'),
        ),
        BottomNavigationBarItem(
          icon: Text('Cropper', style: style),
          title: Text('Predefined'),
        ),
      ],
      onTap: (int index) => setState(() => this.index = index),
    );
  }
}
