import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  bool? isLoading;
  Widget child;
  LoadingWidget({this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    if(isLoading == null){
      return Center(
        child: CircularProgressIndicator(color: Colors.orange,),
      );
    }else if (isLoading == false){
      return const Center(
        child:Text("Bir sorun oluştu") ,
      );
    }else
      return child;
  }
}
