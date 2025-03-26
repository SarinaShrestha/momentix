// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// class QRScannerPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Scan QR Code")),
//       body: MobileScanner(
//         onDetect: (barcodeCapture) {
//           for (final barcode in barcodeCapture.barcodes) {
//             if (barcode.rawValue != null) {
//               String scannedCode = barcode.rawValue!;
//               Navigator.pop(context);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("Joined Event: $scannedCode")),
//               );
//             }
//           }
//         },
//       ),
//     );
//   }
// }
