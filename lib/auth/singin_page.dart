import 'package:e_commerce/account/account_page.dart';
import 'package:e_commerce/auth/sign_input_widget.dart';
import 'package:e_commerce/auth/singup_page.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/Big_text.dart';
import '../widgets/Small_text.dart';
import '../widgets/custom_message.dart';
import 'fire_auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: Dimensions.height20,
          ),
          Container(
            height: Dimensions.screenHeight * 0.25,
            child: Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("assets/images/logo.jpg"),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: Dimensions.width20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Again to Cart",
                  style: TextStyle(
                      fontSize: Dimensions.font26,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          InputWidget(
            controller: emailcontroller,
            hint: "Email",
            icon: Icons.email,
            type: TextInputType.emailAddress,
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          InputWidget(
            controller: passwordcontroller,
            type: TextInputType.visiblePassword,
            hint: "Password",
            icon: Icons.password,
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          Row(
            children: [
              Expanded(
                child: Container(),
              ),
              Container(
                margin: EdgeInsets.only(right: Dimensions.width10),
                child: RichText(
                    text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                        text: "Sign into your account",
                        style: TextStyle(
                            color: Colors.black, fontSize: Dimensions.font16))),
              ),
            ],
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          GestureDetector(
            onTap: () async {
              var email = emailcontroller.text;
              var password = passwordcontroller.text;
              if (email.isEmpty) {
                showCustomSnackBar("Type in your email",
                    title: "email", isError: true);
              } else if (!GetUtils.isEmail(email)) {
                showCustomSnackBar("Type in correct email",
                    title: "email", isError: true);
              } else if (password.isEmpty) {
                showCustomSnackBar("Type in your password",
                    title: "password", isError: true);
              } else if (password.length < 6) {
                showCustomSnackBar("Type strong password",
                    title: "password", isError: true);
              } else {
                User? user = await FireAuth.signInUsingEmailPassword(
                    email: emailcontroller.text,
                    password: passwordcontroller.text,
                    context: context);
                if (user != null) {
                  showCustomSnackBar("LogInsucessful!",isError: false);
                  //  user.sendEmailVerification();
                  Navigator.of(context).pushReplacement(

                    MaterialPageRoute(
                      builder: (context) => AccountPage(user: user,),
                    ),
                  );
                }
              }
            },
            child: Container(
              width: 160,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: Colors.green),
              child: Center(
                child: BigText(
                  text: "Sign In",
                  size: Dimensions.font20 * 1.5,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
          GestureDetector(
              onTap: () {}, child: SmallText(text: "Forget Password?")),
          SizedBox(
            height: Dimensions.height10,
          ),
          RichText(
            text: TextSpan(
                text: "Doesn't have account?",
                style: TextStyle(
                    color: Color.fromARGB(255, 52, 52, 52),
                    fontSize: Dimensions.font16),
                children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => SignUpPage(),
                            transition: Transition.fade),
                      text: "Create",
                      style: TextStyle(
                        color: Color.fromARGB(255, 105, 1, 1),
                        fontSize: Dimensions.font16,
                      )),
                ]),
          ),
          SizedBox(
            height: Dimensions.height10 * 0.05,
          ),
        ],
      ),
    );
  }
}
