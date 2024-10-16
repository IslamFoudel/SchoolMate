import 'package:flutter/material.dart';
import 'package:storage___sq_lite__database__listview__search_and_filtering/models/course.dart';
import 'package:storage___sq_lite__database__listview__search_and_filtering/screens/coursedetails.dart';
import 'package:storage___sq_lite__database__listview__search_and_filtering/screens/courseupdate.dart';
import 'package:storage___sq_lite__database__listview__search_and_filtering/screens/home.dart';
import 'package:storage___sq_lite__database__listview__search_and_filtering/screens/newcourse.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Home.ROUTE,
      routes: {
        Home.ROUTE: (_) => Home(),
        NewCourse.ROUTE: (_) => NewCourse(),
        // CourseDetails.ROUTE: (_) => CourseDetails(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == CourseDetails.ROUTE) {
          final Course course = settings.arguments as Course;
          return MaterialPageRoute(
            builder: (context) {
              return CourseDetails(course);
            },
          );
        } else if (settings.name == CourseUpdate.ROUTE) {
          final Course course = settings.arguments as Course;
          return MaterialPageRoute(
            builder: (context) {
              return CourseUpdate(course);
            },
          );
        }
        // Handle unknown routes here, if necessary.
        return null;
      },
    );
  }
}
