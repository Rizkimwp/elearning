import 'package:elearning/app/components/button/button.dart';
import 'package:elearning/app/components/textfield/textfield.dart';
import 'package:elearning/app/data/meeting/meeting.dart';
import 'package:elearning/app/data/videomaterial/controller/vidio_controller.dart';
import 'package:elearning/app/data/videomaterial/vidio.dart';
import 'package:elearning/utils/auth_helper.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VidioFormPage extends StatefulWidget {
  final Meeting meeting;
  const VidioFormPage({Key? key, required this.meeting}) : super(key: key);
  @override
  _VidioFormPageState createState() => _VidioFormPageState();
}

class _VidioFormPageState extends State<VidioFormPage> {
  static final vidioController = Get.put<VidioController>(VidioController());
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  String? filePath; // Untuk menyimpan path file yang dipilih

  // Fungsi untuk memilih file
  Future<void> _pickFile() async {
    try {
      final XFile? file = await openFile();
  
      if (file != null) {
        setState(() {
          filePath = file.path;
        });
      } else {
        debugPrint('File picking canceled.');
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
    }
  }

  // Fungsi untuk mengirim data ke API
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Validasi berhasil, ambil data dari form
      String title = titleController.text;

      // Membuat objek Module (seperti di controller)
      VidioPost vidio = VidioPost(
        title: title,
        meetingId: widget.meeting.id,
        uploadById: AuthHelper.userId,
        file: filePath,
      );

      // Panggil controller untuk menambah post
      vidioController.postVidio(vidio);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Modul'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Input
              TextFormField(
                controller: titleController,
                decoration: buildInputDecoration(
                  'Title',
                  'Masukkan title Vidio',
                  Icons.title,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16), // Jarak antar elemen

              // Content Input
              SizedBox(height: 16),
              // File Picker Button with Label
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Pilih Vidio Materi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _pickFile,
                    icon: Icon(
                      filePath == null ? Icons.upload_file : Icons.check_circle,
                      size: 20,
                    ),
                    label: Text(
                      filePath == null ? 'Select File' : 'File Selected',
                    ),
                    style: buildButtonStyle(
                      backgroundColor:
                          filePath == null ? Colors.blue : Colors.green,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Submit Button
              ElevatedButton.icon(
                onPressed: vidioController.isLoading.value ? null : _submitForm,
                icon:
                    vidioController.isLoading.value
                        ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                        : Icon(Icons.send, size: 20),
                label: Text(
                  vidioController.isLoading.value ? 'Submitting...' : 'Submit',
                ),
                style: buildButtonStyle(
                  backgroundColor: Colors.blue,
                  isLoading: vidioController.isLoading.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
