import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/auth/signup_screen.dart';
import 'package:frontend/consts/colors.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/widgets/snackbar.dart';
import 'package:get/get.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenEmailAuthState();
}

class _LoginScreenEmailAuthState extends State<LoginScreen> {
  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(
            color: fontwhite,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
          () => SafeArea(
              child: Column(
            children: [
              const SizedBox(height: 15),
              customTextField(
                  hintText: "eg. vendor@gmail.com",
                  label: "Email Address",
                  controller: controller.emailController,
                  borderColor: fontGrey,
                  color: fontwhite),
              const SizedBox(height: 15),
              customPasswordTextField(
                hintText: "*****",
                label: "Password",
                controller: controller.passController,
                isPass: !controller.isShowing.value,
                onPress: () {
                  controller.isShowing.value = !controller.isShowing.value;
                },
                color: fontwhite,
                borderColor: fontGrey,
              ),
              const SizedBox(height: 15),
              Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(color: buttonColor))
                    : CustomButton(
                        text: "Login",
                        onPressed: () async {
                          controller.isLoading.value = true;
                          await controller
                              .loginMethod(context: context)
                              .then((value) {
                            if (value != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  customSnackBar("Logged in Successfully"));

                              print(
                                  "${FirebaseAuth.instance.currentUser!.email} hello");
                              Get.offAll(() => const HomeScreen());
                            }
                          });
                        },
                      ),
              ),
              TextButton(
                onPressed: () {
                  Get.offAll(() => const SignUpScreen());
                },
                child: Text(
                  "New user? Create account",
                  style: TextStyle(
                    color: buttonColor.withOpacity(0.8),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
