import 'package:flutter/material.dart';

class Calcultor extends StatefulWidget {
  const Calcultor({super.key});

  @override
  State<Calcultor> createState() => _CalcultorState();
}

TextEditingController distancectrl = TextEditingController();
String data = "Amount will be displayed here";

double cfare() {
  double dis = double.tryParse(distancectrl.text) ?? 0;
   return  (dis / 2.5) * 5;
}


class _CalcultorState extends State<Calcultor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
              controller: distancectrl,
              decoration: InputDecoration(
                  hintText: "Enter Kilometer",
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: const Color.fromARGB(255, 235, 236, 235))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: const Color.fromARGB(255, 235, 236, 235))))),
          ElevatedButton(
              onPressed: () {
                setState(() {
                   data = "Total Fare: ₹${cfare().toStringAsFixed(2)}";
                });
              },
              child: Text("Enter")),
          Text(data)
        ],
      ),
    );
  }
}
