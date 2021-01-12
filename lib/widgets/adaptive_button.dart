import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function handler;

  AdaptiveFlatButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: Theme.of(context).primaryColorLight,
            onPressed: handler,

            ///simple version of calling the handler and below is more complicated
            child: Text(
              text,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold),
            ))
        : FlatButton(
            //color: Theme.of(context).primaryColorLight,
            onPressed: () {
              handler(); //this is more complicated than the method above
            },
            child: Text(
              text,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold),
            ));
  }
}
