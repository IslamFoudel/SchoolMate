// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:storage___sq_lite__database__listview__search_and_filtering/models/course.dart';

class CourseDetails extends StatelessWidget {
  static final ROUTE = '/CourseDetails';
  Course course;
  CourseDetails(this.course);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Text(
              'Course: ${course.name}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Content: ${course.content}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Level: ${course.level}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Duration: ${course.hours.toString()}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Price: ${course.price.toString()}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
