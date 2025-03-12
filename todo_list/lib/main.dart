import 'package:flutter/material.dart';

void main() {
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
      ),
      home: const MyHomePage(title: 'Todo List'),
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
  TextEditingController inputTaskController = TextEditingController();
  TextEditingController searchTextController = TextEditingController();
  List<Map<String, dynamic>> taskList = [];
  List<Map<String, dynamic>> filteredTasks = [];
  bool isTextField = true;
  bool showSearchField = false;
  void initState() {
    super.initState();
    filteredTasks = List.from(taskList);
  }

  void filteredTask(String query) {
    print("Filter function called with value: $query");
    setState(() {
      if (query.isEmpty) {
        filteredTasks = List.from(taskList);
      } else {
        filteredTasks =
            taskList
                .where(
                  (task) =>
                      task["title"].toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      }
    });
  }

  void addTask() {
    print(inputTaskController.text);
    if (inputTaskController.text.isNotEmpty) {
      setState(() {
        taskList.add({"title": inputTaskController.text, "isCompleted": false});
        inputTaskController.clear();
        isTextField = false;
        // filteredTasks = List.from(taskList);
        filteredTask("");
      });
      print("Task List Length: ${taskList.length}");
      print(taskList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: [
            if (isTextField)
              Padding(
                padding: EdgeInsets.all(21),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: inputTaskController,
                        decoration: InputDecoration(
                          hintText: "Enter Task",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.green),
                      onPressed: () {
                        addTask();
                      },
                    ),
                  ],
                ),
              ),
            if (showSearchField)
              Padding(
                padding: EdgeInsets.all(21),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchTextController,
                        decoration: InputDecoration(
                          hintText: "Search Task",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          print(value);
                          filteredTask(value);
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.blue),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: filteredTasks[index]["isCompleted"],
                      onChanged: (bool? value) {
                        setState(() {
                          filteredTasks[index]["isCompleted"] = value!;
                        });
                      },
                    ),
                    title: Text(
                      filteredTasks[index]["title"],
                      style: TextStyle(
                        decoration:
                            filteredTasks[index]["isCompleted"]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          print("u deleted  $index num task");
                          taskList.removeAt(index);
                          filteredTask("");
                        });
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green[100],
        child: Container(
          height: 40,
          child: Row(
            children: [
              Icon(Icons.menu),
              SizedBox(width: 10),
              Text("Todo"),
              Expanded(child: Divider()),
              IconButton(
                onPressed: () {
                  setState(() {
                    showSearchField = !showSearchField;
                    isTextField = false;
                  });
                },
                icon: Icon(Icons.search, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isTextField = !isTextField;
            showSearchField = false;
            print(isTextField);
          });
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
