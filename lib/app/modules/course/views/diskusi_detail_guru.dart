import 'package:elearning/app/data/diskusi/controller/diskusi_controller.dart';
import 'package:elearning/app/data/diskusi/diskusi.dart';
import 'package:elearning/app/data/diskusireply/controller/diskusireply_controller.dart';
import 'package:elearning/app/data/diskusireply/diskusi_reply.dart';
import 'package:elearning/utils/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiskusiDetailGuru extends StatefulWidget {
  final Discussion diskusi;

  const DiskusiDetailGuru({Key? key, required this.diskusi}) : super(key: key);

  @override
  State<DiskusiDetailGuru> createState() => _DiskusiDetailGuruState();
}

class _DiskusiDetailGuruState extends State<DiskusiDetailGuru> {
  final TextEditingController _controller = TextEditingController();
  final DiskusiReplyController controller = Get.put(DiskusiReplyController());
  final DiskusiController diskusiController = Get.put(DiskusiController());

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    final reply = DiskusiReplyPost(
      message: _controller.text.trim(),
      discussionId: widget.diskusi.id,
      createdById: AuthHelper.userId, // Ambil dari auth/session kamu
    );

    print(reply.createdById);
    controller.postReply(reply);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(widget.diskusi.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_comment_rounded),
            onPressed: () {
              // Aksi lain jika diperlukan
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header content diskusi
          Container(
            margin: const EdgeInsets.only(top: 2.0),
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: Colors.yellowAccent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.black, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.diskusi.content,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Komentar - Reactive UI
          Expanded(
            child: Obx(() {
              final replies =
                  diskusiController
                      .getRepliesByDiskusiId(widget.diskusi.id)
                      .toList(); // pastikan dapat List baru agar rebuild

              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                itemCount: replies.length,
                itemBuilder: (context, index) {
                  final reply = replies[index];
                  final isMe = reply.createBy.id == AuthHelper.userId;

                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue[100] : Colors.grey[200],
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(12),
                          topRight: const Radius.circular(12),
                          bottomLeft: Radius.circular(isMe ? 12 : 0),
                          bottomRight: Radius.circular(isMe ? 0 : 12),
                        ),
                      ),
                      constraints: const BoxConstraints(maxWidth: 280),
                      child: Column(
                        crossAxisAlignment:
                            isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor:
                                    isMe ? Colors.blue : Colors.grey,
                                child: Text(
                                  reply.createBy.nama[0],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                reply.createBy.nama,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            reply.message,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            reply.createdAt.toLocal().toString().substring(
                              0,
                              16,
                            ),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Tulis komentar...",
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send_rounded, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
