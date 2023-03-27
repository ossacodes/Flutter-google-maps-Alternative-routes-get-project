import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GreyBoxContent {
  final String text1;
  final String text2;
  final String imagePath;

  GreyBoxContent({required this.text1,
    required this.text2,
    required this.imagePath});
}

class EmergencyCallPage extends StatelessWidget {
  final List<GreyBoxContent> contents = [
    GreyBoxContent(
      text1: ' Metropolitan Manila Development Authority (MMDA)',
      text2: '136',
      imagePath: 'images/MMDAlogo.png',
    ),
    GreyBoxContent(
      text1: 'Philippine National Police (PNP)',
      text2: '117',
      imagePath: 'images/PNPlogo.png',
    ),
    GreyBoxContent(
      text1: 'Bureau of Fire Protection (BFP)',
      text2: '(02) 8426 - 0219',
      imagePath: 'images/BFPlogo.png',
    ),
    GreyBoxContent(
      text1: 'North Luzon Expressway (NLEX)',
      text2: '1-35000',
      imagePath: 'images/NLEXlogo.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemCount: contents.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          contents[index].text1,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          contents[index].text2,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton.icon(
                          onPressed: () {
                            launchUrlString('tel: ${contents[index].text2}');
                          },
                          icon: Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Call',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Image.asset(contents[index].imagePath),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


