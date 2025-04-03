import 'package:elearning/app/components/custom_appbar.dart';
import 'package:elearning/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hi, Username',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Get.offNamed(Routes.ACCOUNT);
                          },
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/avatar/profile.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 190),
              padding: EdgeInsets.only(top: 60),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Browse a Course',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(4, (index) => courseCard()),
                    ),
                  ),
                  SizedBox(height: 20),
                  assignmentSection(),
                  SizedBox(height: 20),
                  discussionSection(),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 140, horizontal: 20),
              height: 100,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Course',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text('My Courses', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Course Title',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

Widget courseCard() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    padding: EdgeInsets.all(15),
    width: 200,
    height: 150,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Course Title', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.all(9),
          ),
          child: Text('Get Started', style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}

Widget assignmentSection() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Assignment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black45,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: 10),
        Column(
          children: List.generate(
            3,
            (index) => ListTile(
              title: Text(
                'Product Design',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
              ),
              trailing: Text('6/24'),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget discussionSection() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.purple[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Have an issue?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text("Let's ask and find the solution here."),
        ],
      ),
    ),
  );
}
