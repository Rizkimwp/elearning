
import 'package:elearning/app/components/button/button.dart';
import 'package:elearning/app/components/textfield/textfield.dart';
import 'package:elearning/app/data/diskusi/controller/diskusi_controller.dart';
import 'package:elearning/app/data/diskusi/diskusi.dart';
import 'package:elearning/app/data/meeting/meeting.dart';
import 'package:elearning/utils/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class DiskusiFormPage extends StatefulWidget{
 final Meeting meeting;

  const DiskusiFormPage({Key? key, required this.meeting}) : super(key: key);

  @override
  _AddDiskusiState createState() => _AddDiskusiState();
}

class _AddDiskusiState extends State<DiskusiFormPage> {
   final _formKey = GlobalKey<FormState>();
  static final diskusiController = Get.put<DiskusiController>(DiskusiController());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Validasi berhasil, ambil data dari form
      String title = titleController.text;
      String content = contentController.text;

      // Membuat objek Module (seperti di controller)
      DiskusiPost diskusi = DiskusiPost(
        title: title,
        content: content,
        meetingId: widget.meeting.id,
        createById: AuthHelper.userId, // Gunakan ID pengguna yang sesuai
        
      );

      // Panggil controller untuk menambah post
      diskusiController.postDiskusi(diskusi);
      Navigator.pop(context);
    }
  }
@override
 Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Buat Diskusi'), backgroundColor: Colors.blue),
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
                  'Judul Diskusi',
                  'Masukkan judul diskusi',
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
                    'Masukkan deskripsi diskusi',
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
    
              // Submit Button
              ElevatedButton.icon(
                onPressed: diskusiController.isLoading.value ? null : _submitForm,
                icon:
                    diskusiController.isLoading.value
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
                  diskusiController.isLoading.value ? 'Submitting...' : 'Submit',
                ),
                style: buildButtonStyle(
                  backgroundColor: Colors.blue,
                  isLoading: diskusiController.isLoading.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
 }

}