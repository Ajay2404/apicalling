import 'dart:convert';
import 'dart:io';

import 'package:apicalling/loginPage.dart';
import 'package:apicalling/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MaterialApp(
    home: Splashscreen(),
  ));
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  final ImagePicker picker = ImagePicker();
  String imagePath = "";
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  children: [
                    ListTile(
                        onTap: () async {
                          Navigator.pop(context);
                          final XFile? photo = await picker.pickImage(
                              source: ImageSource.camera);

                          setState(() {
                            imagePath = photo!.path;
                            status = true;
                          });
                        },
                        title: Icon(Icons.camera_alt)),
                    ListTile(
                        onTap: () async {
                          Navigator.pop(context);
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            imagePath = image!.path;
                            status = true;
                          });
                        },
                        title: Icon(Icons.image)),
                  ],
                );
              },
            );
          },
          child: imagePath != ""
              ? CircleAvatar(
                  radius: 80, backgroundImage: FileImage(File(imagePath)))
              : CircleAvatar(
                  child: Icon(Icons.add),
                  radius: 80,
                ),
        ),
        TextField(
          controller: email,
          decoration: InputDecoration(hintText: "Email"),
        ),
        TextField(
          controller: number,
          decoration: InputDecoration(hintText: "Number"),
        ),
        TextField(
          controller: password,
          decoration: InputDecoration(hintText: "Password"),
        ),
        ElevatedButton(
            onPressed: () async {
              String imagedata = "";
              if (imagePath != "") {
                List<int> img = File(imagePath).readAsBytesSync();
                imagedata = base64Encode(img);
              }
              Map map = {
                "email": email.text,
                "number": number.text,
                "password": password.text,
                "imagepath": imagedata,
              };
              var url = Uri.parse(
                  'https://meetytesting24.000webhostapp.com/apicalling/register.php');
              var response = await http.post(url, body: map);
              print('Response status: ${response.statusCode}');
              print('Response body: ${response.body}');

              var mm = jsonDecode(response.body);

              convertdata convert = convertdata.fromJson(mm);

              if (convert.result == 1) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("User already exist")));
              }
            },
            child: Text("Sign Up"))
      ]),
    );
  }
}
