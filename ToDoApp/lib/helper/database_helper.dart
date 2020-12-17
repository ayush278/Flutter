import 'package:ToDoApp/model/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  //Creating /getting db path
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE tasks(id INTEGER PRIMARY KEY, date DATETIME, isDone INTEGER, title TEXT, description TEXT)");
        return db;
      },
      version: 1,
    );
  }

//inserting todo task in db
  Future<int> insertTask(Task task) async {
    int taskId = 1;
    Database _db = await database();
    await _db
        .insert('tasks', task.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      taskId = value;
    });
    return taskId;
  }

//updating isdone value in db
  Future<void> updateTaskCheckBox(int id, int isDone) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE tasks SET isDone = '$isDone' WHERE id = '$id'");
  }

//updating data in value in db
  Future<void> updateTaskTitleDis(
      int id, String title, String description, String date) async {
    Database _db = await database();
    await _db.rawUpdate(
        "UPDATE tasks SET title = '$title' ,description = '$description', date = '$date'  WHERE id = '$id'");
  }

//geting list of todo task from db
  Future<List<Task>> getTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.query('tasks');
    return List.generate(taskMap.length, (index) {
      return Task(
          id: taskMap[index]['id'],
          title: taskMap[index]['title'],
          isDone: taskMap[index]['isDone'],
          description: taskMap[index]['description'],
          date: taskMap[index]['date']);
    });
  }

//getting data of todo task from db using task id
  Future<List<Task>> getTodo(int id) async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap =
        await _db.rawQuery("SELECT * FROM tasks WHERE id = $id");
    return List.generate(taskMap.length, (index) {
      return Task(
          id: taskMap[index]['id'],
          title: taskMap[index]['title'],
          description: taskMap[index]['description'],
          date: taskMap[index]['date']);
    });
  }

//deleting data from db
  Future<void> deleteTask(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM tasks WHERE id = '$id'");
  }
}
