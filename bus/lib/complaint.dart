import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bus/variables.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Complaint extends StatefulWidget {
  const Complaint({super.key});

  @override
  State<Complaint> createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController vehicleNumberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // API endpoint

  // Function to submit the complaint
  Future<void> submitComplaint() async {
    Uri url_ = Uri.parse(url + 'add_complaints_details/');

    var request = http.MultipartRequest('POST', url_);
    request.fields['complaint_Title'] = titleController.text;
    request.fields['kl_no'] = vehicleNumberController.text;
    request.fields['complaint_description'] = descriptionController.text;
    request.fields['user'] = username;

    // Check if _profileImage is not null before accessing its path
    if (_profileImage != null && _profileImage!.path.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath('image', _profileImage!.path),
      );
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseJson = await response.stream.bytesToString();
      final jsonData = json.decode(responseJson);
    } else {
      print('Failed to submit complaint. Status code: ${response.statusCode}');
    }
  }

  File? _profileImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source, bool isProfile) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (isProfile) {
          _profileImage = File(pickedFile.path);
        } else {}
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Complaint files",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
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
                    color: Color.fromARGB(255, 249, 241, 241), // Black border
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
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.title, color: Color(0xFF38A3A5)),
                hintText: "Title",
                hintStyle: TextStyle(color: Color.fromARGB(255, 215, 215, 215)),
                contentPadding: EdgeInsets.symmetric(vertical: 20),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromARGB(255, 220, 218, 218)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 220, 218, 218),
                      width: 1.0,
                      style: BorderStyle.solid),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: vehicleNumberController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.filter_1, color: Color(0xFF38A3A5)),
                hintText: "Vehicle number",
                hintStyle: TextStyle(color: Color.fromARGB(255, 215, 215, 215)),
                contentPadding: EdgeInsets.symmetric(vertical: 20),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromARGB(255, 220, 218, 218)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 220, 218, 218),
                      width: 1.0,
                      style: BorderStyle.solid),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.only(bottom: 96.0),
                  child: Icon(Icons.description, color: Color(0xFF38A3A5)),
                ),
                hintText: "Description",
                isDense: true,
                hintStyle: TextStyle(color: Color.fromARGB(255, 215, 215, 215)),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromARGB(255, 220, 218, 218)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 220, 218, 218),
                      width: 1.0,
                      style: BorderStyle.solid),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 40, vertical: 16)),
                    backgroundColor: WidgetStateProperty.all(Color(0xFF38A3A5)),
                    shape: WidgetStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
                onPressed: () {
                  submitComplaint();
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
        ),
      ),
    );
  }
}
