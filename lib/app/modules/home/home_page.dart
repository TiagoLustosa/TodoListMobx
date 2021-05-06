import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/app/modules/home/components/todo_widget.dart';
import 'package:todo_list_app/app/modules/home/home_store.dart';
import 'package:todo_list_app/app/modules/home/models/todo_model.dart';
import 'package:todo_list_app/app/modules/widgets/datetime_picker_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  DateTime dateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Observer(builder: (_) {
        if (store.todoList.hasError) {
          return Center(
            child: ElevatedButton(
              onPressed: store.getList(),
              child: Text('Error'),
            ),
          );
        }

        if (store.todoList.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<TodoModel> list = store.todoList.data;
        return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index) {
              TodoModel model = list[index];
              return TodoWidget(
                model: model,
                onPressed: () {
                  _showDialog(model);
                },
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  _showDialog([TodoModel model]) {
    model ??= TodoModel();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(model.title.isEmpty ? 'Novo Todo' : 'Edição'),
            content: Container(
              width: 500,
              height: 200,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFormField(
                    initialValue: model.title,
                    maxLines: 2,
                    onChanged: (value) => model.title = value,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'escreva....'),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () async {
                            await pickDateTime(context);
                            print(dateTime);
                            model.date = Timestamp.fromDate(dateTime);
                            print(model.date);
                          },
                          child: Text('Selecione a data e hora'))
                    ],
                  )
                ],
              ),
            ),
            actions: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Modular.to.pop(),
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () async {
                          print(dateTime);
                          await store.saveTodo(model);
                          Modular.to.pop();
                        },
                        child: Text('Salvar'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;
    final time = await pickTime(context);

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<DateTime> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: dateTime ?? initialDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2021, 12, 31));
    if (newDate == null) return null;
    return newDate;
  }

  Future<TimeOfDay> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 00, minute: 00);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
          : initialTime,
    );
    if (newTime == null) return null;
    return newTime;
  }
}
