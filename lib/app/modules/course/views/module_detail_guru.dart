import 'dart:io';

import 'package:elearning/app/components/pdf_viewer.dart';
import 'package:elearning/app/data/module/module.dart';
import 'package:elearning/utils/global_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class DetailModulPage extends StatelessWidget {
  final Module modul;

  const DetailModulPage({super.key, required this.modul});

  @override
  Widget build(BuildContext context) {
    final String title = modul.title ?? 'No Title';
    final String content = modul.content ?? 'No Content';
    final String fileUrl = modul.file ?? '';

    // Gantilah base URL di sini sesuai server kamu
    final String fullFileUrl = GlobalConfig.baseUrl + fileUrl;

    return Scaffold(
      appBar: AppBar(title: Text('Detail Modul')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 12),
            Text(content, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 24),
            fileUrl.isNotEmpty
                ? InkWell(
                  onTap: () async {
                    final file = await PDFApi.loadNetwork(
                      fullFileUrl,
                    ); // Memuat file PDF dari URL
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => PDFViewerScreen(
                              file: file,
                            ), // Navigasi ke PDFViewerScreen
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.picture_as_pdf,
                          color: Colors.white,
                        ), // Ikon PDF
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            fullFileUrl.split('/').last, // Nama file PDF
                            style: const TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                : const Text("Tidak ada file terlampir."),
          ],
        ),
      ),
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  final File file;

  const PDFViewerScreen({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    final name = basename(file.path);
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: PDFView(filePath: file.path),
    );
  }
}
