// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:storage___sq_lite__database__listview__search_and_filtering/helpers/dbhelper.dart';

import '../models/course.dart';

class NewCourse extends StatefulWidget {
  static final ROUTE = '/NewCourse';

  @override
  State<NewCourse> createState() => _NewCourseState();
}

class _NewCourseState extends State<NewCourse> {
  String? name, content, level;
  int? hours, price;
  DbHelper? helper;

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Course'),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Course Name',
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Enter Course Content',
                ),
                onChanged: (value) {
                  setState(() {
                    content = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Course Duration in H',
                ),
                onChanged: (value) {
                  setState(() {
                    hours = int.parse(value);
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Course Price in Integer',
                ),
                onChanged: (value) {
                  setState(() {
                    price = int.parse(value);
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Course Level',
                ),
                onChanged: (value) {
                  setState(() {
                    level = value;
                  });
                },
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () async {
                  Course course = Course({
                    'name': name,
                    'content': content,
                    'hours': hours,
                    'level': level,
                    'price': price,
                  });
                  int? id = await helper?.createCourse(course);
                  showSnackBar(id);
                  Navigator.of(context).pop(true);
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(int? id) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Successfully added New Course, COURSE ID: $id')));
  }
}
