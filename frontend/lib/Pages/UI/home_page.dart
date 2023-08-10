import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Pages/UI/services/notification_service.dart';
import 'package:frontend/Pages/UI/services/theme_service.dart';
import 'package:frontend/Pages/UI/add_task_page.dart';
import 'package:frontend/Pages/UI/theme.dart';
import 'package:frontend/Pages/UI/widget/button.dart';
import 'package:frontend/TodoDetails/todoTask.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;
  @override
  void initState() {
    super.initState();
    TaskListPage();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    // notifyHelper.displayNotification();
    // notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: _appBar(),
        body: Column(
          children: [
            // _appBar(),
            _addTaskBar(),
            _addDateBar(),
            SizedBox(
              height: 15,
            ),
            Expanded(child: TaskListPage()),
            // Expanded(child: navbar())
            // navbar()
          ],
        ),
        // bottomNavigationBar: navbar(),
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  "Today",
                  style: headingStyle,
                ),
              ],
            ),
          ),
          MyButton(
              label: "+ Add Task", onTap: () => Get.to(() => AddTaskPage())),
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        onDateChange: (date) {
          _selectedDate = date;
        },
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title: "Theme Changed",
            body:
            Get.isDarkMode ? "Activated LightTheme" : "Activated DarkTheme",
          );
          // notifyHelper.scheduledNotification();
        },
        child: Icon(
          Get.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny_outlined,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        Icon(
          CupertinoIcons.profile_circled,
          // CircleAvatar(
          //   backgroundImage: AssetImage("images/profile.png"),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
