import 'package:elearning/app/modules/auth/views/register_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  AuthView({super.key});
  final authController = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section with "Log In" text
            Container(
              height: 200,
              width: double.infinity,
              padding: EdgeInsets.only(top: 90, left: 20, bottom: 20),
              color: Colors.blue,
              alignment: Alignment.bottomLeft,
              child: Text(
                'Log In',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 30,
                ),
              ),
            ),

            // Bottom Section with form
            Container(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              height: MediaQuery.of(context).size.height - 195,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Input Email
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Masukan Email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: authController.emailController,
                    decoration: InputDecoration(
                      hintText: "your_mail@gmail.com",
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Input Password
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Masukan Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),

                  StatefulBuilder(
                    builder: (context, setState) {
                      return TextField(
                        obscureText: authController.obscureText.value,
                        controller: authController.passwordController,
                        decoration: InputDecoration(
                          hintText: "********",
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              authController.obscureText.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                authController.obscureText.value =
                                    !authController
                                        .obscureText
                                        .value; // Toggle nilai
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  // Menampilkan pesan kesalahan di bawah form
                  Obx(
                    () =>
                        authController.errorMessage.value.isNotEmpty
                            ? Text(
                              authController.errorMessage.value,
                              style: TextStyle(color: Colors.red),
                            )
                            : Container(),
                  ),

                  SizedBox(height: 20),

                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          authController
                              .login(); // Panggil fungsi login yang sudah ada
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3D5CFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Obx(() {
                          // Periksa status loading, jika loading tampilkan CircularProgressIndicator
                          return authController.isLoading.value
                              ? CircularProgressIndicator(
                                color:
                                    Colors
                                        .white, // Warna loading sesuai dengan tombol
                              )
                              : Text(
                                'Log in',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              );
                        }),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: "Belum punya akun ?  ",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Register",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blue,
                              decoration: TextDecoration.none,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.put(AuthController());
                                    Get.to(
                                      RegisterView(),
                                      transition: Transition.fadeIn,
                                      duration: Duration(milliseconds: 500),
                                    );
                                  },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
