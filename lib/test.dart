import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Intl Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Intl Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateFormat dateFormat;
  DateFormat timeFormat;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMd('ru');
    timeFormat = new DateFormat.Hms('ru');
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = new DateTime.now();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(dateFormat.format(dateTime)),
            new Text(timeFormat.format(dateTime)),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _refresh,
        tooltip: 'Refresh',
        child: new Icon(Icons.refresh),
      ),
    );
  }
}
