import 'package:addvideo/addvideo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/camerabloc.dart';
import 'blocs/camerastate.dart';

class next extends StatelessWidget {
  const next({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      
        child: BlocBuilder<cameraBloc, camerastate>(
          builder: (context, state) {
            if(state is connectiongainstate){
            return Container(
                 height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
            color: Colors.blueAccent, borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
              child: InkWell(
                child: Text(
                  "Video",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => addvideo()));
                },
              ),
            );
            }
            else if(state is connectionloststate){
              return Container(
                 height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
              child: 
                 Padding(
                   padding: const EdgeInsets.only(left:19),
                   child: Text(
                    "INTERNET NOT CONNECTED",
                    style: TextStyle(fontSize: 20, color: Colors.white),),
                 )
               );
            }
            else{
           return Text("LOADING..",style: TextStyle(fontSize: 40,color: Colors.black),);
        
            }
          },
        ),
      
    ));
  }
}
