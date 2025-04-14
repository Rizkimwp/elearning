import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/message_controller.dart';

class MessageGuruView extends GetView<MessageController> {
  const MessageGuruView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: const Center(
        child: Text(
          'MessageView Guru is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
