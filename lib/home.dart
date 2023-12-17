import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Razorpay? _razorpay;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize _razorpay instance
    // _razorpay = Razorpay(packageName: "flutterrazorpay");
    _razorpay = Razorpay();

    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handleErrorFailure);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // Dispose _razorpay instance
    _razorpay?.clear();
    super.dispose();
  }

  void openCheckout() {
    var options = {
      "key": "S0YXg2ObDkOEJGqmUTncmE0E",
      "amount": num.parse(textEditingController.text) * 100,
      "name": "Sample App",
      "description": "Payment for some random product",
      "prefill": {"contact": "2323232323", "email": "example@example.com"},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      print("|||||||||||||||||||||||||||||||||||||||||");
      _razorpay?.open(options);
    } catch (e) {
      print("||||||||||||||||||||||||||||||||||||||||||");
      debugPrint('Error: $e');
      _showToast('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint("Payment success: ${response.paymentId}");
    _showToast("Payment success");
  }

  void _handleErrorFailure(PaymentFailureResponse response) {
    debugPrint("Payment error: ${response.code} - ${response.message}");

    // Check if the error field is a Map
    if (response.error is Map<dynamic, dynamic>) {
      Map<dynamic, dynamic> errorDetails = response.error!;

      // Extract and handle the error details
      if (errorDetails.containsKey('code')) {
        int errorCode = errorDetails['code'];
        String errorMessage = errorDetails['message'];

        debugPrint("Error details: Code: $errorCode, Message: $errorMessage");
      }
    }

    _showToast("Payment error");
  }

  // void _handleErrorFailure(PaymentFailureResponse response) {
  //   debugPrint("Payment error: ${response.code} - ${response.message}");
  //   _showToast("Payment error");
  // }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint("External Wallet: ${response.walletName}");
    _showToast("External Wallet: ${response.walletName}");
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razor Pay Tutorial"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Amount to pay"),
            ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: openCheckout,
              child: Text("Donate Now"),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   Razorpay? _razorpay;
//   TextEditingController textEditingController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     _razorpay = Razorpay();

//     _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handleErrorFailure);
//     _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   @override
//   void dispose() {
//     _razorpay!.clear();
//     super.dispose();
//   }

//   void openCheckout() {
//     var options = {
//       "key": "S0YXg2ObDkOEJGqmUTncmE0E",
//       "amount": num.parse(textEditingController.text) * 100,
//       "name": "Sample App",
//       "description": "Payment for some random product",
//       "prefill": {"contact": "2323232323", "email": "example@example.com"},
//       "external": {
//         "wallets": ["paytm"]
//       }
//     };

//     try {
//       _razorpay?.open(options);
//     } catch (e) {
//       debugPrint('Error: $e');
//       _showToast('Error: $e');
//     }
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     debugPrint("Payment success: ${response.paymentId}");
//     _showToast("Payment success");
//   }

//   void _handleErrorFailure(PaymentFailureResponse response) {
//     debugPrint("Payment error: ${response.code} - ${response.message}");
//     _showToast("Payment error");
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     debugPrint("External Wallet: ${response.walletName}");
//     _showToast("External Wallet: ${response.walletName}");
//   }

//   void _showToast(String message) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Razor Pay Tutorial"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: textEditingController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(hintText: "Amount to pay"),
//             ),
//             SizedBox(
//               height: 12,
//             ),
//             ElevatedButton(
//               onPressed: openCheckout,
//               child: Text("Donate Now"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// // import 'package:flutter/material.dart';
// // import 'package:razorpay_flutter/razorpay_flutter.dart';
// // import 'package:toast/toast.dart';

// // class Home extends StatefulWidget {
// //   @override
// //   _HomeState createState() => _HomeState();
// // }

// // class _HomeState extends State<Home> {
// //   Razorpay razorpay;
// //   TextEditingController textEditingController = TextEditingController();

// //   @override
// //   void initState() {
// //     super.initState();

// //     razorpay = Razorpay();

// //     razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
// //     razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
// //     razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
// //   }

// //   @override
// //   void dispose() {
// //     super.dispose();
// //     razorpay.clear();
// //   }


// //   void openCheckout() {
// //     var options = {
// //       "key": "[YOUR_API_KEY]",
// //       "amount": num.parse(textEditingController.text) * 100,
// //       "name": "Sample App",
// //       "description": "Payment for some random product",
// //       "prefill": {"contact": "2323232323", "email": "shdjsdh@gmail.com"},
// //       "external": {
// //         "wallets": ["paytm"]
// //       }
// //     };

// //     try {
// //       razorpay.open(options);
// //     } catch (e) {
// //       print(e.toString());
// //     }
// //   }

// //   void handlerPaymentSuccess(PaymentSuccessResponse response) {
// //     print("Payment success: ${response.paymentId}");
// //     Toast.show("Payment success", context, duration: Toast.LENGTH_SHORT);
// //   }

// //   void handlerErrorFailure(PaymentFailureResponse response) {
// //     print("Payment error: ${response.code} - ${response.message}");
// //     Toast.show("Payment error", context, duration: Toast.LENGTH_SHORT);
// //   }

// //   void handlerExternalWallet(ExternalWalletResponse response) {
// //     print("External Wallet: ${response.walletName}");
// //     Toast.show("External Wallet", context, duration: Toast.LENGTH_SHORT);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Razor Pay Tutorial"),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(30.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: textEditingController,
// //               keyboardType: TextInputType.number,
// //               decoration: InputDecoration(hintText: "Amount to pay"),
// //             ),
// //             SizedBox(
// //               height: 12,
// //             ),
// //             ElevatedButton(
// //               onPressed: () {
// //                 openCheckout();
// //               },
// //               child: Text("Donate Now"),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // import 'package:flutter/material.dart';
// // // import 'package:razorpay_flutter/razorpay_flutter.dart';
// // // import 'package:toast/toast.dart';

// // // class Home extends StatefulWidget {
// // //   @override
// // //   _HomeState createState() => _HomeState();
// // // }

// // // class _HomeState extends State<Home> {
// // //   Razorpay razorpay;
// // //   TextEditingController textEditingController = new TextEditingController();

// // //   @override
// // //   void initState() {
// // //     super.initState();

// // //     razorpay = new Razorpay();

// // //     razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
// // //     razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
// // //     razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
// // //   }

// // //   @override
// // //   void dispose() {
// // //     // TODO: implement dispose
// // //     super.dispose();
// // //     razorpay.clear();
// // //   }

// // //   void openCheckout() {
// // //     var options = {
// // //       "key": "[YOUR_API_KEY]",
// // //       "amount": num.parse(textEditingController.text) * 100,
// // //       "name": "Sample App",
// // //       "description": "Payment for the some random product",
// // //       "prefill": {"contact": "2323232323", "email": "shdjsdh@gmail.com"},
// // //       "external": {
// // //         "wallets": ["paytm"]
// // //       }
// // //     };

// // //     try {
// // //       razorpay.open(options);
// // //     } catch (e) {
// // //       print(e.toString());
// // //     }
// // //   }

// // //   void handlerPaymentSuccess() {
// // //     print("Pament success");
// // //     Toast.show("Pament success", context);
// // //   }

// // //   void handlerErrorFailure() {
// // //     print("Pament error");
// // //     Toast.show("Pament error", context);
// // //   }

// // //   void handlerExternalWallet() {
// // //     print("External Wallet");
// // //     Toast.show("External Wallet", context);
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text("Razor Pay Tutorial"),
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(30.0),
// // //         child: Column(
// // //           children: [
// // //             TextField(
// // //               controller: textEditingController,
// // //               decoration: InputDecoration(hintText: "amount to pay"),
// // //             ),
// // //             SizedBox(
// // //               height: 12,
// // //             ),
// // //             FloatingActionButton(
// // //               // color: Colors.blue,
// // //               child: Text(
// // //                 "Donate Now",
// // //                 style: TextStyle(color: Colors.white),
// // //               ),
// // //               onPressed: () {
// // //                 openCheckout();
// // //               },
// // //             )
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
