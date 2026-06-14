import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_management/screens/home_screen.dart';
import 'package:task_management/screens/login_screen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("myBox");
   await Hive.openBox("authBox");
   await Hive.openBox("usersBox");
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  late Box authBox;
  @override
  void initState(){
    super.initState();
    authBox=Hive.box("authBox");
    authBox.listenable().addListener(_updateUI);
  }
  void _updateUI(){
    setState(() {

    });
  }
  @override
  void dispose(){
    authBox.listenable().removeListener(_updateUI);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final authBox = Hive.box("authBox");
    bool isLoggedIn =
    authBox.get("isLoggedIn", defaultValue: false);

    return MaterialApp(
      debugShowCheckedModeBanner:!true,
      title: 'Task Manager',
    home: isLoggedIn
        ? const HomeScreen()
        : LoginScreen(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}


