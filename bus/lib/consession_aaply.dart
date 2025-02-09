import 'dart:convert';
import 'dart:io';
import 'package:bus/login.dart';
import 'package:bus/variables.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Consession extends StatefulWidget {
  const Consession({super.key});

  @override
  State<Consession> createState() => _ConsessionState();
}

class _ConsessionState extends State<Consession> {
  File? _profileImage;
  File? _signatureImage;
  final ImagePicker _picker = ImagePicker();

  var fullname = TextEditingController();
  var address = TextEditingController();
  var age = TextEditingController();
  var collegename = TextEditingController();
  var from = TextEditingController();
  var to = TextEditingController();

  Future<void> _pickImage(ImageSource source, bool isProfile) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (isProfile) {
          _profileImage = File(pickedFile.path);
        } else {
          _signatureImage = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> sendData(BuildContext context) async {
    Uri url_ = Uri.parse(url + 'add_student_details/');

    var request = http.MultipartRequest('POST', url_);

    request.fields['student_name'] = fullname.text;
    request.fields['address'] = address.text;
    request.fields['date_of_birth'] = age.text;
    request.fields['education_center_name'] = collegename.text;
    request.fields['travelling_from'] = from.text;
    request.fields['travelling_to'] = to.text;

    if (_profileImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'profile_image',
          _profileImage!.path,
        ),
      );
    }

    if (_signatureImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'signature_image',
          _signatureImage!.path,
        ),
      );
    }

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseJson = await response.stream.bytesToString();
        final jsonData = json.decode(responseJson);

        if (jsonData['success'] == 'yes') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Loginpage()),
          );
        } else {
          print('Error: ${jsonData['message']}');
        }
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Apply For Consession",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    await _pickImage(
                        ImageSource.gallery, true); // true for profile image
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white, // Solid white background
                      border: Border.all(
                        color:
                            Color.fromARGB(255, 249, 241, 241), // Black border
                        width: 2.0, // Border thickness
                      ),
                    ),
                    child: ClipOval(
                      child: _profileImage != null
                          ? Image.file(
                              _profileImage!,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.add_a_photo,
                              size: 30,
                              color: Colors.black, // Black icon color
                            ),
                    ),
                  ),
                ),
                Text(
                  "Upload photo",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: fullname,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color(0xFF38A3A5),
                      ),
                      hintText: "Enter your name",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 215, 215, 215)),
                      contentPadding: EdgeInsets.symmetric(vertical: 20),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 1.0,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(255, 220, 218, 218),
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 220, 218, 218),
                        width: 1.0,
                        style: BorderStyle.solid,
                      ))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: address,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.local_post_office_sharp,
                          color: Color(0xFF38A3A5)),
                      hintText: "Enter your Address",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 215, 215, 215)),
                      contentPadding: EdgeInsets.symmetric(vertical: 20),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 1.0,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(255, 220, 218, 218),
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 220, 218, 218),
                        width: 1.0,
                        style: BorderStyle.solid,
                      ))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: age,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.numbers, color: Color(0xFF38A3A5)),
                      hintText: "Enter your age",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 215, 215, 215)),
                      contentPadding: EdgeInsets.symmetric(vertical: 20),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 1.0,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(255, 220, 218, 218),
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 220, 218, 218),
                        width: 1.0,
                        style: BorderStyle.solid,
                      ))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: collegename,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.school, color: Color(0xFF38A3A5)),
                      hintText: "Enter college name",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 215, 215, 215)),
                      contentPadding: EdgeInsets.symmetric(vertical: 20),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 1.0,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(255, 220, 218, 218),
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 220, 218, 218),
                        width: 1.0,
                        style: BorderStyle.solid,
                      ))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: from,
                  decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.location_pin, color: Color(0xFF38A3A5)),
                      hintText: "From",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 215, 215, 215)),
                      contentPadding: EdgeInsets.symmetric(vertical: 20),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 1.0,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(255, 220, 218, 218),
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 220, 218, 218),
                        width: 1.0,
                        style: BorderStyle.solid,
                      ))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: to,
                  decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.location_pin, color: Color(0xFF38A3A5)),
                      hintText: "To",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 215, 215, 215)),
                      contentPadding: EdgeInsets.symmetric(vertical: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 220, 218, 218),
                          width: 1.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 220, 218, 218),
                        width: 1.0,
                        style: BorderStyle.solid,
                      ))),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          padding: WidgetStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                          ),
                          shape: WidgetStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                                side: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 249, 241, 241),
                                )),
                          ),
                          backgroundColor: WidgetStateProperty.all(
                            Color.fromARGB(255, 255, 255, 255),
                          )),

                      onPressed: () => _pickImage(ImageSource.gallery,
                          false), // Call the function to pick image
                      child: Text(
                        'Upload Signature',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        padding: WidgetStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 70, vertical: 16)),
                        backgroundColor:
                            WidgetStateProperty.all(Color(0xFF38A3A5)),
                        shape: WidgetStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)))),
                    onPressed: () {
                      sendData(context);
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
