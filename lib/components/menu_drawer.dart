import 'package:flutter/material.dart';
import 'package:livraria_wda/components/user_list.dart';
import 'package:livraria_wda/components/users_home.dart';

class MenuDrawer extends StatelessWidget {
  final String title;

  const MenuDrawer({required this.title, Key? key}) : super(key: key);

  _openUsersListModal(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return UserList();
        });
  }

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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => UsersHome(title: title,),
                ),
              );
            },
          ),
        ),
        Container(
          color: Colors.grey[200],
          child: ListTile(
            leading: Icon(Icons.my_library_books_rounded),
            title: Text("Editoras"),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => UsersHome(title: title,),
                ),
              );
            },
          ),
        ),
        Container(
          color: Colors.grey[200],
          child: ListTile(
            leading: Icon(Icons.menu_book_rounded),
            title: Text("Livros"),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => UsersHome(title: title,),
                ),
              );
            },
          ),
        ),
        Container(
          color: Colors.grey[200],
          child: ListTile(
            leading: Icon(Icons.attach_money_outlined),
            title: Text("Aluguéis"),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => UsersHome(title: title,),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
