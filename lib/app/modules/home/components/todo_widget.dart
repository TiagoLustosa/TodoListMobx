import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/app/modules/home/home_store.dart';
import 'package:todo_list_app/app/modules/home/models/todo_model.dart';

class TodoWidget extends StatelessWidget {
  final TodoModel model;
  final Function onPressed;

  const TodoWidget({Key key, this.model, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.12,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          model.title,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(DateFormat('dd/MM/yyyy hh:mm a')
                            .format(model.date.toDate()))
                      ],
                    ),
                  )),
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.verified,
                              color: model.check ? Colors.green : Colors.white),
                          onPressed: () {
                            model.check = !model.check;
                            Modular.get<HomeStore>().saveTodo(model);
                          }),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: onPressed,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            Modular.get<HomeStore>().delete(model);
                          })
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
