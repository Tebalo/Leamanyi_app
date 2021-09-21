import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: "Tsenya seele sa Setswana.",
                filled: true,
                hintStyle: new TextStyle(color: Colors.grey[800]),
                fillColor: Colors.white70,
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Leamanyi:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Kanoka',
        child: Icon(Icons.add_a_photo),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}