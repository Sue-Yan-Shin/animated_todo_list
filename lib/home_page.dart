import 'package:flutter/material.dart';
import 'package:todo_list/animated_loader.dart';

class Task {
  String title;
  bool isCompleted;

  Task({required this.title, required this.isCompleted});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];
  bool isLoading = false;

  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey();

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated  Todo'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask();
        },
        child: const Icon(Icons.add),
      ),
      body: Stack(children: [
        AnimatedList(
          key: _animatedListKey,
          initialItemCount: tasks.length,
          itemBuilder: (context, index, animation) {
            return _buildTaskItem(tasks[index], animation, index);
          },
        ),
        if (isLoading)
          const Opacity(
            opacity: 0,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black,
            ),
          ),
        if (isLoading)
          const Center(
            child: AnimatedLoader(),
          )
      ]),
    );
  }

  Widget _buildTaskItem(Task task, Animation<double> animation, int index) {
    return SizeTransition(
        sizeFactor: animation,
        child: Card(
            color: Colors.white,
            child: ListTile(
              title: Text(task.title),
              onLongPress: () => _removeTask(index),
            )));
  }

  void _addTask() async {
    Task newTask = Task(title: 'Task ${tasks.length + 1}', isCompleted: false);
    await loadData();
    tasks.add(newTask);
    _animatedListKey.currentState!.insertItem(tasks.length - 1);
  }

  void _removeTask(int index) async {
    await loadData();
    _animatedListKey.currentState!.removeItem(
      index,
      (context, animation) => _buildTaskItem(tasks[index], animation, index),
    );
    tasks.removeAt(index);
  }
}
