// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:storage___sq_lite__database__listview__search_and_filtering/helpers/dbhelper.dart';
import 'package:storage___sq_lite__database__listview__search_and_filtering/models/course.dart';

class CourseUpdate extends StatefulWidget {
  static final ROUTE = '/CourseUpdate';
  Course course;
  CourseUpdate(this.course);

  @override
  State<CourseUpdate> createState() => _CourseUpdateState();
}

class _CourseUpdateState extends State<CourseUpdate> {
  TextEditingController teName = TextEditingController();
  TextEditingController teContent = TextEditingController();
  TextEditingController teHours = TextEditingController();
  TextEditingController teLevel = TextEditingController();
  TextEditingController tePrice = TextEditingController();
  DbHelper? helper;
  @override
  void initState() {
    super.initState();
    helper = DbHelper();
    teName.text = widget.course.name!;
    teContent.text = widget.course.content!;
    teHours.text = widget.course.hours.toString();
    teLevel.text = widget.course.level!;
    tePrice.text = widget.course.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: teName,
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              maxLines: null,
              controller: teContent,
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: teHours,
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: teLevel,
            ),
            TextField(
              controller: tePrice,
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                var updatedCourse = Course({
                  'id': widget.course.id,
                  'name': teName.text,
                  'content': teContent.text,
                  'hours': int.parse(teHours.text),
                  'level': teLevel.text,
                  'price': int.parse(tePrice.text),
                });
                helper?.courseUpdate(updatedCourse);
                Navigator.of(context).pop(true);
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
