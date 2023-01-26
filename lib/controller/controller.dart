import 'package:flutter/material.dart';

import '../model/model.dart';
import '../service/service.dart';

class Controller extends ChangeNotifier{
  bool? isLoading;
  List<Data> users = [];

  void getData(){
    Service.fetch().then((value){
      if(value != null){
        users = value.data!;
        isLoading = true;
        notifyListeners();
      }else{
        isLoading = false ;
        notifyListeners();
      }
    });
  }

}