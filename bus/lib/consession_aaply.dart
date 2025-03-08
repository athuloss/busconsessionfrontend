import 'dart:convert';
import 'dart:io';
import 'package:bus/frontpage.dart';
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
  var fullname = TextEditingController();
  var address = TextEditingController();
  var age = TextEditingController();
  var collegename = TextEditingController();
  var from = TextEditingController();
  var to = TextEditingController();
  var dateofbirth = TextEditingController();
  var parentname = TextEditingController();
  var course = TextEditingController();
  var klno = TextEditingController();
  var kilometers = TextEditingController();
  
  bool _isLoading = true;
  bool _hasExistingApplication = false;

  @override
  void initState() {
    super.initState();
    checkExistingApplication();
  }

  Future<void> checkExistingApplication() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      Uri url_ = Uri.parse(url + 'check_student_application/');
      var response = await http.post(
        url_,
        body: {
          'username': username,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          _hasExistingApplication = jsonData['exists'] ?? false;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        print('Failed to check application. Status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error checking application: $e');
    }
  }

  Future<void> sendData(BuildContext context) async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      Uri url_ = Uri.parse(url + 'add_student/');

      var request = http.MultipartRequest('POST', url_);
      request.fields['username'] = username;  
      request.fields['student_name'] = fullname.text;
      request.fields['address'] = address.text;
      request.fields['date_of_birth'] = dateofbirth.text;
      request.fields['parent_name'] = parentname.text;
      request.fields['age'] = age.text;
      request.fields['education_center_name'] = collegename.text;
      request.fields['travelling_from'] = from.text;
      request.fields['travelling_to'] = to.text;
      request.fields['course'] = course.text;
      request.fields['kl_no'] = klno.text;
      request.fields['kilometers'] = kilometers.text;

      if (_profileImage != null && _profileImage!.path.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath('student_photo', _profileImage!.path),
        );
      }

      if (_signatureImage != null && _signatureImage!.path.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath('student_sign', _signatureImage!.path),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // Close loading dialog
      Navigator.pop(context);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        
        setState(() {
          fullname.clear();
          address.clear();
          dateofbirth.clear();
          parentname.clear();
          age.clear();
          collegename.clear();
          from.clear();
          to.clear();
          course.clear();
          klno.clear();
          kilometers.clear();
          _profileImage = null;
          _signatureImage = null;
          _hasExistingApplication = true;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Form submitted successfully!"))
        );
        
        // Refresh the page to show "already applied" message
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to submit form. Please try again."))
        );
        print('Failed to submit application. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Close loading dialog
      Navigator.pop(context);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred. Please try again."))
      );
      print('Error submitting application: $e');
    }
  }

  File? _profileImage;
  File? _signatureImage;
  final ImagePicker _picker = ImagePicker();

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
      body: _isLoading 
        ? Center(child: CircularProgressIndicator())
        : _hasExistingApplication 
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Color(0xFF38A3A5),
                    size: 80,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "You have already applied for a concession card",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Your application is being processed",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                      backgroundColor: WidgetStateProperty.all(Color(0xFF38A3A5)),
                      shape: WidgetStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      )
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Go Back",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          : Padding(
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
                        controller: parentname,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Color(0xFF38A3A5),
                            ),
                            hintText: "Enter your Parent name",
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
                        controller: dateofbirth,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.numbers, color: Color(0xFF38A3A5)),
                            hintText: "Enter your date of birth",
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
                            hintText: "Enter College name",
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
                        controller: course,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.school, color: Color(0xFF38A3A5)),
                            hintText: "Enter Course name",
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
                      TextField(
                        controller: kilometers,
                        decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.numbers, color: Color(0xFF38A3A5)),
                            hintText: "Enter kilometers",
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
                      TextField(
                        controller: klno,
                        decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.numbers, color: Color(0xFF38A3A5)),
                            hintText: "Enter Kl number",
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

