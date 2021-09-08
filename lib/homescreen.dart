import 'package:flutter/material.dart';
import 'package:ftpproject/download.dart';
import 'package:ftpproject/upload.dart';




class HomeScreen extends StatefulWidget {
 
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1b2842),
     appBar: AppBar(
       backgroundColor: Color(0xff7ac4a8),
       title: Text("Uploader and Downloader",
       style: TextStyle(
         color: Color(0xff1b2842),
       ),
       ),
     ),
      body: GestureDetector(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                  child: Text("Upload",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff1b2842),
                    ),
                  ),
                  onPressed: (){
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => UploadScreen()),
                     );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff7ac4a8),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                     shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: Text("Download",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff1b2842),
                    ),
                  ),
                  onPressed: (){
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => DownloadScreen()),
                     );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff7ac4a8),
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
