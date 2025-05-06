import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
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
      home: const MyHomePage(title: 'Tasbihaa'),
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

  // String value = "";
  // setMyData() async {
  //   prefs!.setString('MyName', 'Abdelrahman Badawi');
  // }

  // getData() {
  //   String myName = prefs!.getString('MyName') ?? 'No Data is set yet';
  //   value = myName;
  //   setState(() {});
  // }

  void _incrementCounter() {
    setState(() {
      _counter++;
      prefs!.setInt('counter', _counter);
    });
  }

  getInitialCounter() async {
    setState(() {
      _counter = prefs!.getInt('counter') ?? 0;
    });
  }

  @override
  void initState() {
    //setMyData();
    getInitialCounter();
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
            const SizedBox(
              width: 300,
              child: Text(
                'سبحان الله و الحمد لله و لا إله إلا الله',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3))
                  ]),
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: _incrementCounter,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    fixedSize: const Size(250, 50)),
                child: const Icon(
                  Icons.add,
                  size: 40,
                )),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter = 0;
                  prefs!.setInt('counter', _counter);
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.withOpacity(0.3),
                  foregroundColor: Colors.white,
                  fixedSize: const Size(250, 50)),
              child: const Icon(
                Icons.exposure_zero,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
