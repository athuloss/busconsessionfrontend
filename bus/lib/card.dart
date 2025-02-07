import 'dart:convert';
import 'package:bus/variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Cardconsession extends StatefulWidget {
  const Cardconsession({super.key});

  @override
  State<Cardconsession> createState() => _CardconsessionState();
}

class _CardconsessionState extends State<Cardconsession> {
  List complaints = [];
  bool isLoading = true;
  String errorMessage = '';

  Future<void> fetchComplaints() async {
    // print(card_number);
    Uri url_ = Uri.parse(url + 'fetch_consession/');

    var request = http.MultipartRequest('POST', url_);

    var response = await request.send();

    final responseJson = await response.stream.bytesToString();
    final jsonData = json.decode(responseJson);

    setState(() {
      complaints = jsonData;
    }); // Update UI if needed
    print(complaints);
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
        appBar: AppBar(title: const Text("consession application")),
        body: ListView(
          children: [
    
              ListTile(
                title: Text(complaints[0]['card_number']),
                subtitle: Text(complaints[0]['card_number']),
              )
          ],
        ));
  }
}
