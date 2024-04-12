import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list/data/categories.dart';
import 'package:to_do_list/models/category.dart';
import 'package:to_do_list/models/todolist.dart';

class Services {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> addTask(ToDoItem newItem) async {
    Map<String, dynamic> obj = {
      "name": newItem.title,
      "category": newItem.category.title,
      "date": newItem.dateTime,
      "id": newItem.id,
      "ispined": newItem.isPinned
    };
    String docId = newItem.id;
    final DocumentReference tasksRef = firestore.collection("tasks").doc(docId);
    await tasksRef.set(obj);
  }

  Future<List> read() async {
    List<ToDoItem> tasks = [];
    final snapshot = await firestore.collection("tasks").get();
    final List<DocumentSnapshot> documents = snapshot.docs;
    for (DocumentSnapshot element in documents) {
      Categories category;
      if (element["category"] == "Personal") {
        category = Categories.Personal;
      } else if (element["category"] == "Finance") {
        category = Categories.Finance;
      } else if (element["category"] == "Work") {
        category = Categories.Work;
      } else {
        category = Categories.Other;
      }

      tasks.add(ToDoItem(
          title: element["name"],
          category: categories[category]!,
          dateTime: element["date"].toDate(),
          id: element["name"] + element["date"].toDate().toString(),
          isPinned: element["ispined"] as bool));
    }
    return tasks;
  }

  Future<void> deleteTodoItem(String documentId) async {
    final DocumentReference documentReference =
        firestore.collection('tasks').doc(documentId);
    await documentReference.delete();
  }
}
