import 'package:flutter/material.dart';
// Import-kani waa inuu lahaadaa magaca saxda ah ee project-kaaga ama galka Receipt-ka.
// Haddii Receipt.dart uu ku dhex jiro project-ka, tani waa ay shaqaynaysaa:
import 'package:xirfadsan_receipt/Receipt.dart';
// Waxaan u malaynayaa in Receipt.dart uu ku jiro Widget la yiraahdo "ReceiptPage"

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Wuxuu qariyaa "DEBUG" banner-ka

      // Halkan waa in aad soo wacdaa Widget-ka rasiidka oo dhan.
      // Waxaan u malaynayaa inuu yahay "ReceiptPage" ama "ReceiptWidget".
      // Haddii aan u isticmaalno magaca "ReceiptPage":
      home: ReceiptPage(),

      // Haddii Receipt.dart uu kaliya lahaa widget-ka "XirfadsanLogo",
      // markaa waxaad horey u samaysay, laakiin design-kaaga wuxuu ahaa bog dhan.
    );
  }
}

// Haddii uu wali error-ku yahay logo-ga, waa inaan hubinaa in 'XirfadsanLogo' uu si sax ah u qoran yahay.
// Haddii aad la kulanto error kale oo asset ah, ku beddel khadka 
// 'home: ReceiptPage(),' midkan si aad u hubiso code-ka logo-ga:
/*
home: Scaffold(
    body: Center(
        // Tani waxay muujinaysaa in 'XirfadsanLogo' uu ka yimid 'Receipt.dart'
        child: XirfadsanLogo(), 
    ),
),
*/