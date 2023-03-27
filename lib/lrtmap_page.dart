import 'package:flutter/material.dart';

class LRTMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'LRT-MRT MAP',
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: InteractiveViewer(
                  boundaryMargin: const EdgeInsets.all(20),
                  minScale: 1.0,
                  maxScale: 10.0,
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Manila_LRT-MRT_map.png/1200px-Manila_LRT-MRT_map.png',
                  ),
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    'images/yellowboxicon.png',
                    width: 50.0,
                    height: 50.0,
                  ),
                  const SizedBox(
                      width: 10.0), // add some space between the image and text
                  const Text(
                    'LRT 1 (Roosevelt - Baclaran)',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    'images/purpleboxicon.png',
                    width: 50.0,
                    height: 50.0,
                  ),
                  const SizedBox(
                      width: 10.0), // add some space between the image and text
                  const Text(
                    'LRT 2 (Recto - Santolan)',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    'images/blueboxicon.png',
                    width: 50.0,
                    height: 50.0,
                  ),
                  const SizedBox(
                      width: 10.0), // add some space between the image and text
                  const Text(
                    'LRT 3 (North Avenue - Taft)',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
