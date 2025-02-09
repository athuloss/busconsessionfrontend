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
  List consession = [];
  bool isLoading = true;
  String errorMessage = '';

  Future<void> fetchconsession() async {
    // print(card_number);
    Uri url_ = Uri.parse(url + 'fetch_consession/');

    var request = http.MultipartRequest('POST', url_);

    var response = await request.send();

    final responseJson = await response.stream.bytesToString();
    final jsonData = json.decode(responseJson);

    setState(() {
      consession = jsonData;
    }); // Update UI if needed
    print(consession);
  }

  @override
  void initState() {
    super.initState();
    print("--------------");
    fetchconsession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("consession application")),
        body: ListView(
          children: [
    
              Column(
                children: [         
                  Text(consession[0]['student_name']),
                  Text(consession[0]['card_number'],style: TextStyle(),),
                  
                ],
              )
          ],
        ));
  }
}
