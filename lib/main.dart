// ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api

import 'package:api/LocalListData.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyAPI());
}

class MyAPI extends StatelessWidget {
  const MyAPI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API',
      theme: ThemeData(
        fontFamily: 'Quicksand',
      ),
      home: const List1(),
      // home: List2(),
      // home: RestCountriesAPI(),
      // home: IndependentCountriesAPI(),
    );
  }
}
