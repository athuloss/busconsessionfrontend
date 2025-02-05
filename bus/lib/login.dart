import 'package:bus/bottom.dart';
import 'package:bus/frontpage.dart';
import 'package:bus/signup.dart';
import 'package:bus/variables.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  var user = TextEditingController();
  var password = TextEditingController();

  Future<void> sendData() async {
    Uri url_ = Uri.parse(url + 'loginapp/');
    print("--------------------------");
    var request = http.MultipartRequest('POST', url_);
    request.fields['username'] = user.text.toString();
    request.fields['password'] = password.text.toString();

    var response = await request.send();
    print("Heloooooooooooooooooo");
    if (response.statusCode == 200) {
      final responseJson = await response.stream.bytesToString();
      final jsonData = json.decode(responseJson);

      print("Success message: ${jsonData['success']}"); // Accessing 'success'
      if (jsonData['success'] == 'yes') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Bottomnav()),
        );
      } else {}
      setState(() {
        username = user.text;
      }); // Update UI if needed
    } else {
      print('Failed to fetch orders. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Image.asset(
              "asset/images/photo_2025-01-14_21-02-01.jpg",
              width: 300,
              height: 300,
            )),
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: user,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email_sharp,
                  color: Color.fromRGBO(0, 40, 78, 1),
                  size: 14,
                ),
                hintText: 'Enter Your Email',
                hintStyle: TextStyle(fontSize: 14),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.password_sharp,
                  color: Color.fromARGB(255, 0, 40, 78),
                  size: 14,
                ),
                hintText: 'Enter Your Password',
                hintStyle: TextStyle(fontSize: 14),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            SizedBox(height: 60),
            Center(
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        Color.fromARGB(255, 0, 40, 78)),
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                    padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 80, vertical: 20)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(25), // Rounded corners
                      ),
                    ),
                  ),
                  onPressed: () {
                    sendData();
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 15),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            // ElevatedButton(onPressed: sendData, child: Text("athulmon")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Do not have an account ? ",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 13),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                    );
                  },
                  child: Text(
                    "Signup",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(
                        255,
                        0,
                        40,
                        78,
                      ),
                      fontSize: 13,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
