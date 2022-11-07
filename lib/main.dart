import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Demo list and grid'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> courses = [
    "choux",
    "patates",
    "vin",
    "pommes",
    "boeuf",
    "citron",
    "riz",
    "huile",
    "vinaigre",
    "moutarde",
    "sel",
    "piments",
    "curry",
    "salade",
    "oignons",
    "farine",
    "beurre",
    "echalottes",
    "poivre",
    "lait",
    "creme"
  ];

  List<Course> maListeCourse = [];

  List<Widget> itemCourses() {
    List<Widget> items = [];
    for (var element in courses) {
      final widget = elementToShow(element);
      items.add(widget);
    }

    return items;
  }

  Widget elementToShow(String element) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(element), const Icon(Icons.check_box_outline_blank)]),
    );
  }

  @override
  Widget build(BuildContext context) {
    for (var element in courses) {
      maListeCourse.add(Course(element));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.separated(
            itemBuilder: (BuildContext context, index) {
              return Dismissible(
                key: Key(maListeCourse[index].element),
                child: tile(index),
                onDismissed: (direction) {
                  setState(() {
                    maListeCourse.removeAt(index);
                  });
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemCount: maListeCourse.length)
        // ListView.builder(
        //     itemCount: courses.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       var element = courses[index];
        //       return elementToShow(element);
        //     })
        );
  }

  ListTile tile(int index) {
    return ListTile(
      title: Text(maListeCourse[index].element),
      leading: Text(index.toString()),
      trailing: Icon((maListeCourse[index].bought)
          ? Icons.check_box
          : Icons.check_box_outline_blank),
      onTap: () {
        print("tap on element $index : ${courses[index]}");
        setState(() {
          maListeCourse[index].update();
        });
      },
    );
  }
}

class Course {
  String element;
  bool bought = false;
  Course(this.element);
  update() {
    bought = !bought;
  }
}
