import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/widgets/custom_snack_bar.dart';

enum NetWorkStatus {online,offline,networkChecker}


class NetWorkService extends ChangeNotifier{


  StreamController<NetWorkStatus> netWorkController = StreamController();

  NetWorkService(){
    Connectivity().onConnectivityChanged.listen((connectivity) {
      netWorkController.add(_netWorkStatus(connectivity));
    });
    //print('no..........++++++++++++++++Internet');
  }

  NetWorkStatus _netWorkStatus(ConnectivityResult connectivityResult){
    if(connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile ){
      return NetWorkStatus.online;
    }else{
    return NetWorkStatus.offline;
    }
  }




}
