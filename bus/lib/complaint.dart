import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bus/variables.dart';
import 'dart:io';

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
    request.fields['complaint_Title'] = titleController.text.toString();
    request.fields['kl_no'] = vehicleNumberController.text.toString();
    request.fields['complaint_description'] =
        descriptionController.text.toString();
    request.fields['user'] = username;

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseJson = await response.stream.bytesToString();
      final jsonData = json.decode(responseJson);
    } else {
      print('Failed to fetch orders. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaint files",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
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
                onPressed: () {
                  submitComplaint();
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
