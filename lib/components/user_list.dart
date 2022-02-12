import 'package:flutter/material.dart';
import 'package:livraria_wda/components/user_edit.dart';
import 'package:livraria_wda/components/user_single.dart';
import 'package:livraria_wda/models/user.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<User> users = [
      User(
          1,
          'Mateus Medeiros',
          'mateusmedeiros@mail.com',
          'Rua Teste, 458',
          'Natal'),
      User(
          1,
          'Rafael Rafael Rafael Rafael Rafael Rafael Rafael Rafael Rafael',
          'rafaelrafaelrafaelrafael@gmail.com',
          'Rua Teste, Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste',
          'Santa Cruz'),
      User(1, 'Mateus', 'mateus@mail.com',
          'Rua Teste, 363', 'Natal'),
      User(1, 'Mateus', 'mateus@mail.com',
          'Rua Teste, 363', 'Natal'),
      User(1, 'Mateus', 'mateus@mail.com', 'Rua Teste, 363', 'Natal'),
      User(1, 'Mateus', 'mateus@mail.com', 'Rua Teste, 363', 'Natal'),
      User(1, 'Mateus', 'mateus@mail.com', 'Rua Teste, 363', 'Natal'),
      User(1, 'Mateus', 'mateus@mail.com', 'Rua Teste, 363', 'Natal'),
      User(1, 'Mateus', 'mateus@mail.com', 'Rua Teste, 363', 'Natal'),
    ];

    return Expanded(
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (ctx, index) {
          final user = users[index];

          return Container(
            margin:
                const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
            child: Card(
              color: Colors.grey[300],
              elevation: 5,
              child: ListTile(
                //espaçamento interno
                contentPadding: const EdgeInsets.only(
                  top: 10,
                  bottom: 5,
                  left: 8,
                  right: 8,
                ),
                //avatar
                leading: const CircleAvatar(
                  radius: 30,
                  child: Icon(
                    Icons.person,
                    size: 40,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => UserSingle(user: user),
                    ),
                  );
                },
                title: Text(
                  user.name,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.email_rounded,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            user.email,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            user.address,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_city_rounded,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            user.city,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
