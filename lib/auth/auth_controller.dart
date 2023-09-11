import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/providers/notes_provider.dart';
import 'package:frontend/screens/splash_screen.dart';
import 'package:frontend/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AuthController extends GetxController {
  var isShowing = false.obs;
  var emailController = TextEditingController();
  var passController = TextEditingController();

  var isLoading = false.obs;

  // login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim());
      // storeUserData(
      //     password: passController.text.trim(),
      //     email: emailController.text.trim());
      emailController.clear();
      passController.clear();
    } on FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.message.toString())));
    } catch (e) {
      print(e.toString());
    }
    isLoading.value = false;
    return userCredential;
  }

  Future<UserCredential?> createAccount({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passController.text.trim());
      emailController.clear();
      passController.clear();
    } on FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar(err.message.toString()));
    } catch (e) {
      print(e.toString());
    }
    isLoading.value = false;
    return userCredential;
  }

  // // storing data
  // storeUserData({password, email}) async {
  //   DocumentReference store =
  //       firestore.collection(vendorCollections).doc(currentUser!.uid);
  //   store.set({
  //     'password': password,
  //     'email': email,
  //     'name': "",
  //     'id': currentUser!.uid,
  //   });
  //   print("data stored successfully");
  // }

  signOut({context}) async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const SplashScreen());
      Provider.of<NotesProvider>(context, listen: false).notes.clear();
      // VxToast.show(context, msg: "logout successfully");
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar("Logged out successfully"));
      print("Logout successfully");
    } catch (err) {
      // VxToast.show(context, msg: err.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
      print(err.toString());
    }
  }
}
