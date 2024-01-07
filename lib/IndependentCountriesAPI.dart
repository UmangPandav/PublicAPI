// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class IndependentCountriesAPI extends StatefulWidget {
  const IndependentCountriesAPI({super.key});

  @override
  State<IndependentCountriesAPI> createState() => _IndependentCountriesAPIState();
}

class _IndependentCountriesAPIState extends State<IndependentCountriesAPI> {

  List<dynamic> userData  = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse("https://restcountries.com/v3.1/independent?status=true&fields=languages,capital"));

    setState(() {
      userData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: const Text("Independent Countries API"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            for(var User in userData)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                child: Container(
                  width: w,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white24,borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Capital: ',style: TextStyle(fontSize: 20)),
                      for(var Capital in User['capital'])
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          child: Container(
                            width: w,
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                              decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text('$Capital',style: const TextStyle(fontSize: 18))
                          ),
                        ),

                      const SizedBox(height: 10,),
                      const Text('Languages: ',style: TextStyle(fontSize: 20)),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: w,
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                          decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var key in User['languages'].keys)
                                Text('$key : ${User['languages'][key]}',style: const TextStyle(fontSize: 17),),
                            ],
                          ),
                        ),
                      )
                      // for (var key in User['languages'].keys)
                      //   Padding(
                      //     padding: const EdgeInsets.all(3.0),
                      //     child: Container(
                      //       width: w,
                      //       padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      //       decoration: BoxDecoration(
                      //           color: Colors.white24,
                      //           borderRadius: BorderRadius.circular(10)
                      //       ),
                      //       child: Text('$key : ${User['languages'][key]}',style: const TextStyle(fontSize: 17),),
                      //     ),
                      //   ),

                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
