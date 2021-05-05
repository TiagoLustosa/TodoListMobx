import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list_app/app/modules/home/models/todo_model.dart';
import 'package:todo_list_app/app/modules/home/repositories/todo_repository_interface.dart';

class TodoRepository implements ITodoRepository {
  FirebaseFirestore firestore;

  TodoRepository(this.firestore);
  @override
  Stream<List<TodoModel>> getTodos() {
    return firestore
        .collection('todo')
        .orderBy('date')
        .snapshots()
        .map((query) {
      return query.docs.map((doc) {
        return TodoModel.fromDocument(doc);
      }).toList();
    });
  }
}
