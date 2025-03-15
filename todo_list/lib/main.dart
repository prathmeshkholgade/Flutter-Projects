import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage(), debugShowCheckedModeBanner: false);
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> taskList = [];
  List<Map<String, dynamic>> filteredList = [];
  bool inputTask = true;
  bool searchInput = false;
  TextEditingController inputController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  void initState() {
    super.initState();
    filteredList = List.from(taskList);
    print(filteredList);
    print("it runs when frist time page rendered");
  }

  void addTask() async {
    print(inputController.text);
    var task = inputController.text.toString();
    if (task.isNotEmpty) {
      taskList.add({"title": task, "isCompleted": false});
    }
    inputController.clear();
    filteredList = List.from(taskList);
    print(taskList);
    setState(() {});
  }

  void filterTask(String value) {
    print(searchController.text);
    setState(() {
      if (value.isEmpty) {
        filteredList = List.from(taskList);
      } else {
        filteredList =
            taskList
                .where(
                  (task) =>
                      task["title"].toLowerCase().contains(value.toLowerCase()),
                )
                .toList();
        print(filteredList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo List")),
      body: Container(
        child: Column(
          children: [
            if (inputTask)
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: inputController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter Task",
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        addTask();
                      },
                      icon: Icon(Icons.add, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            //search text input
            if (searchInput)
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Search Task",
                        ),
                        onChanged: (value) {
                          print(value);
                          filterTask(value);
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // filterTask();
                      },
                      icon: Icon(Icons.search, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            //task list will placed here
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: filteredList[index]["isCompleted"],
                      onChanged: (value) {
                        setState(() {
                          filteredList[index]["isCompleted"] = value!;
                        });
                      },
                    ),
                    title: Text(
                      filteredList[index]["title"],
                      style: TextStyle(
                        decoration:
                            filteredList[index]["isCompleted"]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          taskList.removeAt(index);
                          filterTask("");
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
        child: Container(
          height: 10,
          child: Row(
            children: [
              Icon(Icons.menu),
              Text("Todo"),
              Expanded(child: Divider()),
              IconButton(
                onPressed: () {
                  setState(() {
                    searchInput = !searchInput;
                    inputTask = false;
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
            inputTask = !inputTask;
            searchInput = false;
          });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
