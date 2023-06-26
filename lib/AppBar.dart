import 'package:flutter/material.dart';

class Bar extends StatefulWidget implements PreferredSizeWidget{
  const Bar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size(100,50);


  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar>  {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(100, 50),
        child: AppBar(
          backgroundColor: Color.fromRGBO(116, 85, 247, 1),
          title: const Text('KnowledgeVault', style: TextStyle(fontFamily: 'RobotoMono', fontSize: 20 ,color: Colors.white)),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings,color: Colors.white,),
              tooltip: 'Settings',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a setting page')));
              },
            ),
          ],
        ),
      ),
    );
  }
}