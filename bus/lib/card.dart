import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class  Cardconsession extends StatefulWidget {
  const  Cardconsession({super.key});

  @override
  State<Cardconsession> createState() => _CardconsessionState();
}

class _CardconsessionState extends State< Cardconsession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    appBar: AppBar(
      title: Text("Consession card",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
      backgroundColor: Colors.white,
    ),
    body:Center(
      child: Column(
       
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width * 0.90,
            decoration:BoxDecoration(
              color: Colors.white,
               boxShadow: [
                               BoxShadow(
                                     color: Color.fromARGB(255, 232, 221, 221).withOpacity(0.2), 
                                      spreadRadius: 0.3, // How much the shadow spreads
                                      blurRadius: 3, // Blur effect for smoothness
                                      offset: Offset(1, 1), // Moves shadow slightly for depth effect
                                    )
                      
                              ],
                      borderRadius: BorderRadius.circular(5),
                      
            ),
            child: Column(
                children: [
                  Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.90,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 247, 243, 243),
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(5),topRight: Radius.circular(5)), ),
                child: 
                 Center(
                   child: Text("Consession Card",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,color: const Color.fromARGB(255, 0, 0, 0)),
                                   ),
                 ) ,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                        Text("Name",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Color.fromARGB(255, 0, 0, 0)),),
                        Text("Athul O S",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Color.fromARGB(255, 0, 0, 0)),),
                           SizedBox(height: 7,),
                        Text("Date of birth",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Color.fromARGB(255, 0, 0, 0)),),
                        Text("16/05/2002",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Color.fromARGB(255, 0, 0, 0)),),
                        SizedBox(height: 7,),
                        Text("Gardian",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Color.fromARGB(255, 0, 0, 0)),),
                        Text("Nihal",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Color.fromARGB(255, 0, 0, 0)),),
                        SizedBox(height: 7,),
                        Text("From",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Color.fromARGB(255, 0, 0, 0)),),
                        Text("Mullurkkara",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Color.fromARGB(255, 0, 0, 0)),),
                        SizedBox(height: 7,),
                        Text("To",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Color.fromARGB(255, 0, 0, 0)),),
                        Text("Pazhaynuur",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Color.fromARGB(255, 0, 0, 0)),),
                        SizedBox(height: 7,),
                        Text("College Name",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Color.fromARGB(255, 0, 0, 0)),),
                        Text("College of Applied Science",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Color.fromARGB(255, 0, 0, 0)),),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset("asset/images/7799e37add3fc4206b003e9807c302e1.jpg",width:MediaQuery.of(context).size.width*0.38),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Column(
                   children: [
                     Text("Signature",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Color.fromARGB(255, 0, 0, 0)),),
                         SizedBox(height: 7,),
           Image.asset("asset/images/signature.png",width: 70,)
                   ],
                 ),
             Column(
               children: [
                 Text("Seal",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Color.fromARGB(255, 0, 0, 0)),),
              SizedBox(height: 7,),
           Image.asset("asset/images/seal.jpg",width: 70)
               ],
             ),
               ],
             ),
           ),
                ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}