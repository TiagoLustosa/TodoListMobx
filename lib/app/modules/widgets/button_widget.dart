import 'package:flutter/material.dart';

class ButtonHeaderWidget extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onClicked;

  const ButtonHeaderWidget({Key key, this.title, this.text, this.onClicked})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      text: text,
      onClicked: onClicked,
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({Key key, this.text, this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        'Selecione a Data e hora',
      ),
      onPressed: onClicked,
    );
  }
}
