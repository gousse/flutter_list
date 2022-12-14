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
      home: const MyHomePage(title: 'Demo grid'),
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
  @override
  initState() {
    super.initState();

    maListeCourse = listeCourses();
  }

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
  List<Course> listeCourses() {
    List<Course> c = [];
    for (var elment in courses) {
      c.add(Course(elment));
    }
    return c;
  }

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
    final orientation = MediaQuery.of(context).orientation;
    print(orientation);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: (orientation == Orientation.portrait) ? listSeparated() : grid());
  }

  listSeparated() {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(maListeCourse[index].element),
            onDismissed: (direction) {
              setState(() {
                maListeCourse.removeAt(index);
              });
            },
            background: Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [Spacer(), Text("Swipe to delete")],
              ),
              color: Colors.redAccent,
            ),
            child: tile(index),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.indigoAccent,
            thickness: 1,
          );
        },
        itemCount: maListeCourse.length);
  }

  simpleList() {
    return ListView.builder(itemBuilder: (context, index) {
      final element = courses[index];
      return elementToShow(element);
    });
  }

  grid() {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Card(
                color: maListeCourse[index].bought
                    ? Colors.lightGreen
                    : Colors.blue,
                child: Center(child: Text(maListeCourse[index].element))),
            onTap: () {
              setState(() {
                maListeCourse[index].update();
              });
            },
          );
        },
        itemCount: maListeCourse.length);
  }

  ListTile tile(int index) {
    return ListTile(
      title: Text(maListeCourse[index].element),
      leading: Text(index.toString()),
      trailing: Icon((maListeCourse[index].bought)
          ? Icons.check_box
          : Icons.check_box_outline_blank),
      onTap: () {
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
