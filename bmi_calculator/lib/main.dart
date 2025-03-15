import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  double height = 140;
  int weight = 60;
  int age = 25;
  String gender = '';
  @override
  void calculateBmi() {
    double bmi = weight / ((height / 100) * (height / 100));
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                ResultScreen(bmi: bmi, category: category, message: message),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Center(child: Text("BMI CACULATOR")),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      gender = "male";
                      print("btn is pressed $gender");
                    },
                    child: Container(
                      height: 140,
                      color: Colors.grey[800],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.male, size: 40),
                          Text("Male", style: TextStyle(fontSize: 21)),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      gender = "female";
                      print("btn is pressed $gender");
                    },
                    child: Container(
                      height: 140,
                      color: Colors.grey[800],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.female, size: 40),
                          Text("Female", style: TextStyle(fontSize: 21)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      padding: EdgeInsets.all(5),
                      color: Colors.grey[800],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "HEIGHT",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            "${height.toInt()} cm",
                            style: TextStyle(fontSize: 21),
                          ),
                          Slider(
                            value: height,
                            min: 100,
                            max: 220,
                            inactiveColor: Colors.blue[200],
                            activeColor: Colors.red,
                            onChanged: (value) {
                              setState(() {
                                height = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  height: 120,
                  color: Colors.grey[800],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("WEIGHT", style: TextStyle(fontSize: 16)),
                      Text("$weight", style: TextStyle(fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 45,
                            height: 45,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21),
                              color: Colors.grey[600],
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (weight > 1) weight--;
                                });
                              },
                              icon: Icon(Icons.remove),
                            ),
                          ),

                          Container(
                            width: 45,
                            height: 45,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21),
                              color: Colors.grey[600],
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                              icon: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 150,
                  height: 120,
                  color: Colors.grey[800],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("age", style: TextStyle(fontSize: 16)),
                      Text("$age", style: TextStyle(fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 45,
                            height: 45,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21),
                              color: Colors.grey[600],
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (age > 1) age--;
                                });
                              },
                              icon: Icon(Icons.remove),
                            ),
                          ),

                          Container(
                            width: 45,
                            height: 45,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21),
                              color: Colors.grey[600],
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                              icon: Icon(Icons.add),
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
        color: Colors.red,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          onPressed: () {
            calculateBmi();
          },
          child: Text(
            "CALCULATE",
            style: TextStyle(fontSize: 22, color: Colors.white),
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

  ResultScreen({
    super.key,
    required this.bmi,
    required this.category,
    required this.message,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Result")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          color: Colors.grey[900],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                category,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                bmi.toStringAsFixed(1),
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    message,
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.red,
        // shape: CircularNotchedRectangle(),
        child: SizedBox(
          height: 15,
          child: InkWell(
            onTap: () => {Navigator.pop(context)},
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
