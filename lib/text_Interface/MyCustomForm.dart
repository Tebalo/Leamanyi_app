import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leamanyi_app/trie/trie.dart';
import 'package:leamanyi_app/nltoolkit/nltk.dart';

class MyCustomForm extends StatefulWidget{
  const MyCustomForm({Key key}) :super(key: key);
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}
class _MyCustomFormState extends State<MyCustomForm>{
  final myController = TextEditingController();
  Trie trie = new Trie();
  List<List<String>> tags;
  Node root;
  Nltk nltk;
  _MyCustomFormState(){
    tags = trie.strip_to_array();
    root = trie.create_map(tags);
    nltk = new Nltk();
  }
  @override
  void dispose(){
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: const Text('SETSWANA SA BORRE'),
        backgroundColor: Colors.black38,
        foregroundColor: Colors.white54,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.brown,
            height: MediaQuery.of(context).size.height,
            child: Body(myController: myController)
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          String text = myController.text;
          //print(text);
          List tagged = nltk.tag(text);
          //print(tagged);
          text = trie.pattern_match(tagged, root);
          print(text);
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: Text("$text"),
                );
              }
          );
        },
        tooltip: 'Ntshupegetsa leamanyi!',
        icon: const Icon(Icons.text_fields),
        label: Text("Bata leamanyi"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key key,
    @required this.myController,
  }) : super(key: key);

  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.amber,
      shadowColor: Colors.black12,
      borderOnForeground: true,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          TextArea(),
          ButtonArea(),
          TextFieldArea(myController: myController),
        ]
      ),
    );
  }
}

class TextArea extends StatelessWidget {
  const TextArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        borderOnForeground: true,
        color: Colors.black12,

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            softWrap: true,
            text: TextSpan(
              //text: "Leamanyi-Relative #Diphetolelo\n",
              style: DefaultTextStyle.of(context).style,
              //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              children: const <TextSpan>[
                TextSpan(text: "Leamanyi-Relative #Diphetolelo\n",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                TextSpan(text: "\t\t#Leamnyi: ", style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "\t\tKe lefoko le le amanyang dilo tse di farologaneng. "
                    "\t\t\t\t\tLe bopiwa ka legokedi le thito.\n"),
                TextSpan(text: '\t\t#Sekai : ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'Monna yo o lemang o itse botshelo.\n'),
                TextSpan(text: "\t\t\t              /yo o/ => Leamanyi.\n"),
                TextSpan(text: "\t\t\t              /lemang/ => thito.\n"),
                TextSpan(text: "Tshidimosetso\n", style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "\t\t\t1. O ka tsenya senepe se kwadilweng ka mafoko.\n"),
                TextSpan(text: "\t\t\t     a Setswana.\n"),
                TextSpan(text: "\t\t\t2. O ka tsaya senepe se kwadilweng ka mafoko a\n"),
                TextSpan(text: "\t\t\t     ka camera ya Phone.\n"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonArea extends StatelessWidget {
  const ButtonArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          //Button1(text: "Tsenya Senepe",icon: Icons.image),
          //Button1(text: "Tsaya Senepe", icon: Icons.add_a_photo),
          Button1(text: "Tsenya File", icon: Icons.file_upload)
        ],
      ),
    );
  }
}

class Button1 extends StatelessWidget {
  final String text;
  final IconData icon;
  const Button1({
    Key key,
    @required this.text,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7.0),
      child: ElevatedButton.icon(
          onPressed: (){

          },
          label: Text(text),
          icon: Icon(icon, size: 25,),
      ),
    );
  }
}

class TextFieldArea extends StatelessWidget {
  const TextFieldArea({
    Key key,
    @required this.myController,
  }) : super(key: key);

  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    final maxLines = 100;
    return Container(
      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: TextField(
        controller: myController,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: maxLines,
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
    );
  }
}