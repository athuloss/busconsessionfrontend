import 'package:bus/card.dart';
import 'package:bus/complaint.dart';
import 'package:bus/consession_aaply.dart';
import 'package:bus/login.dart';
import 'package:bus/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Frontpage extends StatefulWidget {
  const Frontpage({super.key});

  @override
  State<Frontpage> createState() => _FrontpageState();
}

Future<void> _handleRefresh() async {
  // Your refresh logic here
  await Future.delayed(const Duration(seconds: 2));
  print("Page refreshed!");
}

class _FrontpageState extends State<Frontpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: LiquidPullToRefresh(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        color: Color(0xFF38A3A5),
        showChildOpacityTransition: false,
        onRefresh: _handleRefresh,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                            "asset/images/7799e37add3fc4206b003e9807c302e1.jpg"),
                        radius: 15,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Athul",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Hai good morning",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Color.fromARGB(255, 249, 245, 245),
                        child: Icon(
                          Ionicons.notifications,
                          size: 18,
                          color: Color(0xFF38A3A5),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Loginpage()));
                        },
                        child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Color.fromARGB(255, 249, 245, 245),
                            child: Icon(
                              Ionicons.log_out,
                              size: 18,
                              color: Color(0xFF38A3A5),
                            )),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: const [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Our Services ",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "for you",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF38A3A5)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Below are the list of services",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 159, 160, 159))),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Consession()),
                      );
                    },
                    child: Container(
                      // height: 10,
                      width: MediaQuery.of(context).size.width * 0.43,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 137, 137, 137)
                                  .withOpacity(0.2),
                              spreadRadius: 0.3, // How much the shadow spreads
                              blurRadius: 1, // Blur effect for smoothness
                              offset: Offset(0.5,
                                  0.5), // Moves shadow slightly for depth effect
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromARGB(255, 255, 255, 255)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Image.asset(
                            "asset/images/rb_4917.png",
                            width: MediaQuery.of(context).size.width * 0.30,
                          )),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text("Apply For consession",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8, bottom: 6),
                                child: Text(
                                    "Submit your application to get \nconsession",
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(
                                            255, 159, 160, 159))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 8, bottom: 6),
                                child: CircleAvatar(
                                    radius: 9,
                                    child: Icon(Icons.arrow_forward,
                                        size: 14, color: Color(0xFF38A3A5))),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Complaint()));
                    },
                    child: Container(
                      // height: 200,
                      width: MediaQuery.of(context).size.width * 0.43,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 137, 137, 137)
                                  .withOpacity(0.2),
                              spreadRadius: 0.3, // How much the shadow spreads
                              blurRadius: 1, // Blur effect for smoothness
                              offset: Offset(0.5,
                                  0.5), // Moves shadow slightly for depth effect
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromARGB(255, 255, 255, 255)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Image.asset(
                            "asset/images/complaints.png",
                            width: MediaQuery.of(context).size.width * 0.30,
                          )),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text("Complaints Files",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5, bottom: 6),
                                child: Text("Complaints or give feedbacks",
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(
                                            255, 159, 160, 159))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 5, bottom: 6),
                                child: CircleAvatar(
                                    radius: 9,
                                    child: Icon(Icons.arrow_forward,
                                        size: 14, color: Color(0xFF38A3A5))),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // height: 200,
                    width: MediaQuery.of(context).size.width * 0.43,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 137, 137, 137)
                                .withOpacity(0.2),
                            spreadRadius: 0.3, // How much the shadow spreads
                            blurRadius: 3, // Blur effect for smoothness
                            offset: Offset(0.5,
                                0.5), // Moves shadow slightly for depth effect
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(255, 255, 255, 255)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Image.asset(
                          "asset/images/rb_1119.png",
                          width: MediaQuery.of(context).size.width * 0.30,
                        )),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text("Track Complaints",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 0, 0, 0))),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5, bottom: 6),
                              child: Text("Easy Way to track your complaints",
                                  style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Color.fromARGB(255, 159, 160, 159))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 5, bottom: 6),
                              child: CircleAvatar(
                                  radius: 9,
                                  child: Icon(Icons.arrow_forward,
                                      size: 14, color: Color(0xFF38A3A5))),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Cardconsession()),
                      );
                    },
                    child: Container(
                      // height: 200,
                      width: MediaQuery.of(context).size.width * 0.43,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 137, 137, 137)
                                  .withOpacity(0.2),
                              spreadRadius: 0.3, // How much the shadow spreads
                              blurRadius: 1, // Blur effect for smoothness
                              offset: Offset(0.5,
                                  0.5), // Moves shadow slightly for depth effect
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromARGB(255, 255, 255, 255)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Image.asset(
                            "asset/images/rb_4358.png",
                            width: MediaQuery.of(context).size.width * 0.30,
                          )),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text("Dowload Consession",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5, bottom: 6),
                                child: Text("Quick dowload your consession",
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(
                                            255, 159, 160, 159))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 5, bottom: 6),
                                child: CircleAvatar(
                                    radius: 9,
                                    child: Icon(Icons.arrow_forward,
                                        size: 14, color: Color(0xFF38A3A5))),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "News",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF38A3A5)),
                  ),
                  Text(
                    "Watch new updated news here",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 100, 100, 100)),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: AssetImage(
                                "asset/images/7799e37add3fc4206b003e9807c302e1.jpg"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Vysakh ettan",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "updated a new news",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Transform.rotate(
                              angle: pi / 2, child: Icon(Icons.more_vert)),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 37),
                    child: const Row(
                      children: [
                        Text(
                          "3 min ago",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 71, 71, 71)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "asset/images/businessman-taking-photo-with-mobile-phone-while-traveling-by-public-bus.jpg",
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.94,
                            child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: AssetImage(
                                "asset/images/7799e37add3fc4206b003e9807c302e1.jpg"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Vysakh ettan",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "updated a new news",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Transform.rotate(
                              angle: pi / 2, child: Icon(Icons.more_vert)),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 37),
                    child: const Row(
                      children: [
                        Text(
                          "3 min ago",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 71, 71, 71)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "asset/images/young-reporter-taking-interview.jpg",
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.94,
                            child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
