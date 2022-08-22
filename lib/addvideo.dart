import 'package:addvideo/check.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/camerabloc.dart';
import 'blocs/camerastate.dart';

class addvideo extends StatefulWidget {
  addvideo({Key? key}) : super(key: key);

  @override
  State<addvideo> createState() => _addvideoState();
}

class _addvideoState extends State<addvideo> {
   bool _isLoading = true;
  bool _isRecording = false;
  late CameraController _cameraController;
  var size,height,width;

   @override
  void initState() {
    _initCamera();
    super.initState();
  }
  
   @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController.initialize();
    setState(() => _isLoading = false);
  }

 _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() => _isRecording = false);
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPage(filePath: file.path),
      );
      Navigator.push(context, route);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }
  @override
  Widget build(BuildContext context) {
      size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
     if (_isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );}
      else{
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height - 55,
        child: Stack(
          alignment: Alignment.center,
          children:[
            Transform.scale(scale: 1.5,alignment: Alignment.center,child: CameraPreview(_cameraController)) ,
            Column(
            children: [
        
               Padding(
                 padding: EdgeInsets.only(top:height*0.06,
                 left: width*0.04,
                 right:width*0.04),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
          GestureDetector(
            onTap: (){Navigator.pop(context);},
            child: Icon(Icons.close,
            color: Colors.white,),
          ),
          GestureDetector(
            onTap: (){Navigator.pop(context);},
            child: Icon(Icons.settings,
            color: Colors.white,),
          ),
            ],
           ),
               ),
               Spacer(),
               Row( 
                mainAxisAlignment:MainAxisAlignment.center,
                children: [ 
                   
                  SizedBox(width: width/6.5,),   
                   Container(
                   // margin: EdgeInsets.all(18),
                   height: 55,
                   width: 57,
                    decoration: BoxDecoration(color: Colors.transparent,
                      border:Border.all(color:Colors.grey),
                      borderRadius: BorderRadius.circular(40)
                    ),
                    child: InkWell(
                      onTap: (){_recordVideo();},
                      child :BlocBuilder<cameraBloc, camerastate>(
                        builder: (context, state) {
                          if(state == _isRecording){return Icon(Icons.stop,color:Colors.red);}
                          else{
                            return CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 100,); 
                            }
                        },
                      )
                      ///_isRecording ? Icon(Icons.stop,color:Colors.red):CircleAvatar(
                        //backgroundColor: Colors.red,
                        //radius: 100,
                        
                      //)
                    ),
                   ),
                   SizedBox(width:12),
                   InkWell(
                    onTap: () {
                    debugPrint('yessss');                    },
                     child: Container(
                      height: 60,
                      width: 46,
                       child: Column(
                        children: [
                         Image.network('https://icons.iconarchive.com/icons/gakuseisean/aire/32/Images-icon.png',
                           ),
                             SizedBox(height: 8,),
                             Text("upload",style:TextStyle(color: Colors.white,fontSize: 12))
                           
                        ],
                       ),
                     ),
                   )
        
               ],) 
                ]),
        ]),
      ),
    );
      }}
}