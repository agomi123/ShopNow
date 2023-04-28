import 'package:e_commerce/widgets/Big_text.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/custom_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/auther.dart';
import '../auth/singin_page.dart';
import '../auth/singup_page.dart';
import '../utils/dimensions.dart';
import 'account_widget.dart';

class AccountPage extends StatefulWidget {
  final User? user;
  const AccountPage({required this.user});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late User? _currentUser;
  @override
  void initState() {
  
    super.initState();
    _currentUser = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return _currentUser != null
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: BigText(
                text: "Profile",
              ),
              titleSpacing: 00.0,
              backgroundColor: Colors.greenAccent,
              centerTitle: true,
              toolbarHeight: 60.2,
              toolbarOpacity: 0.8,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
              ),
              elevation: 0.00,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.logout_outlined),
                  tooltip: 'Logout Icon',
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    showCustomSnackBar("Logout",
                        isError: false, title: "LogOuted!");
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => SignInPage(),
                      ),
                    );
                  },
                ), //IconButton
              ],
            ),
            body: Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: Dimensions.height20),
              child: Column(
                children: [
                  AppIcon(
                    icon: Icons.person,
                    size: Dimensions.height15 * 10,
                  ),
                  SizedBox(
                    height: Dimensions.height30,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: Dimensions.height30,
                          ),
                          AccountWidget(
                            text: "Name",
                            icon: AppIcon(icon: Icons.person),
                            bigText: BigText(
                              text: '${_currentUser!.displayName}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height30,
                          ),
                          AccountWidget(
                            text: "Phone Number",
                            icon: AppIcon(icon: Icons.phone_android),
                            bigText: BigText(
                              text: '${_currentUser!.phoneNumber}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height30,
                          ),
                          AccountWidget(
                            text: "Email",
                            icon: AppIcon(icon: Icons.email),
                            bigText: BigText(
                              text: '${_currentUser!.email}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height30,
                          ),
                          AccountWidget(
                            text: "location",
                            icon: AppIcon(icon: Icons.location_city),
                            bigText: BigText(
                              text: "Fill in your address",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height30,
                          ),
                          AccountWidget(
                            text: "Any Message",
                            icon: AppIcon(icon: Icons.message_outlined),
                            bigText: BigText(
                              text: '${_currentUser!.uid}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : Auther();
  }
}
