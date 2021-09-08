
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ftpproject/widget.dart/buttonwidget.dart';

import 'firebase_api.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  double progress = 0;
  UploadTask? task;
  bool _isupload = false;
  File? file;
  late String? fileName;

  @override
  Widget build(BuildContext context) {
    fileName = file != null ? (file!.path) : 'No files selected';

    return Scaffold(
      backgroundColor: Color(0xff1b2842),
      body: GestureDetector(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      icon: Icons.attach_file,
                      text: 'Select File',
                      onClicked: selectFile,
                    ),
                    SizedBox(height: 8),
                    Text(
                      fileName ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7ac4a8),
                      ),
                    ),
                    SizedBox(height: 40),
                    ButtonWidget(
                      icon: Icons.upload,
                      text: 'Upload File',
                      onClicked: uploadFile,
                    ),
                    SizedBox(height: 50),
                    _isupload && task != null
                        ? buildUploadStatus(task!)
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    setState(() {
      _isupload = true;
    });
    if (file == null) return;

    final filePath = (file!.path);
    final destination = 'files/$filePath';
    task = FirebaseApi.uploadFile(destination, file!);

    if (task == null) return;
    final snapshot = await task!.whenComplete(() {
      setState(() {
        _isupload = false;
        file = null;
      });
     
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Upload Finished")));
    });
    // final urlDownload = await snapshot.ref.getDownloadURL();

    // print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final snap = snapshot.data!;
          final progress = snap.bytesTransferred / snap.totalBytes;
          final percentage = (snap.bytesTransferred/1000000 ).toStringAsFixed(2);

          return Container(
            child: Column(
              children: [
                SizedBox(
                    height: 20,
                    width: 300,
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey,
                      color: Color(0xff7ac4a8),
                    )),
                Text(
                  'Uploading...$percentage MB',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff7ac4a8)),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      });
}
