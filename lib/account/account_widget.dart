import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/Big_text.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  final AppIcon icon;
  final BigText bigText;
  final String text;
  AccountWidget({Key? key, required this.icon, required this.bigText,required this.text})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          
          child: Container(margin: EdgeInsets.only(left: Dimensions.width15), child: SmallText(text: text))),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
          padding: EdgeInsets.only(left: Dimensions.width20,top: Dimensions.width20,bottom: Dimensions.width20),
          child: Row(
            children: [
              icon,
              SizedBox(width: Dimensions.width20,),
              Flexible(child: bigText),
            ],
          ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(blurRadius: 1,offset: Offset(0,2),color: Colors.grey),
          ]
        ),
        ),
      ],
    );
  }
}
