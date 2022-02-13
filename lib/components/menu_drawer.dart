import 'package:flutter/material.dart';
import 'package:livraria_wda/components/book_register_form.dart';
import 'package:livraria_wda/components/book_rent_register_form.dart';
import 'package:livraria_wda/components/publisher_register_form.dart';
import 'package:livraria_wda/components/users_home.dart';
import 'package:livraria_wda/main.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
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
            title: const Text(
              "Mateus Medeiros",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: const Text(
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
          child: ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Início"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => MyHomePage(),
                ),
              );
            },
          ),
        ),
        Container(
          child: ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Usuários"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const UsersHome(),
                ),
              );
            },
          ),
        ),
        Container(
          child: ListTile(
            leading: const Icon(Icons.my_library_books_rounded),
            title: const Text("Editoras"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const PublisherRegisterForm(),
                ),
              );
            },
          ),
        ),
        Container(
          child: ListTile(
            leading: const Icon(Icons.menu_book_rounded),
            title: const Text("Livros"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => BookRegisterForm(),
                ),
              );
            },
          ),
        ),
        Container(
          child: ListTile(
            leading: const Icon(Icons.date_range_rounded),
            title: const Text("Aluguéis"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => BookRentRegisterForm(),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
