import 'package:addvideo/addvideo.dart';
import 'package:flutter/material.dart';

class next extends StatelessWidget {
  const next({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: 
      Container(
        height: MediaQuery.of(context).size.height*0.1,
        width:MediaQuery.of(context).size.width*0.5,
        decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: InkWell(
          child:Text("Video",style: TextStyle(fontSize:20,color: Colors.white ),),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>addvideo()));
          },
        ),
      ),
      )
    );
  }
}