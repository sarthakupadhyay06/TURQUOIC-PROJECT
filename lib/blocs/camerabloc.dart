import 'dart:async';

import 'package:addvideo/blocs/cameraevent.dart';
import 'package:addvideo/blocs/camerastate.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class cameraBloc extends Bloc<cameraevent,camerastate>{
  Connectivity _conn = Connectivity();
   StreamSubscription? streamSubscription;
   cameraBloc():super(camerinitialstate()){
    on<connectiongainevent>(((event, emit) {emit(connectiongainstate());}));
    on<connectionlostevent>(((event, emit) {emit(connectionloststate());}));
    streamSubscription = _conn.onConnectivityChanged.listen((result) { 
        if(result==ConnectivityResult.mobile || result==ConnectivityResult.wifi){
                    add(connectiongainevent());
        }
        else{
          add(connectionlostevent());
        }
    }
    );
    on<camera_event>(((event, emit) {emit(camera_state());}));
     on<uplode_event>(((event, emit) {emit(uplodestate());}));
   }
   @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
   
}