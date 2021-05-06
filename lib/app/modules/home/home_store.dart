import 'package:mobx/mobx.dart';
import 'package:todo_list_app/app/modules/home/models/todo_model.dart';
import 'package:todo_list_app/app/modules/home/repositories/todo_repository_interface.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final ITodoRepository repository;

  @observable
  ObservableStream<List<TodoModel>> todoList;
  HomeStoreBase(this.repository) {
    getList();
  }

  @action
  getList() {
    todoList = repository.getTodos().asObservable();
  }

  Future saveTodo(TodoModel todoModel) {
    return repository.save(todoModel);
  }

  Future delete(TodoModel todoModel) {
    return repository.delete(todoModel);
  }
}
