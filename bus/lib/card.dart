import 'dart:convert';
import 'package:bus/variables.dart'; // Imports url and username variables
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CardConcession extends StatefulWidget {
  const CardConcession({Key? key}) : super(key: key);

  @override
  State<CardConcession> createState() => _CardConcessionState();
}

class _CardConcessionState extends State<CardConcession> {
  List concession = [];
  bool isLoading = true;
  String errorMessage = '';

  Future<void> fetchConcession() async {
    // Build the endpoint URL
    Uri url_ = Uri.parse(url + 'fetch_consession/');
    // Create a Multipart POST request
    var request = http.MultipartRequest('POST', url_);
    
    // Send the username for filtering
    request.fields['username'] = username;

    try {
      var response = await request.send();
      final responseJson = await response.stream.bytesToString();
      final jsonData = json.decode(responseJson);

      setState(() {
        concession = jsonData;
        isLoading = false;
      });
      print(concession);
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
    fetchConcession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Concession Application")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : concession.isEmpty
                  ? const Center(child: Text("No records found."))
                  : ListView.builder(
                      itemCount: concession.length,
                      itemBuilder: (context, index) {
                        var cardData = concession[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Student Name: ${cardData['student_name'] ?? ''}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Card Number: ${cardData['card_number'] ?? ''}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Date of Birth: ${cardData['date_of_birth'] ?? ''}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Course: ${cardData['course'] ?? ''}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  // Add additional fields as needed.
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
