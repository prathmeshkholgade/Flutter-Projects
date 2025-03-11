import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Todo App'),
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
  TextEditingController _taskController = TextEditingController();
  TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> tasks = [];
  List<Map<String, dynamic>> filteredTasks = [];

  bool showInputField = false;
  bool showSearchField = false;

  @override
  void initState() {
    super.initState();
    filteredTasks = List.from(tasks);
  }

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        tasks.add({"text": _taskController.text, "completed": false});
        _taskController.clear();
        showInputField = false;
        _filterTasks("");
      });
    }
  }

  void _toggleTask(int index) {
    setState(() {
      tasks[index]["completed"] = !tasks[index]["completed"];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
      _filterTasks("");
    });
  }

  void _filterTasks(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredTasks = List.from(tasks);
      } else {
        filteredTasks =
            tasks
                .where(
                  (task) =>
                      task["text"].toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          if (showInputField)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _taskController,
                      decoration: InputDecoration(
                        hintText: "Enter Task",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.check, color: Colors.green),
                    onPressed: _addTask,
                  ),
                ],
              ),
            ),
          if (showSearchField)
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search Tasks...",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: _filterTasks,
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Checkbox(
                      value: filteredTasks[index]["completed"],
                      onChanged: (bool? value) {
                        _toggleTask(tasks.indexOf(filteredTasks[index]));
                      },
                    ),
                    title: Text(
                      filteredTasks[index]["text"],
                      style: TextStyle(
                        decoration:
                            filteredTasks[index]["completed"]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                        color:
                            filteredTasks[index]["completed"]
                                ? Colors.grey
                                : Colors.black,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed:
                          () =>
                              _deleteTask(tasks.indexOf(filteredTasks[index])),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey, width: 1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.menu, color: Colors.black),
                onPressed: () {},
              ),
              Text("Todo"),
              SizedBox(width: 40),
              IconButton(
                icon: Icon(Icons.search, color: Colors.blue),
                onPressed: () {
                  setState(() {
                    showSearchField = !showSearchField;
                    if (!showSearchField) {
                      _searchController.clear();
                      _filterTasks("");
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showInputField = !showInputField;
          });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
