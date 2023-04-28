import 'package:e_commerce/auth/sign_input_widget.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/custom_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../account/account_page.dart';
import '../widgets/Big_text.dart';
import 'fire_auth.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();
    var phonecontroller = TextEditingController();
    var namecontroller = TextEditingController();
    List name = ["google.png", "fb.png", "twtr.png"];
final FirebaseAuth auth = FirebaseAuth.instance; 
 
    Future<void> _registration() async {
      
      String name = namecontroller.text.trim();
      String phone = phonecontroller.text.trim();
      String email = emailcontroller.text.trim();
      String password = passwordcontroller.text.trim();
      if (name.isEmpty) {
        showCustomSnackBar("Type in your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone", title: "phone");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type in your email", title: "email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in correct email", title: "email");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "password");
      } else if (password.length < 6) {
        showCustomSnackBar("Type strong password", title: "password");
      } else {
        User? user = await FireAuth.registerUsingEmailPassword(
            email: emailcontroller.text,
            password: passwordcontroller.text,
            name: namecontroller.text,
            phone: phonecontroller.text);
        if (user != null) {
          showCustomSnackBar("Registration sucessful!",isError: false);
          user.sendEmailVerification();
           Navigator.of(context).pushReplacement(
                    
                    MaterialPageRoute(
                      builder: (context) => AccountPage(user: user,),
                    ),
                  );
        }
      }
    }

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
                "Register in Your Cart",
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
            type: TextInputType.emailAddress,
            hint: "Email",
            icon: Icons.email,
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
          InputWidget(
            controller: phonecontroller,
            type: TextInputType.phone,
            hint: "Phone",
            icon: Icons.phone,
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          InputWidget(
            controller: namecontroller,
            hint: "Name",
            type: TextInputType.name,
            icon: Icons.person,
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          GestureDetector(
            onTap: () {
              _registration();
            },
            child: Container(
              width: 160,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: Colors.green),
              child: Center(
                child: BigText(
                  text: "Sign Up",
                  size: Dimensions.font20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
          RichText(
              text: TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.back(),
                  text: "Have an account already?",
                  style: TextStyle(
                      color: Color.fromARGB(255, 57, 56, 56),
                      fontSize: Dimensions.font20))),
          SizedBox(
            height: Dimensions.height10 * 0.05,
          ),
          RichText(
              text: TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.back(),
                  text: "Sign Up using",
                  style: TextStyle(
                      color: Colors.grey, fontSize: Dimensions.font20))),
          Wrap(
            children: List.generate(
                3,
                (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/' + name[index]),
                          radius: Dimensions.radius20),
                    )),
          )
        ],
      ),
    );
  }
}
