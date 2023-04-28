import 'package:flutter/material.dart';
import '../utils/dimensions.dart';
import 'Big_text.dart';
import 'Small_text.dart';
import 'icon_and_text.dart';

class AppColumn extends StatelessWidget {
  final String name;
  final String price;
  final String off;
  final String rating;
  final String reviews;
  final String stars;
  final bool replacable;

  const AppColumn({Key? key, required this.name,
  required this.price,required this.off,
  required this.rating,required this.reviews,required this.stars,required this.replacable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        BigText(
          text: name,
          size: Dimensions.font16,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Wrap(
            direction: Axis.horizontal,
            children: [
              Wrap(
                children: List.generate(
                    int.parse(stars),
                    (index) => Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 13, 243, 47),
                          size: 15,
                        )),
              ),
              SizedBox(
                width: 10,
              ),
              SmallText(text: rating),
        
              SmallText(text: " Ratings & "),
              SmallText(text: reviews),
              SmallText(text: " Reviews"),
            ],
          ),
        
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(
                icon: Icons.currency_rupee,
                text: price,
                iconColor: Colors.amber),
            IconAndText(
                icon: Icons.percent,
                text: off+"% Off",
                iconColor: Colors.green),
            IconAndText(
                icon: Icons.find_replace,
                text: replacable?"Yes": "No",
                iconColor: Colors.redAccent),
          ],
        )
      ],
    );
  }
}
