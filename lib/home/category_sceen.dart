import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import '../controllers/popular_product_controller.dart';
import '../models/product_model.dart';
import '../routes/routes_helper.dart';
import '../utils/dimensions.dart';
import '../widgets/Big_text.dart';
import '../widgets/app_column.dart';

class CategoryUI extends StatefulWidget {
  const CategoryUI({super.key});

  @override
  State<CategoryUI> createState() => _CategoryUIState();
}

class _CategoryUIState extends State<CategoryUI> {
  PageController pageController = PageController(viewportFraction: 0.80);
  var _currpagevalue = 0.0;
  double scaleFactor = 0.8;
  var _height = Dimensions.pageViewContainer;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       Expanded(
           child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _getListData() ),

       ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BigText(
                text: 'Fashion \n Best Seller',
              ),
              SizedBox(width: 10),
              GetBuilder<PropularProductController>(builder: (popularProducts) {
                // print(popularProducts.popularproductlist);
                return popularProducts.isLoaded
                    ? Container(
                        height: Dimensions.pageview,
                        child: Text('fdfdf'),
                      )
                    : CircularProgressIndicator(
                        color: Colors.greenAccent,
                      );
              }),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildpageItem(int index, ProductModel popularproduct) {
    Matrix4 matrix4 = new Matrix4.identity();
    if (index == _currpagevalue.floor()) {
      var currscale = 1 - (_currpagevalue - index) * (1 - scaleFactor);
      var currtrans = _height * (1 - currscale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == _currpagevalue.floor() + 1) {
      var currscale =
          scaleFactor + (_currpagevalue - index + 1) * (1 - scaleFactor);
      var currtrans = _height * (1 - currscale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == _currpagevalue.floor() - 1) {
      var currscale = 1 - (_currpagevalue - index) * (1 - scaleFactor);
      var currtrans = _height * (1 - currscale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else {
      var currscale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, _height * (1 - scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, "popular"));
            },
            child: Container(
                height: Dimensions.pageViewContainer,
                margin: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(popularproduct.img!),
                        fit: BoxFit.contain),
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 255, 255, 255))),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 255, 255),
                      // blurRadius: 5.0,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 255, 255),
                      // blurRadius: 5.0,
                      offset: Offset(5, 0),
                    ),
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15, left: 10, right: 10),
                child: AppColumn(
                  name: popularproduct.name!,
                  price: popularproduct.price!,
                  off: popularproduct.off!,
                  rating: popularproduct.rating!,
                  reviews: popularproduct.reviews!,
                  stars: popularproduct.stars!,
                  replacable: popularproduct.replacable!,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
   _getListData() {
        List<Widget> widgets = [];
        for (int i = 0; i < 100; i++) {
          widgets.add(Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  ElevatedButton(
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      padding: EdgeInsets.all(10.0),
                      ),
                      child: Column(
                        
                        children: <Widget>[
                          Icon(Icons.add), Text("Add"),
                          Icon(Icons.add), Text("Add"),
                          Icon(Icons.add), Text("Add"),
                          Icon(Icons.add), Text("Add"),
                          Icon(Icons.add), Text("Add"),
                          Icon(Icons.add), Text("Add"),
                          Icon(Icons.add), Text("Add"),
                          Icon(Icons.add), Text("Add"),
                          Icon(Icons.add), Text("Add"),
                          Icon(Icons.add), Text("Add"),
                          Icon(Icons.add), Text("Add"),
                          Icon(Icons.add), Text("Add"),
                          ],
                      )),
                ],
              )));
        }
        return widgets;
      }
}
