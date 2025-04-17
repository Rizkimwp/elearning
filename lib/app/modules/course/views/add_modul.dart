import 'package:elearning/app/components/button/button.dart';
import 'package:elearning/app/components/textfield/textfield.dart';
import 'package:elearning/app/data/meeting/meeting.dart';
import 'package:elearning/app/data/module/controller/module_controller.dart';
import 'package:elearning/app/data/module/module.dart';
import 'package:elearning/utils/auth_helper.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
// Paket untuk memilih file

class ModulFormPage extends StatefulWidget {
  final Meeting meeting;
  const ModulFormPage({Key? key, required this.meeting}) : super(key: key);
  @override
  _ModulFormPageState createState() => _ModulFormPageState();
}

class _ModulFormPageState extends State<ModulFormPage> {
  static final modulController = Get.put<ModuleController>(ModuleController());
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
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
      String content = contentController.text;

      // Membuat objek Module (seperti di controller)
      ModulePost modul = ModulePost(
        title: title,
        content: content,
        meetingId: widget.meeting.id,
        createBy: AuthHelper.userId, // Gunakan ID pengguna yang sesuai
        file: filePath,
      );

      // Panggil controller untuk menambah post
      modulController.addPost(modul);
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
                  'Modul',
                  'Masukkan judul modul',
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
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  controller: contentController,
                  maxLines: 5,
                  decoration: buildInputDecoration(
                    'Konten',
                    'Masukkan deskripsi modul',
                    Icons.description,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter content';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              // File Picker Button with Label
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Pilih File Modul PDF',
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
                onPressed: modulController.isLoading.value ? null : _submitForm,
                icon:
                    modulController.isLoading.value
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
                  modulController.isLoading.value ? 'Submitting...' : 'Submit',
                ),
                style: buildButtonStyle(
                  backgroundColor: Colors.blue,
                  isLoading: modulController.isLoading.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
