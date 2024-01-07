// ignore_for_file: non_constant_identifier_names

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'RestCountriesAPI.dart';

List<Map<String,dynamic>> Data1 = [
  {'group_id': 1, 'group_title': 'Program Task', 'task_id': 8,  'task_title': 'test'},
  {'group_id': 2, 'group_title': 'Health',       'task_id': 9,  'task_title': 'hello fitness'},
  {'group_id': 2, 'group_title': 'Health',       'task_id': 11, 'task_title': 'go to gym'},
  {'group_id': 2, 'group_title': 'Health',       'task_id': 13, 'task_title': 'body level'}
];

class List1 extends StatefulWidget {
  const List1({super.key});

  @override
  State<List1> createState() => _List1State();
}

class _List1State extends State<List1> {

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.green,
          appBar: AppBar(
            backgroundColor: Colors.green.shade900,
            title: const Text('Local Data In List 1',style: TextStyle(fontWeight: FontWeight.bold),),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    for(var Data in Data1)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          width: w,
                          decoration: BoxDecoration(color: Colors.white24,borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Group Id : ${Data['group_id']}',style: const TextStyle(fontSize: 20),),
                                Text('Group Title : ${Data['group_title']}',style: const TextStyle(fontSize: 20),),
                                Text('Task Id : ${Data['task_id']}',style: const TextStyle(fontSize: 20),),
                                Text('Task Title : ${Data['task_title']}',style: const TextStyle(fontSize: 20),),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
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
                            child: const List2()
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
          )
        )
    );
  }
}



List<Map<String,dynamic>> Data2 = [
  {
    "group_id": 1,
    "group_title": "Program Task",
    "task": [
      {
        "task_id": 8,
        "task_title": "test"
      }
    ]
  },
  {
    "group_id": 2,
    "group_title": "Health",
    "task": [
      {
        "task_id": 9,
        "task_title": "hello fitness"
      },
      {
        "task_id": 11,
        "task_title": "go to gym"
      },
      {
        "task_id": 13,
        "task_title": "body level"
      }
    ]
  }
];


class List2 extends StatefulWidget {
  const List2({super.key});

  @override
  State<List2> createState() => _List2State();
}

class _List2State extends State<List2> {

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.green,
          appBar: AppBar(
            backgroundColor: Colors.green.shade900,
            title: const Text('Local Data In List 2',style: TextStyle(fontWeight: FontWeight.bold),),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      for(var Data in Data2)
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            width: w,
                            decoration: BoxDecoration(color: Colors.white24,borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text('Group Id : ${Data['group_id']}',style: const TextStyle(fontSize: 20),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text('Group Title : ${Data['group_title']}',style: const TextStyle(fontSize: 20),),
                                ),
                                const SizedBox(height: 10,),
                                for(var Task in Data['task'] as List<Map<String,dynamic>>)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
                                    child: Container(
                                      width: w,
                                      decoration: BoxDecoration(color: Colors.white24,borderRadius: BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Task Id : ${Task['task_id']}',style: const TextStyle(fontSize: 20),),
                                            Text('Task Title : ${Task['task_title']}',style: const TextStyle(fontSize: 20),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 15,)
                              ],
                            ),
                          ),
                        ),
                    ],
                  )
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
                            child: const RestCountriesAPI(),
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
        )
    );
  }
}

