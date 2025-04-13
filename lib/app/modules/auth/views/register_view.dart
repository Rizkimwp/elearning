import 'package:elearning/app/modules/auth/controllers/auth_controller.dart';
import 'package:elearning/app/modules/auth/views/auth_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class RegisterView extends GetView<AuthController> {
  RegisterView({super.key});
  final authController = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section
            Container(
              height: 200,
              width: double.infinity,
              padding: EdgeInsets.only(top: 90, left: 20, bottom: 20),
              color: Colors.blue,
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Enter your details below & free sign up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),

            // Form Section
            Container(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              height: MediaQuery.of(context).size.height - 195,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabel("Nama Lengkap"),
                    buildInput(authController.namaController, "John Doe"),
                    buildLabel("Email"),
                    buildInput(
                      controller.emailController,
                      "your_mail@gmail.com",
                    ),

                    buildLabel("Password"),
                    StatefulBuilder(
                      builder: (context, setState) {
                        bool obscureText = true;
                        return TextField(
                          controller: authController.passwordController,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            hintText: "********",
                            enabledBorder: borderStyle(),
                            focusedBorder: borderStyle(focused: true),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() => obscureText = !obscureText);
                              },
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => authController.submitForm(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3D5CFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                          text: "Sudah punya akun ?  ",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          children: [
                            TextSpan(
                              text: "Log in",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.blue,
                                decoration: TextDecoration.none,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(
                                        AuthView(),
                                        transition: Transition.fadeIn,
                                        duration: Duration(milliseconds: 600),
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
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildLabel(String text) => Padding(
  padding: const EdgeInsets.only(top: 15, bottom: 5),
  child: Text(
    text,
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  ),
);

Widget buildInput(TextEditingController controller, String hint) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hint,
      enabledBorder: borderStyle(),
      focusedBorder: borderStyle(focused: true),
    ),
  );
}

OutlineInputBorder borderStyle({bool focused = false}) => OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: BorderSide(color: Colors.black, width: focused ? 2 : 1),
);
