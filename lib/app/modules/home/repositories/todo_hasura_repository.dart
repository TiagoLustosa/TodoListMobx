import 'package:hasura_connect/hasura_connect.dart';
import 'package:todo_list_app/app/modules/home/documents/todo_document.dart';
import 'package:todo_list_app/app/modules/home/models/todo_model.dart';
import 'package:todo_list_app/app/modules/home/repositories/todo_repository_interface.dart';

class TodoHasuraRepository implements ITodoRepository {
  final HasuraConnect connect;

  TodoHasuraRepository(this.connect);
  @override
  Stream<List<TodoModel>> getTodos() {
    // return connect.subscription(todosQuery).map((event) {
    //   return (event.value['data']['todos'] as List).map((json) {
    //     return TodoModel.fromJson(json);
    //   }).toList();
    // });
  }

  @override
  Future delete(TodoModel todoModel) {}

  @override
  Future save(TodoModel todoModel) {}
}
