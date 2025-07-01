// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// void main() {
//   runApp(const JodeTxSDKApp());
// }

// class JodeTxSDKApp extends StatelessWidget {
//   const JodeTxSDKApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'JodeTx Payment SDK',
//       theme: ThemeData(primarySwatch: Colors.teal),
//       home: const PaymentGatewayScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class PaymentGatewayScreen extends StatefulWidget {
//   const PaymentGatewayScreen({super.key});

//   @override
//   State<PaymentGatewayScreen> createState() => _PaymentGatewayScreenState();
// }

// class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> {
//   static const platform = MethodChannel('jodetx/payment');

//   String orderId = 'ORD${DateTime.now().millisecondsSinceEpoch}';
//   double amount = 799.0;

//   Future<void> _sendPaymentResult(String status) async {
//     try {
//       await platform.invokeMethod('paymentResult', {'status': status});
//     } catch (e) {
//       debugPrint("Error sending result to native: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("JodeTx - Payment")),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text("Amount: ₹$amount", style: const TextStyle(fontSize: 22)),
//               const SizedBox(height: 8),
//               Text("Order ID: $orderId", style: const TextStyle(fontSize: 18)),
//               const SizedBox(height: 30),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   _sendPaymentResult("success:$orderId");
//                 },
//                 icon: const Icon(Icons.check_circle),
//                 label: const Text("Pay Now (Success)"),
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//               ),
//               const SizedBox(height: 12),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   _sendPaymentResult("fail:Payment Declined");
//                 },
//                 icon: const Icon(Icons.cancel),
//                 label: const Text("Simulate Failure"),
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'pages/product_page.dart';

void main() {
  runApp(const ShopEasyApp());
}

class ShopEasyApp extends StatelessWidget {
  const ShopEasyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JodeTx Payment SDK',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const ProductListPage(),
    );
  }
}
