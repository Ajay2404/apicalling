import 'dart:convert';

import 'package:apicalling/dashboard.dart';
import 'package:apicalling/logindata.dart';
import 'package:apicalling/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextField(
          controller: email,
          decoration: InputDecoration(hintText: "Email"),
        ),
        TextField(
          controller: password,
          decoration: InputDecoration(hintText: "Password"),
        ),
        ElevatedButton(
            onPressed: () async {
              String loginemail = email.text;
              String loginpassword = password.text;
              Map map1 = {
                "remail": loginemail,
                "rpassword": loginpassword,
              };
              var url = Uri.parse(
                  'https://meetytesting24.000webhostapp.com/apicalling/login.php');
              var response = await http.post(url, body: map1);
              print('Response status: ${response.statusCode}');
              print('Response body: ${response.body}');
              var ab = jsonDecode(response.body);
              logindata ldata = logindata.fromJson(ab);
              if (ldata.result == 1) {
                String id = ldata!.user!.iD.toString();
                String email = ldata!.user!.eMAIL.toString();
                String number = ldata!.user!.nUMBER.toString();

                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Dashboard();
                  },
                ));
              }
            },
            child: Text("Login")),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return RegisterPage();
                },
              ));
            },
            child: Text("register")),
      ]),
    );
  }
}

class convertdata {
  int? connection;
  int? result;

  convertdata({this.connection, this.result});

  convertdata.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    return data;
  }
}
