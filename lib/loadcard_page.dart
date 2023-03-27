import 'package:flutter/material.dart';

class LoadCardPage extends StatefulWidget {
  @override
  _LoadCardPage createState() => _LoadCardPage();
}

class _LoadCardPage extends State<LoadCardPage> {
  String _price = "100";
  String _selectedAmount = "";

  void _selectAmount(String amount) {
    setState(() {
      _selectedAmount = amount;
      _price = amount;
    });
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => AlertDialog(
              title: Text('Confirmation'),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('images/GCashlogo.png', height: 50, width: 50),
                  Image.asset('images/mayalogo.png', height: 50, width: 50),
                  GestureDetector(
                    onTap: () => _showImageDialog(context),
                    child:
                        Image.asset('images/7elevenlogo.png', height: 50, width: 50),
                  ),
                ],
              ),
            ));
  }

  void _showImageDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => AlertDialog(
              content:
                  Image.asset('images/qrcode.png', height: 200, width: 200),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => _showAmountDialog(context),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/loadcardvisual.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  void _showAmountDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        title: Text('How much?', textAlign: TextAlign.center),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('\u20B1 $_price', style: TextStyle(fontSize: 24)), //PHP Peso Sign \u20B1
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _selectAmount('20');
                        setState(() {}); // rebuild the widget tree
                      },
                      child: Text('20'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _selectAmount('40');
                        setState(() {}); // rebuild the widget tree
                      },
                      child: Text('40'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _selectAmount('60');
                        setState(() {}); // rebuild the widget tree
                      },
                      child: Text('60'),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _selectAmount('80');
                        setState(() {}); // rebuild the widget tree
                      },
                      child: Text('80'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _selectAmount('100');
                        setState(() {}); // rebuild the widget tree
                      },
                      child: Text('100'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showConfirmationDialog(context);
            },
            child: Text('Confirm'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
