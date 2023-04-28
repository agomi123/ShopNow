import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgpath;
  const NoDataPage(
      {Key? key, required this.text, this.imgpath = "assets/images/nd.png"})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      
      children: [
        Image.asset(
          imgpath,
          height: MediaQuery.of(context).size.height*0.22,
          width: MediaQuery.of(context).size.width*0.22,
        ),
        SizedBox(height: Dimensions.height20,),
        Text("No data",textAlign: TextAlign.center,)
      ],
    );
  }
}
