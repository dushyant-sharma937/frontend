// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/auth/login_screen.dart';
import 'package:frontend/widgets/snackbar.dart';
import 'package:get/get.dart';
import '../consts/colors.dart';
import '../screens/home_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'auth_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final TextEditingController _cpassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
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
            customTextField(
                hintText: "********",
                label: "Password",
                controller: controller.passController,
                borderColor: fontGrey,
                color: fontwhite),
            const SizedBox(height: 15),
            customTextField(
                hintText: "********",
                label: "Confirm Password",
                controller: _cpassController,
                borderColor: fontGrey,
                color: fontwhite),
            const SizedBox(height: 15),
            Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(color: buttonColor))
                  : CustomButton(
                      text: "Create Account",
                      onPressed: () async {
                        if (_cpassController.text.trim() ==
                            controller.passController.text.trim()) {
                          controller.isLoading.value = false;
                          await controller
                              .createAccount(context: context)
                              .then((value) {
                            if (value != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  customSnackBar("User created successfully"));

                              print(
                                  "${FirebaseAuth.instance.currentUser!.email} hello");
                              Get.offAll(() => const HomeScreen());
                            }
                          });
                          _cpassController.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              customSnackBar("Password doesn't match!"));
                        }
                      }),
            ),
            TextButton(
              onPressed: () {
                Get.offAll(() => const LoginScreen());
              },
              child: Text(
                "Already a registerd user? Login here",
                style: TextStyle(
                  color: buttonColor.withOpacity(0.8),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
