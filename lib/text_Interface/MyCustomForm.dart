import 'package:flutter/material.dart';
class MyCustomForm extends StatefulWidget{
  const MyCustomForm({Key key}) :super(key: key);
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}
class _MyCustomFormState extends State<MyCustomForm>{
  final myController = TextEditingController();

  @override
  void dispose(){
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leamanyi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: Text(myController.text),
                );
              }
          );
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}