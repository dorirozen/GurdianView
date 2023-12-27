import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guardian_view/context_extensions.dart';

class HomePage1 extends StatefulWidget {
  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  @override
  Widget build(BuildContext context) {
    bool isDarwer = MediaQuery.of(context).size.width > 600;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              child: Text('Go to Notifications',
                  style: TextStyle(fontSize: 12.0.sp)),
              onPressed: () {
                context.push(NotificationPage());
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            'h : ${h.toString()}',
            style: TextStyle(fontSize: 24.0.sp),
          )),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text('w : ${w.toString()}',
                style: TextStyle(fontSize: 12.0.sp)),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            isDarwer.toString(),
            style: TextStyle(fontSize: 12.0),
          )),
        ],
      ),
    );
  }
}

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Page'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              child: Text('Go to NotificationPage1'),
              onPressed: () {
                context.push(NotificationPage1());
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text('Return'),
              onPressed: () {
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification1 Page'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              child: Text('return to home'),
              onPressed: () {
                context.popToRoot();
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text('Return'),
              onPressed: () {
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
