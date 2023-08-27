import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

String image1 = 'assets/animation/1.json';
String image2 = 'assets/animation/2.json';

buildsticker(
    {required String image, required double size1, required double size2}) {
  return Container(
    margin: EdgeInsets.only(top: size1),
    child: LottieBuilder.asset(
      image,
      height: size2,
      repeat: true,
      fit: BoxFit.cover,
    ),
  );
}

showSnackBar(BuildContext context,String text){
}
