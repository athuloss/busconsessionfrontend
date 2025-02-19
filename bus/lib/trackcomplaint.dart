import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bus/variables.dart'; // This file should define `url` and `username`

class TrackComplaints extends StatefulWidget {
  const TrackComplaints({Key? key}) : super(key: key);

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


    request.fields['username'] = username;

    try {
      var response = await request.send();
      final responseJson = await response.stream.bytesToString();
      final jsonData = json.decode(responseJson);

      setState(() {
        complaints = jsonData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching data: $e";
        isLoading = false;
      });
      print(errorMessage);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchComplaints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complaints")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage))
                : ListView.builder(
                    itemCount: complaints.length,
                    itemBuilder: (context, index) {
                      var complaint = complaints[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            complaint['complaint_Title'] ?? 'No Title',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            complaint['complaint_description'] ?? 'No Description',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            complaint['complainted_date'] ?? '',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Bus No: ' + (complaint['bus_no'] ?? ''),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'KL No: ' + (complaint['kl_no']?.toString() ?? ''),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Phone: ' + (complaint['phonenumber']?.toString() ?? ''),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Divider(thickness: 1, height: 30),
                        ],
                      );
                    },
                  ),
      ),
    );
  }
}
