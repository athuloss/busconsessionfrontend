import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bus/variables.dart';
import 'package:http/http.dart' as http;

class CardConcession extends StatefulWidget {
  const CardConcession({Key? key}) : super(key: key);

  @override
  State<CardConcession> createState() => _CardConcessionState();
}

class _CardConcessionState extends State<CardConcession> {
  List<dynamic> concession = [];
  bool isLoading = true;
  String errorMessage = '';

  // Concession rules list
  final List<Map<String, String>> concessionRules = [
    {
      'title': 'Eligibility',
      'description': 'For students aged 5-25 years enrolled in recognized institutions'
    },
    {
      'title': 'Validity',
      'description': 'Valid for current academic year only'
    },
    {
      'title': 'Usage',
      'description': 'Non-transferable, valid only on designated routes'
    },
    {
      'title': 'Documents',
      'description': 'Requires RTO seal & sign for authentication'
    },
    {
      'title': 'Renewal',
      'description': 'Must be renewed annually before expiration'
    },
  ];

  Future<void> fetchConcession() async {
    Uri url_ = Uri.parse(url + 'fetch_consession/');
    var request = http.MultipartRequest('POST', url_);
    request.fields['username'] = username;

    try {
      var response = await request.send();
      final responseJson = await response.stream.bytesToString();
      final jsonData = json.decode(responseJson);

      setState(() {
        concession = jsonData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching data: $e";
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchConcession();
  }

  Widget _buildImagePair(String leftImage, String rightImage, String leftLabel, String rightLabel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _imageWithLabel(leftImage, leftLabel),
          _imageWithLabel(rightImage, rightLabel),
        ],
      ),
    );
  }

  Widget _imageWithLabel(String imageUrl, String label) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: imageUrl.isEmpty
              ? const Center(child: Text("Not Available", style: TextStyle(color: Colors.grey)))
              : Image.network(imageUrl, fit: BoxFit.cover),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _buildRuleItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.assignment_outlined, size: 20, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bus Concession Card"),
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : concession.isEmpty
                  ? const Center(child: Text("No concession cards found"))
                  : ListView.builder(
                      itemCount: concession.length,
                      itemBuilder: (context, index) {
                        final card = concession[index];
                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Student Information
                                  const Text(
                                    "Student Details",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  _buildDetailRow("Name", card['student_name']),
                                  _buildDetailRow("Age", card['age']),
                                  _buildDetailRow("Course", card['course']),
                                  _buildDetailRow("Card No.", card['card_number']),
                                  const Divider(height: 30),

                                  // Images Section
                                  const Text(
                                    "Authorization Documents",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  _buildImagePair(
                                    card['student_sign'],
                                    card['student_photo'],
                                    "Student Signature",
                                    "Student Photo",
                                  ),
                                  _buildImagePair(
                                    card['principal_sign'],
                                    card['principal_seal'],
                                    "Principal Signature",
                                    "Institution Seal",
                                  ),
                                  _buildImagePair(
                                    card['rto_sign'],
                                    card['rto_seal'],
                                    "RTO Signature",
                                    "RTO Seal",
                                  ),
                                  const Divider(height: 30),

                                  // Concession Rules Section
                                  const Text(
                                    "Concession Rules",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  ...concessionRules.map((rule) => 
                                    _buildRuleItem(rule['title']!, rule['description']!)
                                  ).toList(),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              "$label:",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value?.toString() ?? "N/A",
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}