import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../utils/dimensions.dart';
import 'Small_text.dart';

class ExpandedTextW extends StatefulWidget {
  final String text;
  const ExpandedTextW({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandedTextW> createState() => _ExpandedTextWState();
}

class _ExpandedTextWState extends State<ExpandedTextW> {
  late String firsthalf;
  late String secondhalf;
  bool hiddern = true;
  double textHeight = Dimensions.screenHeight / 5.63;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.text);
    if (widget.text.length > textHeight) {
      firsthalf = widget.text.substring(0, textHeight.toInt());
      secondhalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firsthalf = widget.text;
      secondhalf = "";
      // hiddern = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.text.length.toString()+ " " +textHeight.toString());
    return Container(
        child: secondhalf.isEmpty
            ? SmallText(
                text: firsthalf,
                size: Dimensions.font16,
              )
            : Column(
                children: [
                  SmallText(
                      height: 1.8,
                      size: Dimensions.font16,
                      text: hiddern
                          ? (firsthalf + "...")
                          : (firsthalf + secondhalf)),
                  InkWell(
                    onTap: () {
                      setState(() {
                        hiddern = !hiddern;
                      });
                    },
                    child: Row(
                      children: [
                        SmallText(
                          text: "Show more",
                          color: Colors.greenAccent,
                        ),
                        Icon(
                          hiddern ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                          color: Colors.greenAccent,
                        ),
                      ],
                    ),
                  )
                ],
              ));
  }
}
