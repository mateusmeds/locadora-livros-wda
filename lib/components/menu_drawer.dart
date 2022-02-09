import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          color: Colors.lightBlue,
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.person,
                size: 45,
                color: Colors.grey[700],
              ),
              radius: 30,
              backgroundColor: Colors.grey[400],
            ),
            textColor: Colors.white,
            title: Text(
              "Mateus Medeiros",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "mateus@mail.com gesges ges gsehs hse",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Container(
          color: Colors.grey[200],
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text("Usuários"),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              debugPrint('toquei no drawer');
              //Fecha o menu
              Navigator.pop(context);
            },
          ),
        ),
        Container(
          color: Colors.grey[200],
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text("Editoras"),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              debugPrint('toquei no drawer');
              //Fecha o menu
              Navigator.pop(context);
            },
          ),
        ),
        Container(
          color: Colors.grey[200],
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text("Livros"),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              debugPrint('toquei no drawer');
              //Fecha o menu
              Navigator.pop(context);
            },
          ),
        ),
        Container(
          color: Colors.grey[200],
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text("Aluguéis"),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              debugPrint('toquei no drawer');
              //Fecha o menu
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}
