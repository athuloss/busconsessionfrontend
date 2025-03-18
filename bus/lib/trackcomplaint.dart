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
  bool isDeleting = false;
  String errorMessage = '';
  String successMessage = '';

  @override
  void initState() {
    super.initState();
    fetchComplaints();
  }

  // Show a snackbar with a message
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Fetch all complaints
  Future<void> fetchComplaints() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    Uri url_ = Uri.parse('$url/fetch_Complaints/');
    
    try {
      var request = http.MultipartRequest('POST', url_);
      request.fields['username'] = username;

      var streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      
      print('Fetch response status: ${response.statusCode}');
      print('Fetch response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        
        setState(() {
          complaints = jsonData;
          isLoading = false;
        });
        
        print('Fetched ${complaints.length} complaints');
      } else {
        setState(() {
          errorMessage = "Server error: ${response.statusCode}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching data: $e";
        isLoading = false;
      });
      print('Fetch error: $e');
    }
  }

  // Delete a complaint
 Future<void> deleteComplaint(String complaintId) async {
  if (complaintId.isEmpty || complaintId == "null") {
    print("Error: Complaint ID is null or empty!");
    showSnackBar("Error: Complaint ID is missing", isError: true);
    return;
  }

  Uri url_ = Uri.parse('$url/delete_complaint/');
  
  try {
    Map<String, dynamic> requestBody = {"complaint_id": complaintId};
    String encodedBody = json.encode(requestBody);
    
    print('Request URL: $url_');
    print('Request body: $encodedBody');

    final response = await http.post(
      url_,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: encodedBody,
    );
    
    print('Delete response status: ${response.statusCode}');
    print('Delete response body: ${response.body}');

    if (response.statusCode == 200) {
      showSnackBar("Complaint deleted successfully");
      await fetchComplaints();
    } else {
      showSnackBar("Failed to delete complaint", isError: true);
    }
  } catch (e) {
    print('Delete error: $e');
    showSnackBar("Error deleting complaint: $e", isError: true);
  }
}



  void confirmDelete(dynamic complaint) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Delete Complaint"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Are you sure you want to delete this complaint?"),
            const SizedBox(height: 8),
            Text("Title: ${complaint['complaint_Title'] ?? 'No Title'}", 
              style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Delete"),
            onPressed: () {
              Navigator.of(context).pop();

              var idToUse = complaint['id']?.toString() ?? 
                           complaint['pk']?.toString() ?? 
                           complaint['complaint_id']?.toString();

              if (idToUse == null || idToUse.isEmpty || idToUse == "null") {
                showSnackBar("Error: Complaint ID is missing", isError: true);
                return;
              }

              deleteComplaint(idToUse);
            },
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Complaints"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: isLoading ? null : fetchComplaints,
            tooltip: "Refresh",
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              errorMessage,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: fetchComplaints,
                              child: const Text("Try Again"),
                            ),
                          ],
                        ),
                      )
                    : complaints.isEmpty
                        ? const Center(
                            child: Text(
                              "No complaints found",
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        : ListView.builder(
                            itemCount: complaints.length,
                            itemBuilder: (context, index) {
                              var complaint = complaints[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 16),
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              complaint['complaint_Title'] ?? 'No Title',
                                              style: const TextStyle(
                                                  fontSize: 18, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            onPressed: isDeleting ? null : () => confirmDelete(complaint),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      // Display the complaint image if available
                                      if (complaint['complaint_photo'] != null && 
                                          complaint['complaint_photo'].toString().isNotEmpty)
                                        Container(
                                          height: 200,
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.network(
                                              complaint['complaint_photo'],
                                              fit: BoxFit.cover,
                                              loadingBuilder: (context, child, loadingProgress) {
                                                if (loadingProgress == null) return child;
                                                return Center(
                                                  child: CircularProgressIndicator(
                                                    value: loadingProgress.expectedTotalBytes != null
                                                        ? loadingProgress.cumulativeBytesLoaded / 
                                                          loadingProgress.expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                              errorBuilder: (context, error, stackTrace) {
                                                return Container(
                                                  color: Colors.grey[200],
                                                  child: const Center(
                                                    child: Text('Failed to load image'),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      Text(
                                        complaint['complaint_description'] ?? 'No Description',
                                        style: const TextStyle(
                                            fontSize: 15, fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 8),
                                      // Complaint details
                                      _buildDetailRow('Date', complaint['complainted_date']),
                                      _buildDetailRow('Bus No', complaint['bus_no']),
                                      _buildDetailRow('KL No', complaint['kl_no']?.toString()),
                                      _buildDetailRow('Phone', complaint['phonenumber']?.toString()),
                                      // Debug info - remove in production
                                      _buildDetailRow('ID', complaint['id']?.toString(), isDebug: true),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
          ),
          
          // Loading overlay for delete operation
          if (isDeleting)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
  
  // Helper method to build detail rows
  Widget _buildDetailRow(String label, String? value, {bool isDebug = false}) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 14, 
              fontWeight: FontWeight.w500,
              color: isDebug ? Colors.red : Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.w400,
                color: isDebug ? Colors.red : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}