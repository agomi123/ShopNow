import 'package:e_commerce/auth/singup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../account/account_page.dart';
import '../cart/cart_history.dart';
import 'category_sceen.dart';
import 'main_food_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedpage = 0;
  late PersistentTabController _controller;
  List pages = [
    MainFoodPage(),
    SignUpPage(),
    // Container(child: Center(child: Text("1")),),
    Container(
      child: Center(child: Text("2")),
    ),
    Container(
      child: Center(child: Text("3")),
    ),
  ];
  void onTapNav(int index) {
    setState(() {
      _selectedpage = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      MainFoodPage(),
     // CategoryUI(),
      //SignUpPage(),
      // Container(child: Center(child: Text("1")),),
      CartHistory(),
     //Container(),
      AccountPage(user: FirebaseAuth.instance.currentUser,),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),  

      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        title: ("Cart"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Me"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style5, // Choose the nav bar style with this property.
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: pages[_selectedpage],
  //     bottomNavigationBar: BottomNavigationBar(
  //       selectedItemColor: Colors.greenAccent,
  //       showSelectedLabels: false,
  //       showUnselectedLabels: false,
  //       unselectedItemColor: Colors.amberAccent,
  //       currentIndex: _selectedpage,
  //       selectedFontSize: 0.0,
  //       unselectedFontSize: 0.0,
  //       onTap:onTapNav,
  //       items: const [
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.home_outlined), tooltip: "home"),
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.archive), tooltip: "history"),
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.shopping_cart), tooltip: "cart"),
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.person), tooltip: "me"),
  //       ],
  //     ),
  //   );
  // }
}
