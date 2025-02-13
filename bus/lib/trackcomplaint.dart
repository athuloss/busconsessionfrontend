import 'dart:convert';
import 'package:bus/variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TrackComplaints extends StatefulWidget {
  const TrackComplaints({super.key});

  @override
  State<TrackComplaints> createState() => _TrackComplaintsState();
}

class _TrackComplaintsState extends State<TrackComplaints> {
  List complaints = [];
  bool isLoading = true;
  String errorMessage = '';

  Future<void> fetchComplaints() async {
    Uri url_ = Uri.parse(url + 'fetch_Complaints/');

    var request = http.MultipartRequest('POST', url_);

    var response = await request.send();

    final responseJson = await response.stream.bytesToString();
    final jsonData = json.decode(responseJson);

    setState(() {
      complaints = jsonData;
    }); // Update UI if needed
  }

  @override
  void initState() {
    super.initState();
    print("--------------");
    fetchComplaints();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Complaints")),
        body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          child: ListView(
            children: [
              for (var i in complaints)
                ListTile(
                  title: Text(i['complaint_Title'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                  subtitle: Text(i['complaint_description'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                )
            ],
          ),
        ));
  }
}
