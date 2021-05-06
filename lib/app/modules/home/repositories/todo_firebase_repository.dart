import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list_app/app/modules/home/models/todo_model.dart';
import 'package:todo_list_app/app/modules/home/repositories/todo_repository_interface.dart';

class TodoFirebaseRepository implements ITodoRepository {
  FirebaseFirestore firestore;

  TodoFirebaseRepository(this.firestore);
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

  Future save(TodoModel todoModel) async {
    if (todoModel.reference == null) {
      todoModel.reference =
          await FirebaseFirestore.instance.collection('todo').add(
        {
          'title': todoModel.title,
          'check': todoModel.check,
          'date': todoModel.date
        },
      );
    } else {
      todoModel.reference.update({
        'title': todoModel.title,
        'check': todoModel.check,
        'date': todoModel.date
      });
    }
  }

  Future delete(TodoModel todoModel) {
    return todoModel.reference.delete();
  }
}
