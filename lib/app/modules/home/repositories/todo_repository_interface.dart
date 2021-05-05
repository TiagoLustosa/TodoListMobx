import 'package:todo_list_app/app/modules/home/models/todo_model.dart';

abstract class ITodoRepository {
  Stream<List<TodoModel>> getTodos();
}
