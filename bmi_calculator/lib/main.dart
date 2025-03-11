import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'BMI CALCULATOR'),
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
  double _height = 150;
  int _weight = 60;
  int _age = 25;

  void _calculateBMI() {
    double bmi = _weight / ((_height / 100) * (_height / 100));
    String category;
    String message;

    if (bmi > 25.0) {
      category = "Overweight";
      message =
          "You have a higher than normal body weight. Try to exercise more!";
    } else if (bmi > 18.5) {
      category = "Normal";
      message = "You have a normal body weight. Good job!";
    } else {
      category = "Underweight";
      message =
          "You have a lower than normal body weight. You can eat a bit more!";
    }

    // Navigate to Result Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                ResultScreen(bmi: bmi, category: category, message: message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(widget.title)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  height: 130,
                  color: Colors.blueGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.male,
                        size: 40,
                        color: Colors.white,
                      ), // Male Icon
                      const SizedBox(height: 8),
                      const Text(
                        "Male",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  height: 130,
                  color: Colors.blueGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.female,
                        size: 40,
                        color: Colors.white,
                      ), // Female Icon
                      const SizedBox(height: 8),
                      const Text(
                        "Female",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    "HEIGHT",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${_height.toInt()} cm",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Slider(
                    value: _height,
                    min: 100,
                    max: 220,
                    onChanged: (value) {
                      setState(() {
                        _height = value; // Update height dynamically
                      });
                    },
                    activeColor: Colors.red,
                    inactiveColor: Colors.white24,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  height: 130,
                  color: Colors.blueGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("WEIGHT"),
                      Text("$_weight", style: TextStyle(fontSize: 21)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.grey, // Background color
                              shape: BoxShape.circle, // Circular shape
                            ),
                            child: FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  if (_weight > 1) _weight--;
                                });
                              },
                              child: Icon(Icons.remove),
                            ),
                          ),
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.grey, // Background color
                              shape: BoxShape.circle, // Circular shape
                            ),
                            child: FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  _weight++;
                                });
                              },
                              child: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 150,
                  height: 130,
                  color: Colors.blueGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Age"),
                      Text("$_age", style: TextStyle(fontSize: 21)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            child: FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  if (_age > 1) _age--;
                                });
                              },
                              child: Icon(Icons.remove),
                            ),
                          ),
                          Container(
                            width: 45,
                            height: 45,
                            child: FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  _age++;
                                });
                              },
                              child: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 228, 23, 9), // Red background
        child: SizedBox(
          height: 60, // Ensures button takes full height
          width: double.infinity, // Ensures button takes full width
          child: ElevatedButton(
            onPressed: () {
              _calculateBMI();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              padding: EdgeInsets.zero,
            ),
            child: const Text("CALCULATE", style: TextStyle(fontSize: 21)),
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final double bmi;
  final String category;
  final String message;

  const ResultScreen({
    super.key,
    required this.bmi,
    required this.category,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Result")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // BMI Category
            Text(
              category.toUpperCase(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 25),

            // BMI Value
            Text(
              bmi.toStringAsFixed(1),
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 45),

            // Message
            Text(
              message,
              style: TextStyle(fontSize: 18, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),

      // Bottom Navigation for "RE-CALCULATE"
      bottomNavigationBar: BottomAppBar(
        color: Colors.red,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 20,
          child: InkWell(
            onTap: () {
              Navigator.pop(context); // Go back
            },
            child: Center(
              child: Text(
                "RE-CALCULATE",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
