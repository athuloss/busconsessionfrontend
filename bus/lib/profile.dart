import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(

        title: Text("Profile page",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
        backgroundColor: Colors.white,
      ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("asset/images/7799e37add3fc4206b003e9807c302e1.jpg"),
            ),
            SizedBox(height: 23,),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
              Text("Username",style: TextStyle(color: Color.fromARGB(255, 215, 215, 215))),
              SizedBox(height: 4,),
              Text("Athul O S",style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500 ),),
              Divider(height: BorderSide.strokeAlignCenter,),    
            ],),
            SizedBox(height: 20,),
            const Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("Phonenumber",style: TextStyle(color: Color.fromARGB(255, 215, 215, 215))),
              SizedBox(height: 4,),
              Text("9527864172",style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500 ),),
              Divider(height: BorderSide.strokeAlignCenter,),    
            ],),
             SizedBox(height: 20,),
            const Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("Email",style: TextStyle(color: Color.fromARGB(255, 215, 215, 215))),
              SizedBox(height: 4,),
              Text("vysakh@gmail.com",style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500 ),),
              Divider(height: BorderSide.strokeAlignCenter,),    
            ],),
             SizedBox(height: 20,),
            const Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("Address",style: TextStyle(color: Color.fromARGB(255, 215, 215, 215))),
              SizedBox(height: 4,),
              Text("Ottuprakalla(H),Thonoorkkara(Po)",style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500 ),),
              Divider(height: BorderSide.strokeAlignCenter,),    
            ],),
            SizedBox(height: 30,),
               ElevatedButton( style: ButtonStyle(
                                padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 80,vertical: 16)),
                                 backgroundColor: WidgetStateProperty.all(Color(0xFF22577A)),
                                 shape:WidgetStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                  )
                                 )
               ),
                          onPressed: (){                            
                              }, child: Text("Logout",style: TextStyle(color: Colors.white,fontSize:16,fontWeight: FontWeight.w800),)),
            // Container(
            //           height: 100,
            //           // width: 400,
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(12),
            //             boxShadow: [
            //              BoxShadow(
            //                     color: Colors.black.withOpacity(0.2), // Soft shadow color
            //                     spreadRadius: 1, // How much the shadow spreads
            //                     blurRadius: 6, // Blur effect for smoothness
            //                     offset: Offset(2, 2), // Moves shadow slightly for depth effect
            //                   )              
            //             ],
            //           ),
            //           child: const Column(crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Padding(
            //                 padding: EdgeInsets.only(left: 20,top: 10),
            //                 child: Text("Consession",style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500 ),),
            //               ),
            //               SizedBox(height: 20,),
            //               Divider(height: BorderSide.strokeAlignCenter,thickness: 2,color:Colors.black,),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Padding(
            //                     padding: EdgeInsets.only(left: 20,top: 10),
            //                     child: Text("Dowload consession",style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500 ),),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.only(top: 10,right: 20),
            //                     child: Icon(Icons.download,size: 20,),
            //                   )
            //                 ],
            //               )
            //           ],),
            //           ),
          ],
        ),
      ),
    );
  }
}