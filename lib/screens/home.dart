// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:storage___sq_lite__database__listview__search_and_filtering/helpers/dbhelper.dart';
import 'package:storage___sq_lite__database__listview__search_and_filtering/models/course.dart';
import 'package:storage___sq_lite__database__listview__search_and_filtering/screens/coursedetails.dart';
import 'package:storage___sq_lite__database__listview__search_and_filtering/screens/courseupdate.dart';
import 'package:storage___sq_lite__database__listview__search_and_filtering/screens/newcourse.dart';

class Home extends StatefulWidget {
  static final ROUTE = '/Home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbHelper? helper;
  TextEditingController teSearch = TextEditingController();
  var allCourses = [];
  var items = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
    helper?.allCourses().then((courses) {
      setState(() {
        allCourses = courses!;
        items = allCourses;
      });
    });
  }

  void filterSearch(String query) async {
    var dummySearchList = allCourses;
    if (query.isNotEmpty) {
      var dummyListData = [];
      dummySearchList.forEach((item) {
        var course = Course.fromMap(item);
        if (course.name!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items = [];
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items = [];
        items = allCourses;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Storage - SQLite Database part 1'),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              bool? result = await Navigator.of(context)
                  .pushNamed(NewCourse.ROUTE) as bool?;

              if (result == true) {
                // Refresh the data after adding a new course
                helper?.allCourses().then((courses) {
                  setState(() {
                    allCourses = courses!;
                    items = allCourses;
                  });
                });
              }
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  filterSearch(value);
                });
              },
              controller: teSearch,
              decoration: InputDecoration(
                hintText: 'Search for Course...',
                labelText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, index) {
                  // made this instead of using below code with snapshot.data[index] each time
                  Course course = Course.fromMap(items[index]);
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      //title: Text('Course Name: ${snapshot.data[index]['name']}'),
                      title: Text(
                        'Course Name: ${course.name} | Duration: ${course.hours}H - level: ${course.level} | Price: ${course.price}',
                      ),
                      subtitle: Text(
                        course.content!.length > 100
                            ? 'Course Content: ${course.content!.substring(0, 100)}...'
                            : 'Course Content: ${course.content}',
                      ),
                      trailing: Column(
                        children: [
                          Expanded(
                            child: IconButton(
                              onPressed: () async {
                                await helper?.delete(course.id);
                                setState(() {
                                  // Fetch all courses again to refresh the list after deletion
                                  helper?.allCourses().then((courses) {
                                    setState(() {
                                      allCourses = courses!;
                                      items = allCourses;
                                    });
                                  });
                                });
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red[300],
                              ),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              onPressed: () async {
                                // Navigate to the update screen and await the result
                                bool? result =
                                    await Navigator.of(context).pushNamed(
                                  CourseUpdate.ROUTE,
                                  arguments: course,
                                ) as bool?;

                                if (result == true) {
                                  setState(() {
                                    // Fetch all courses again to refresh the list after updating
                                    helper?.allCourses().then((courses) {
                                      setState(() {
                                        allCourses = courses!;
                                        items = allCourses;
                                      });
                                    });
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.green[300],
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(CourseDetails.ROUTE, arguments: course);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      //below code was for last video, which we was getting data from database, so we used FutureBuilder,
      //nw since we will get it direct from items array"which is getting from data base", we no longer,
      // need for future, because search function with items array is doing this async task on DB...
      /* FutureBuilder(
        future: helper?.allCourses(), // Move future inside FutureBuilder
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator()); // Center the loader
          } else if (snapshot.data.isEmpty) {
            return Center(child: Text('No courses available.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                // made this instead of using below code with snapshot.data[index] each time
                Course course = Course.fromMap(snapshot.data[index]);
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    //title: Text('Course Name: ${snapshot.data[index]['name']}'),
                    title: Text(
                      'Course Name: ${course.name} | Duration: ${course.hours}H - level: ${course.level} | Price: ${course.price}',
                    ),
                    subtitle: Text(
                      course.content!.length > 100
                          ? 'Course Content: ${course.content!.substring(0, 100)}...'
                          : 'Course Content: ${course.content}',
                    ),
                    trailing: Column(
                      children: [
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                helper?.delete(course.id);
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red[300],
                            ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () async {
                              // Navigate to the update screen and await the result
                              bool? result =
                                  await Navigator.of(context).pushNamed(
                                CourseUpdate.ROUTE,
                                arguments: course,
                              ) as bool?;

                              // If an update was made (optional result handling)
                              if (result == true) {
                                setState(
                                    () {}); // Refresh UI after returning from the update screen
                              }
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.green[300],
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(CourseDetails.ROUTE, arguments: course);
                    },
                  ),
                );
              },
            );
          }
        },
      ), */
    );
  }
}
