import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  static SharedPreferences? prefs;

  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // forShareprefs();
  }

  // bool isLogin = false;

  // forShareprefs() async {
  //   Splashscreen.prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     isLogin = Splashscreen.prefs!.getBool("loginstatus") ?? false;
  //   });
  //
  //   Future.delayed(Duration(seconds: 2)).then((value) {
  //     if (isLogin) {
  //       Navigator.push(context, MaterialPageRoute(
  //         builder: (context) {
  //           return const Dashboard();
  //         },
  //       ));
  //     } else {
  //       Navigator.push(context, MaterialPageRoute(
  //         builder: (context) {
  //           return const LoginPage();
  //         },
  //       ));
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Container(
          child: Text("app Testing"),
        ),
      ),
    );
  }
}
