import 'package:flutter/material.dart';
import 'package:ftpproject/firebase_api.dart';
import 'package:ftpproject/firebase_file.dart';

import 'imagepage.dart';

class DownloadScreen extends StatefulWidget {
  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll(
        '/files/data/user/0/com.example.ftpproject/cache/file_picker');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1b2842),
      appBar: AppBar(
        backgroundColor: Color(0xff7ac4a8),
        title: Text(
          "Download",
          style: TextStyle(color: Color(0xff1b2842)),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<FirebaseFile>>(
        future: futureFiles,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if ((snapshot.hasError)) {
                return Center(
                  child: Text('Some error occurred!'),
                );
              }
              final files = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(files.length),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final file = files[index];

                        return buildFile(context, file);
                      },
                    ),
                  )
                ],
              );
          }
        },
      ),
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile file) => GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePage(file: file),
        ));
      },
      child: ListTile(
        leading: ClipOval(
          child: Image.network(
            file.url,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          file.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff7ac4a8),
          ),
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePage(file: file),
        )),
      )
      );

  Widget buildHeader(int length) => ListTile(
        tileColor: Color(0xff7ac4a8),
        leading: Container(
          width: 52,
          height: 52,
          child: Icon(
            Icons.file_copy,
            color: Color(0xff1b2842),
          ),
        ),
        title: Text(
          '$length Files',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xff1b2842)),
        ),
      );
}
