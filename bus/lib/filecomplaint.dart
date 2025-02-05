import 'package:flutter/material.dart';

class Filecomplaints extends StatefulWidget {
  const Filecomplaints({super.key});

  @override
  State<Filecomplaints> createState() => _FilecomplaintsState();
}

class _FilecomplaintsState extends State<Filecomplaints> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Complaints",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
      ),
      backgroundColor: Colors.white,
      body:const Column(
        children: [
          
        ],
      ) ,
       
    );
  }
}