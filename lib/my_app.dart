import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:via_cep_api/pages/main_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainPage(),
      theme: ThemeData(primarySwatch: Colors.teal, textTheme: GoogleFonts.robotoTextTheme()),
      debugShowCheckedModeBanner: false,
    );
  }
}