// ignore_for_file: unused_local_variable, non_constant_identifier_names, file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'IndependentCountriesAPI.dart';

class RestCountriesAPI extends StatefulWidget {
  const RestCountriesAPI({super.key});


  @override
  State<RestCountriesAPI> createState() => _RestCountriesAPIState();
}

class _RestCountriesAPIState extends State<RestCountriesAPI> {

  List<dynamic> userData  = [];
  late PageController pageController;
  int currentPageIndex = 0;

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse("https://restcountries.com/v3.1/all"));

    setState(() {
      userData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    pageController = PageController(initialPage: currentPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: const Text("Rest Countries API",style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leadingWidth: 100,
        leading: Row(
          children: [
            IconButton(
              onPressed: (){
                if (currentPageIndex > 0) {
                  pageController.animateToPage(0, duration: const Duration(seconds: 1), curve: Curves.easeInOut);
                }
              },
              icon: const Icon(Icons.keyboard_double_arrow_left),
            ),
            IconButton(
              onPressed: (){
                if (currentPageIndex > 0) {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeInOut,
                  );
                }
              },
              icon: const Icon(Icons.keyboard_arrow_left),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: (){
              if (currentPageIndex < userData.length) {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                );
              }
            },
            icon: const Icon(Icons.keyboard_arrow_right),
          ),
          IconButton(
            onPressed: (){
              if (currentPageIndex < userData.length) {
                pageController.animateToPage(userData.length, duration: const Duration(seconds: 1), curve: Curves.easeInOut);
              }
            },
            icon: const Icon(Icons.keyboard_double_arrow_right),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: userData.length,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            itemBuilder: (context, index){
              var User = userData[index];
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: w * 0.5,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(child: Text('${currentPageIndex + 1}', style: const TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.w400)))
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(17)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Name:', style: TextStyle(fontSize: 20),),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width: w,
                                  decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Common: ${User['name']['common']}',style: const TextStyle(fontSize: 18)),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('Official: ',style: TextStyle(fontSize: 18)),
                                          SizedBox(width: w * 0.6,child: Text('${User['name']['official']}',style: const TextStyle(fontSize: 18))),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            if (User['name'].containsKey('nativeName'))
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text('Native Names:', style: TextStyle(fontSize: 18)),
                                                  for (var key in User['name']['nativeName'].keys)
                                                    Padding(
                                                      padding: const EdgeInsets.all(3.0),
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
                                                            Text(key,style: const TextStyle(fontSize: 17),),
                                                            Container(
                                                                padding: const EdgeInsets.fromLTRB(10, 15, 0, 5),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        const Text('Official:  ',style: TextStyle(fontSize: 17),),
                                                                        SizedBox(width: w * 0.5,child: Text('${User['name']['nativeName'][key]['official']}',style: const TextStyle(fontSize: 17),)),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(height: 5),
                                                                    Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        const Text('Common: ',style: TextStyle(fontSize: 17),),
                                                                        SizedBox(width: w * 0.5,child: Text('${User['name']['nativeName'][key]['common']}',style: const TextStyle(fontSize: 17),)),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                )
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              const Text('TLD :', style: TextStyle(fontSize: 20),),
                              if (User.containsKey('tld'))
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    width: w,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        for (var a = 0; a < User['tld'].length; a++)
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('${a+1}.  ${User['tld'][a]}', style: const TextStyle(fontSize: 17)),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 10,),
                              Text('CCA2: ${User['cca2']}', style: const TextStyle(fontSize: 20),),
                              Text('CCN3: ${User['ccn3']}', style: const TextStyle(fontSize: 20),),
                              Text('CCA3: ${User['cca3']}', style: const TextStyle(fontSize: 20),),
                              Text('CIOC: ${User['cioc']}', style: const TextStyle(fontSize: 20),),
                              Text('Independent: ${User['independent']}', style: const TextStyle(fontSize: 20),),
                              Text('Status: ${User['status']}', style: const TextStyle(fontSize: 20),),
                              Text('UnMember: ${User['unMember']}', style: const TextStyle(fontSize: 20),),
                              const SizedBox(height: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (User.containsKey('currencies'))
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Currencies:', style: TextStyle(fontSize: 20)),
                                        for (var key in User['currencies'].keys)
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
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
                                                  Text(key,style: const TextStyle(fontSize: 17),),
                                                  Container(
                                                      padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const Text('Name:  ',style: TextStyle(fontSize: 17),),
                                                              SizedBox(width: w * 0.5,child: Text('${User['currencies'][key]['name']}',style: const TextStyle(fontSize: 17),)),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const Text('Symbol: ',style: TextStyle(fontSize: 17),),
                                                              SizedBox(width: w * 0.5,child: Text('${User['currencies'][key]['symbol']}',style: const TextStyle(fontSize: 17),)),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    )
                                ],
                              ),
                              const SizedBox(height: 10,),
                              const Text('IDD :',style: TextStyle(fontSize: 20)),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width: w,
                                  decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Root : ${User['idd']['root']}',style: const TextStyle(fontSize: 18)),
                                      const SizedBox(height: 5),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('Suffixes : ', style: TextStyle(fontSize: 18),),
                                          if (User['idd'].containsKey('suffixes'))
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                for (var Suffixes in User['idd']['suffixes'])
                                                  Text('$Suffixes', style: const TextStyle(fontSize: 18)),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10,),
                              const Text('Capital :', style: TextStyle(fontSize: 20),),
                              if (User.containsKey('capital'))
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    width: w,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        for (var a = 0; a < User['capital'].length; a++)
                                          Text('${User['capital'][a]}', style: const TextStyle(fontSize: 17)),
                                      ],
                                    ),
                                  ),
                                ),

                              const SizedBox(height: 10,),
                              const Text('AltSpellings :', style: TextStyle(fontSize: 20),),
                              if (User.containsKey('altSpellings'))
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    width: w,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        for (var a = 0; a < User['altSpellings'].length; a++)
                                          Text('${a+1}. ${User['altSpellings'][a]}', style: const TextStyle(fontSize: 18)),
                                      ],
                                    ),
                                  ),
                                ),

                              const SizedBox(height: 10,),
                              Text('Region: ${User['region']}', style: const TextStyle(fontSize: 20),),
                              Text('Subregion: ${User['subregion']}', style: const TextStyle(fontSize: 20),),

                              const SizedBox(height: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Languages:', style: TextStyle(fontSize: 20)),
                                  if (User.containsKey('languages'))
                                    Padding(
                                      padding: const EdgeInsets.all(3),
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
                                              Text('$key : ${User['languages'][key]}',style: const TextStyle(fontSize: 18),),
                                          ],
                                        ),
                                      ),
                                    )
                                ],
                              ),

                              const SizedBox(height: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (User.containsKey('translations'))
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Translations:', style: TextStyle(fontSize: 20)),
                                        for (var key in User['translations'].keys)
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
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
                                                  Text(key,style: const TextStyle(fontSize: 17),),
                                                  Container(
                                                      padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const Text('Official:  ',style: TextStyle(fontSize: 17),),
                                                              SizedBox(width: w * 0.5,child: Text('${User['translations'][key]['official']}',style: const TextStyle(fontSize: 17),)),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const Text('Common: ',style: TextStyle(fontSize: 17),),
                                                              SizedBox(width: w * 0.5,child: Text('${User['translations'][key]['common']}',style: const TextStyle(fontSize: 17),)),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    )
                                ],
                              ),


                              const SizedBox(height: 10,),
                              const Text('Latlng :', style: TextStyle(fontSize: 20),),
                              if (User.containsKey('latlng'))
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    width: w,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        for (var Latlng in User['latlng'])
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('$Latlng', style: const TextStyle(fontSize: 17)),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),

                              const SizedBox(height: 10,),
                              Text('Landlocked: ${User['landlocked']}', style: const TextStyle(fontSize: 20),),

                              const SizedBox(height: 10,),
                              const Text('Borders :', style: TextStyle(fontSize: 20),),
                              if (User.containsKey('borders'))
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    width: w,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        for (var Borders in User['borders'])
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('$Borders', style: const TextStyle(fontSize: 17)),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),

                              const SizedBox(height: 10,),
                              Text('Area: ${User['area']}', style: const TextStyle(fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      ctx: context,
                      child: const IndependentCountriesAPI(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.green.shade900,borderRadius: BorderRadius.circular(8)),
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Next API',style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
