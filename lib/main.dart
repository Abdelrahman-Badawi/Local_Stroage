import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:local_storage/db_helper.dart';
import 'package:local_storage/task_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DbHelper dbHelper = DbHelper();
  TaskModel taskModel1 = TaskModel(
    title: "task 1",
    isCompleted: false,
    date: "2025-05-7",
  );

  TaskModel taskModel2 = TaskModel(
    title: "task 2",
    isCompleted: false,
    date: "2025-05-7",
  );
  TaskModel taskModel3 = TaskModel(
    title: "task 3",
    isCompleted: false,
    date: "2025-05-7",
  );
  dbHelper.insertTask(taskModel1);
  dbHelper.insertTask(taskModel2);
  dbHelper.insertTask(taskModel3);
  List<TaskModel> tasks = await dbHelper.getTasks();

  tasks.forEach((oneTask) {
    log(oneTask.toMap().toString());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  String name = "";

  // saveUserName() {
  //   storage.write(key: 'username', value: 'Abdelrahman Badawi');
  // }

  // getUserName() async {
  //   name = await storage.read(key: 'username') ?? 'No name is saved right now';
  //   setState(() {});
  // }

  // saveCounterToLoacalStorage() {
  //   storage.write(key: 'counter', value: _counter.toString());
  // }

  // getCounterValue() async {
  //   String value = await storage.read(key: 'counter') ?? "0";
  //   _counter = int.parse(value);
  //   setState(() {});
  // }

  void _incrementCounter() {
    setState(() {
      _counter++;
      //saveCounterToLoacalStorage();
    });
  }

  @override
  void initState() {
    // saveUserName();
    // getUserName();
    // getCounterValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              name,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
