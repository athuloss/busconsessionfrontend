import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController distanceCtrl = TextEditingController();
  String data = "Amount will be displayed here";

  double cfare(double distance) {
    if (distance <= 2.5) {
      return 1;
    } else if (distance <= 5) {
      return 2;
    } else if (distance <= 7.5) {
      return 2;
    } else if (distance <= 10) {
      return 3;
    } else if (distance <= 12) {
      return 3;
    } else if (distance <= 17.5) {
      return 3;
    } else if (distance <= 27.5) {
      return 4;
    } else if (distance <= 37.5) {
      return 5;
    } else {
      return 6;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Fare Calculator",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: distanceCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter Kilometer",
                hintStyle: TextStyle(fontSize: 15),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color.fromARGB(255, 220, 218, 218),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color.fromARGB(255, 220, 218, 218),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 70, vertical: 16)),
                  backgroundColor: WidgetStateProperty.all(Color(0xFF38A3A5)),
                  shape: WidgetStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
              onPressed: () {
                setState(() {
                  double distance = double.tryParse(distanceCtrl.text) ?? 0;
                  data = "Total Fare: ₹${cfare(distance).toStringAsFixed(2)}";
                });
              },
              child: Text(
                "Calculate",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              data,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
