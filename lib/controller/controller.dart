import 'package:flutter/material.dart';

import '../model/model.dart';
import '../service/service.dart';

class Controller extends ChangeNotifier{
  PageController pageController = PageController(initialPage:0);
  bool? isLoading;
  List<Data> users = [];
  List<Data> saved = [];

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
  void addSaved(Data model){
    saved.add(model);
    users.remove(model);
    notifyListeners();
  }
  notSavedButton(){
    pageController.animateToPage(0, duration: Duration(microseconds: 500), curve: Curves.easeInExpo);
  }
  SavedButton(){
    pageController.animateToPage(1, duration: Duration(microseconds: 500), curve: Curves.easeInExpo);
  }
}