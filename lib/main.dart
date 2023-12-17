// import 'package:flutter/material.dart';
// import 'package:flutterrazorpay/home.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: Home(),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DonationScreen(),
    );
  }
}

class DonationScreen extends StatefulWidget {
  @override
  _DonationScreenState createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  TextEditingController _amountController = TextEditingController();
  bool _loading = false;

  void _showSuccessDialog(String amount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green,
          content: Container(
            height: 150.0, // Set the desired height
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Donation Successful',
                    style: TextStyle(color: Colors.white)),
                SizedBox(height: 10),
                Text('Thank you for donating ₹$amount!',
                    style: TextStyle(color: Colors.white)),
                SizedBox(height: 10),
                Text('✅', style: TextStyle(fontSize: 40, color: Colors.white)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _donate() {
    setState(() {
      _loading = true;
    });

    String amount = _amountController.text;

    // Simulate a delay for 2 seconds (replace this with your actual donation logic)
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _loading = false;
      });

      // Show the success dialog
      _showSuccessDialog(amount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Donation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Amount (₹)',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _donate();
              },
              child: Text('Donate'),
            ),
            if (_loading) ...[
              SizedBox(height: 16.0),
              CircularProgressIndicator(),
            ],
          ],
        ),
      ),
    );
  }
}
