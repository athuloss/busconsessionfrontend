import 'package:bus/bottom.dart';
import 'package:bus/login.dart';
import 'package:bus/variables.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

var user = TextEditingController();
var firstname = TextEditingController();
var password = TextEditingController();
var email = TextEditingController();
var phonenumber = TextEditingController();

Future<void> sendData(context) async {
  Uri url_ = Uri.parse(url + 'signupapp/');

  var request = http.MultipartRequest('POST', url_);
  request.fields['username'] = user.text.toString();
  request.fields['firstname'] = user.text.toString();
  request.fields['password'] = password.text.toString();
  request.fields['email'] = email.text.toString();
  request.fields['phonenumber'] = phonenumber.text.toString();

  var response = await request.send();
  print("Heloooooooooooooooooo");
  if (response.statusCode == 200) {
    final responseJson = await response.stream.bytesToString();
    final jsonData = json.decode(responseJson);

    print("Success message: ${jsonData['success']}"); // Accessing 'success'
    if (jsonData['success'] == 'yes') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Loginpage()),
      );
    }
    // Update UI if needed
  } else {
    print('Failed to fetch orders. Status code: ${response.statusCode}');
  }
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
       
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 20),
            //   child: Text("Welcome To oru app \nPlease Signup",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
            // ),
            Center(
                child: Image.asset(
              "asset/images/photo_2025-01-14_21-02-01.jpg",
              width: 300,
              height: 300,
            )),

            TextField(
              controller: firstname,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Color.fromRGBO(0, 40, 78, 1),
                  size: 14,
                ),
                hintText: 'Enter FullName',
                hintStyle: TextStyle(fontSize: 14),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            TextField(
              controller: user,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Color.fromRGBO(0, 40, 78, 1),
                  size: 14,
                ),
                hintText: 'Enter Your username',
                hintStyle: TextStyle(fontSize: 14),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            TextField(
              controller: email,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email_sharp,
                  color: Color.fromARGB(255, 0, 40, 78),
                  size: 14,
                ),
                hintText: 'Enter Your email',
                hintStyle: TextStyle(fontSize: 14),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            TextField(
               obscureText: true,
              controller: password,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.password_sharp,
                  color: Color.fromARGB(255, 0, 40, 78),
                  size: 14,
                ),
                hintText: 'Enter Your password',
                hintStyle: TextStyle(fontSize: 14),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            SizedBox(height: 40),
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
                    sendData(context);
                  },
                  child: Text(
                    "Signup",
                    style: TextStyle(fontSize: 15),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account ? ",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 13),
                ),
                Text("Login",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 40, 78),
                        fontSize: 13)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
