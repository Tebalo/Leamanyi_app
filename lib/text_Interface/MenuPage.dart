import 'package:flutter/material.dart';
import 'package:leamanyi_app/text_Interface/MyCustomForm.dart';

class MenuPage extends StatefulWidget{
  MenuPage({Key key}) : super(key: key);
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        leading: Icon(Icons.wb_sunny_outlined),
        title: const Text('SETSWANA SA BORRE'),
        backgroundColor: Colors.black38,
        foregroundColor: Colors.white54,
      ),
      body: Card(
        elevation: 2,
        color: Colors.amber,
        shadowColor: Colors.black12,
        borderOnForeground: true,
        clipBehavior: Clip.antiAlias,
        child: ListView(
          children: [
            myCard(text: "Leamanyi",subText: "'Ke lefoko le le amanyang dilo tse di farologaneng.'",),
            myCard(text: "Lesoboki",subText: "'Ke lefoko le le amanyang dilo tse di farologaneng.'",),
            myCard(text: "Lediri",subText: "'Ke lefoko le le amanyang dilo tse di farologaneng.'",),
            myCard(text: "Leemedi",subText: "'Ke lefoko le le amanyang dilo tse di farologaneng.'",),
            myCard(text: "Leamanyi",subText: "'Ke lefoko le le amanyang dilo tse di farologaneng.'",),
            myCard(text: "Lesoboki",subText: "'Ke lefoko le le amanyang dilo tse di farologaneng.'",)
          ],
        ),
      ),
    );
  }
}

class myCard extends StatelessWidget {
  final String text;
  final String subText;
  const myCard({
    Key key,
    @required this.text,
    @required this.subText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context){
          return MyCustomForm();
        })
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.blueAccent,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.arrow_forward),
                title: Text(text, style: TextStyle(fontSize: 22, color: Colors.amber),),
                subtitle: Text(subText, style: TextStyle(fontSize: 16, color: Colors.white),),
              )
            ]
          ),
        ),
      ),
    );
  }
}
