import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPage createState() => _NewsPage();
}

class _NewsPage extends State<NewsPage> {
  String? _selectedExpressway;
  String? _selectedEntrance;
  String? _selectedExit;
  int _currentPage = 0;

  final List<String> _expressways = ['NLEX', 'SLEX'];
  final List<String> _entrances = [
    'BWK',
    'MIN',
    'KAR',
    'VAL',
    'MEY',
    'MAR',
    'CDV',
    'BOC'
  ];
  final List<String> _exits = [
    'Mindanao Avenue',
    'Karuhatan',
    'Valenzuela',
    'Meycauayan',
    'Marilao'
  ];

  final List<String> _fares = ['Class 1', 'Class 2', 'Class 3'];
  final List<double> _fareValues = [50.0, 100.0, 150.0];

  final List<String> _trafficAdvisories = [
    'Traffic Advisory 1',
    'Traffic Advisory 2',
    'Traffic Advisory 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Colors.grey[300],
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Expressway',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    DropdownButtonFormField<String>(
                      value: _selectedExpressway,
                      onChanged: (value) {
                        setState(() {
                          _selectedExpressway = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Select Expressway',
                        border: const OutlineInputBorder(),
                      ),
                      items: _expressways
                          .map(
                            (e) =>
                            DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ),
                      )
                          .toList(),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Toll Gate Entrance',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    DropdownButtonFormField<String>(
                      value: _selectedEntrance,
                      onChanged: (value) {
                        setState(() {
                          _selectedEntrance = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Select Toll Gate Entrance',
                        border:  OutlineInputBorder(),
                      ),
                      items: _entrances
                          .map(
                            (e) =>
                            DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ),
                      )
                          .toList(),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Toll Gate Exit',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    DropdownButtonFormField<String>(
                      value: _selectedExit,
                      onChanged: (value) {
                        setState(() {
                          _selectedExit = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Select Toll Gate Exit',
                        border:  OutlineInputBorder(),
                      ),
                      items: _exits
                          .map(
                            (e) =>
                            DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ),
                      )
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                color: Colors.grey[300],
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Total Fare',
                      style:  TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Text(
                          _fares[0],
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              '₱${_fareValues[0].toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text(
                          _fares[1],
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              '₱${_fareValues[1].toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text(
                          _fares[2],
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              '₱${_fareValues[2].toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                color: Colors.grey[300],
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  const Text(
                  'Traffic Advisory',
                  style:  TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 120.0,
                  child: PageView.builder(
                    itemCount: _trafficAdvisories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(_trafficAdvisories[index]);
                    },
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {  // Added comma here
                          setState(() {
                            _currentPage =
                                (_currentPage + 1) % _trafficAdvisories.length;
                          });
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ),
          ],
        ),
      ),
      ),
    );
  }
}


