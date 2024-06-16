import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget{
  const LoadingPage({super.key});
  @override
  Widget build(BuildContext context){
    return const SpinKitCircle(
          size:140,
          color: Colors.white,
      );
  }
}