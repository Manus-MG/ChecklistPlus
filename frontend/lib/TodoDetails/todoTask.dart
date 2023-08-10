import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:frontend/Pages/UI/services/graph.dart';
import 'package:frontend/Pages/UI/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/TodoDetails/Task.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/api.dart';
import '../Pages/navbar.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<Task> tasks = [];
  List<Task> Undone = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
    fetchTasksNotDone();
  }

  Future<void> fetchTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final userEmail = prefs.getString('user_email');
    final url = Uri.parse('${api}?email=${userEmail}&isDone=false');
    // final url = Uri.parse('http://192.168.29.131:8000/?email=admin@gmail.com');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Task> fetchedTasks = List<Task>.from(data.map((task) => Task(
            id: task['id'],
            title: task['title'],
            desc: task['desc'],
            isDone: task['isDone'],
            email: globalemail)));
        setState(() {
          tasks = fetchedTasks;
        });
        lengthdone = tasks.length;
        fetchTasksNotDone();
        // print('incomplete ki length $lengthincomp');
        // print('completed length $lengthdone');
      } else {
        print('Failed to fetch tasks: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  Future<void> fetchTasksNotDone() async {
    final prefs = await SharedPreferences.getInstance();
    final userEmail = prefs.getString('user_email');
    final url = Uri.parse('${api}?email=${userEmail}&isDone=true');
    // final url = Uri.parse('http://192.168.29.131:8000/?email=admin@gmail.com');
    // Replace 'your-django-api-endpoint' with the actual API endpoint URL to fetch tasks.

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Task> fetchedTasksNot = List<Task>.from(data.map((task) => Task(
            id: task['id'],
            title: task['title'],
            desc: task['desc'],
            isDone: task['isDone'],
            email: globalemail)));
        setState(() {
        Undone = fetchedTasksNot;
        });
        lengthincomp = Undone.length;
      } else {
        print('Failed to fetch tasks: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  Future<void> _showOptionsModal(BuildContext context, Task task) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(top: 4),
          height: MediaQuery.of(context).size.height * 0.32,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[600]),
              ),
              // SizedBox(
              //   height: 15,
              // ),
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                height: 55,
                width: MediaQuery.of(context).size.width * 0.9,
                // color: Colors.green,
                decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(200)),
                child: ListTile(
                  title: Center(child: Text('Task Completed')),
                  onTap: () {
                    // Implement task completion logic here
                    // delete_todo(task.id.toString());
                    update_todo(task.id.toString(), task.title, task.desc);
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                height: 55,
                width: MediaQuery.of(context).size.width * 0.9,
                // color: Colors.green,
                decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(200)),
                child: ListTile(
                  title: Center(
                      child: Text(
                    'Delete Task',
                    style: titleStyle.copyWith(color: Colors.black),
                  )),
                  onTap: () {
                    // Implement task deletion logic here
                    delete_todo(task.id.toString());
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                height: 55,
                width: MediaQuery.of(context).size.width * 0.9,
                // color: Colors.green,
                decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(200)),
                child: ListTile(
                  title: Center(
                      child: Text(
                    'Close',
                    style: titleStyle.copyWith(color: Colors.black),
                  )),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var rnd = Random();
    return Scaffold(
      // appBar: AppBar(title: Text('Task List')),

      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                     curve: Curves.easeIn,
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => _showOptionsModal(context, tasks[index]),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(bottom: 12),
                                child: Container(
                                  // width: ,
                                  // height: 50,
                                  // margin: EdgeInsets.only(bottom: 10),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(16),
                                      color: getlistcol(rnd.nextInt(3))),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              tasks[index].title,
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 19,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            // Row(
                                            //   crossAxisAlignment: CrossAxisAlignment.center,
                                            //   children: [],
                                            // ),
                                            Text(tasks[index].desc,
                                                style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            CupertinoColors.black)))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 10),
                                        height: 60,
                                        width: 0.5,
                                        color: Colors.grey[200]!.withOpacity(0.7),
                                      ),
                                      RotatedBox(
                                        quarterTurns: 3,
                                        child: Text('TODO',
                                         // tasks[index].isDone==false? 'TODO':'COMPLETED',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                );
              },
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: Undone.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => _showOptionsModal(context, Undone[index]),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(bottom: 12),
                                child: Container(
                                  // width: ,
                                  // height: 50,
                                  // margin: EdgeInsets.only(bottom: 10),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.greenAccent),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              Undone[index].title,
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 19,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            // Row(
                                            //   crossAxisAlignment: CrossAxisAlignment.center,
                                            //   children: [],
                                            // ),
                                            Text(Undone[index].desc,
                                                style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                        CupertinoColors.black)))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 10),
                                        height: 60,
                                        width: 0.5,
                                        color: Colors.grey[200]!.withOpacity(0.7),
                                      ),
                                      RotatedBox(
                                        quarterTurns: 3,
                                        child: Text('COMPLETED',
                                          // tasks[index].isDone==false? 'TODO':'COMPLETED',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              },
            )
          ],
        ),
      ),
      // bottomNavigationBar: navbar(),
    );
  }

  void delete_todo(String id) async {
    try {
      http.Response response = await http.delete(Uri.parse(api + id));
      setState(() {
        tasks = [];
        Undone=[];
      });
      fetchTasks();
      fetchTasksNotDone();
    } catch (e) {
      print(e);
    }
  }

  void update_todo(String id, String title, String desc) async {
    // final url = Uri.parse('${api}${id}');
    try {
      http.Response response = await http.put(
        Uri.parse('${api}${id}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "title": title.toString(),
          "desc": desc.toString(),
          "isDone": true,
          // "email":globalemail.toString()
          // "email": globalemail,
        }),
      );
      fetchTasks();
      fetchTasksNotDone();
      // print('${api}${id}');
      // print('response of put request ${response.body}');
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  getlistcol(int no) {
    switch (no) {
      case 0:
        return pinkClr;
      case 1:
        return CupertinoColors.systemMint;
      case 2:
        return yellowClr;
      default:
        return bluishClr;
    }
  }
}
