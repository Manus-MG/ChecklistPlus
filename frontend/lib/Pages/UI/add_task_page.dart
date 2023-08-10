import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:frontend/Pages/UI/widget/button.dart';
import 'package:frontend/Pages/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:frontend/Pages/UI/home_page.dart';
import 'package:frontend/Pages/UI/theme.dart';
import 'package:frontend/Pages//UI/widget/input_field.dart';
import 'package:frontend/Pages//UI/widget/input_field_with_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/api.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController? title = TextEditingController();
  TextEditingController? desc = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(hours: 2)))
      .toString();

  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = "None";
  List<String> repeatList = [
    "None",
    "Daily",
    "Weekly",
    "Yearly",
  ];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: context.theme.backgroundColor,
      // appBar: _appBar(context),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => navbar()));},
        icon: Icon(
            CupertinoIcons.back,
            color: Colors.white,
          )
        )
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Add Task",
                style: headingStyle,
              ),
              MyInputField(
                  title: "Title", hint: "Enter your title", controller: title),

              MyInputField(
                  title: "Note", hint: "Enter your note", controller: desc),
              MyInputFieldWithWidget(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(Icons.calendar_today_outlined),
                  onPressed: () {
                    debugPrint("Calendar Button pressed");
                    _getDateFromUser();
                  },
                ),
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: MyInputFieldWithWidget(
              //         title: "Start Time",
              //         hint: _startTime,
              //         widget: IconButton(
              //           icon: const Icon(
              //             Icons.access_time_rounded,
              //             color: Colors.grey,
              //           ),
              //           onPressed: () {
              //             debugPrint("Star Time pressed");
              //             _getTimeFromUser(isStartTime: true);
              //           },
              //         ),
              //       ),
              //     ),
              //     const SizedBox(width: 12),
              //     Expanded(
              //       child: MyInputFieldWithWidget(
              //         title: "End Time",
              //         hint: _endTime,
              //         widget: IconButton(
              //           icon: const Icon(
              //             Icons.access_time_rounded,
              //             color: Colors.grey,
              //           ),
              //           onPressed: () {
              //             debugPrint("End Time pressed");
              //             _getTimeFromUser(isStartTime: false);
              //           },
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // MyInputFieldWithWidget(
              //   title: "Remind",
              //   hint: "$_selectedRemind minutes early",
              //   widget: DropdownButton(
              //       icon: const Icon(
              //         Icons.keyboard_arrow_down,
              //         color: Colors.grey,
              //       ),
              //       iconSize: 32,
              //       underline: Container(
              //         height: 0,
              //       ),
              //       onChanged: (String? newValue) {
              //         setState(() {
              //           _selectedRemind = int.parse(newValue!);
              //         });
              //       },
              //       elevation: 4,
              //       style: subTitleStyle,
              //       items:
              //           remindList.map<DropdownMenuItem<String>>((int value) {
              //         return DropdownMenuItem<String>(
              //           value: value.toString(),
              //           child: Text(value.toString()),
              //         );
              //       }).toList()),
              // ),
              // MyInputFieldWithWidget(
              //   title: "Repeat",
              //   hint: "$_selectedRepeat",
              //   widget: DropdownButton(
              //       icon: const Icon(
              //         Icons.keyboard_arrow_down,
              //         color: Colors.grey,
              //       ),
              //       iconSize: 32,
              //       underline: Container(
              //         height: 0,
              //       ),
              //       onChanged: (String? newValue) {
              //         setState(() {
              //           _selectedRepeat = newValue!;
              //         });
              //       },
              //       elevation: 4,
              //       style: subTitleStyle,
              //       items: repeatList
              //           .map<DropdownMenuItem<String>>((String value) {
              //         return DropdownMenuItem<String>(
              //           value: value.toString(),
              //           child: Text(value),
              //         );
              //       }).toList()),
              // ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyButton(
                        onTap: () {
                          _postData(title: title!.text, desc: desc!.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => navbar()));
                        },
                        label: "Add",
                        // child: Text("Add"),
                      ),
                      // Text("Color", style: titleStyle),
                      // const SizedBox(
                      //   height: 4,
                      // ),
                      // Wrap(
                      //   children: List<Widget>.generate(
                      //     3,
                      //         (int index) {
                      //       return GestureDetector(
                      //         onTap: () {
                      //           setState(() {
                      //             _selectedColor = index;
                      //             debugPrint("Index : $_selectedColor");
                      //           });
                      //         },
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(4.0),
                      //           child: CircleAvatar(
                      //               child: _selectedColor == index
                      //                   ? const Icon(
                      //                 Icons.done,
                      //                 color: Colors.white,
                      //                 size: 16,
                      //               )
                      //                   : Container(),
                      //               radius: 14,
                      //               backgroundColor: index == 0
                      //                   ? primaryClr
                      //                   : index == 1
                      //                   ? pinkClr
                      //                   : yellowClr
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _postData(
      {String title = "", String desc = "", String email = ""}) async {
    final prefs = await SharedPreferences.getInstance();
    final userEmail = prefs.getString('user_email');
    // print("User ki email hai jo bheji jaa rahi hai filter ke liye : $userEmail");
    try {
      http.Response response = await http.post(
        Uri.parse(api),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "title": title,
          "desc": desc,
          "isDone": false,
          "email": userEmail
        }),
      );
      if (response.statusCode == 201) {
        // setState(() {
        //   tasks = [];
        // });
        // fetchData();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => navbar(),
          ),
        );
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print("Error is $e");
    }
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0, // pembatas antara appbar dan main screen
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/profile.jpg"),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2040),
    );

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    } else {
      debugPrint("It is null or something is wrong!");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var _pickedTime = await _showTimePicker(isStartTime: isStartTime);
    //String _formatedTime = _pickedTime.format(context);
    String _formatedTime = _pickedTime.format(context);

    if (_pickedTime == null) {
      debugPrint("Time canceled");
    } else if (isStartTime) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (!isStartTime) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker({required bool isStartTime}) {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: isStartTime
          ? TimeOfDay(
              hour: int.parse(_startTime.split(":")[0]),
              minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
            )
          : TimeOfDay(
              hour: int.parse(_endTime.split(":")[0]),
              minute: int.parse(_endTime.split(":")[1].split(" ")[0]),
            ),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
  }
}
