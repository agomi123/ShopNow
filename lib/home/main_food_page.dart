import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import '../controllers/popular_product_controller.dart';
import '../models/product_model.dart';
import '../widgets/Big_text.dart';
import '../widgets/small_text.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> with TickerProviderStateMixin{
  bool _showBackToTopButton = false;
  // scroll controller
  late ScrollController _scrollController;
@override
    void initState() {
      _scrollController = ScrollController()
        ..addListener(() {
          setState(() {
            if (_scrollController.offset >= 400) {
              _showBackToTopButton = true; // show the back-to-top button
            } else {
              _showBackToTopButton = false; // hide the back-to-top button
            }
          });
        });

      super.initState();
    }

    @override
    void dispose() {
      _scrollController.dispose(); // dispose the controller
      super.dispose();
    }

    // This function is triggered when the user presses the back-to-top button
    void _scrollToTop() {
      _scrollController.animateTo(0,
          duration: const Duration(seconds: 1), curve: Curves.bounceIn);
    }

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PropularProductController>();
    return Scaffold(
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 45, bottom: 15),
          padding: EdgeInsets.only(left: 20, right: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              children: [
                BigText(text: "India", color: Colors.amber),
                Row(
                  children: [
                    SmallText(text: "Mumbai", color: Colors.black),
                    Icon(Icons.arrow_drop_down_circle_rounded)
                  ],
                )
              ],
            ),
            Center(
              child: GestureDetector(
                onTap:(){
                              List<dynamic> lst=controller.popularproductlist;
                              showSearch(
                                  context: context,
                                  delegate: MyDelegete(cpy: lst, controller: controller));
            },
                child: Container(
                  width: 45,
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue),
                ),
              ),
            )
          ]),
        ),
        Expanded(
            child: SingleChildScrollView(
          controller: _scrollController,
          child: FoodPageBody(),
        )),
      ]),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              onPressed: _scrollToTop,
              child: const Icon(Icons.arrow_upward),
            ),
    );
  }

}

class MyDelegete extends SearchDelegate {
  List<dynamic> cpy;
  PropularProductController controller;
  MyDelegete({Key? key, required this.cpy,required this.controller});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else
            query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> lsp = cpy.where((searchresult) {
      final res = searchresult
      final ip = query.toLowerCase();
      return res.contains(ip);
    }).toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: lsp.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Obx(
                  () => ListTile(
                tileColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: Text(
                  lsp[index].displayNameWOExt,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                subtitle: Text(
                  lsp[index].artist!,
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                leading: Image.asset('name'),

                trailing: controller.playIndex.value == index &&
                    controller.isPlaying.value
                    ? const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 26,
                )
                    : null,
                onTap: () {
                  controller.playSong(lsp[index].uri, index);
                  // Get.to(() => Player(
                  //   songModel: lsp,
                  // ));
                  // controller.playSong(snapshot.data![index].uri,index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

