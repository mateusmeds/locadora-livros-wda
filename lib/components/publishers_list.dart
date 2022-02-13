import 'package:flutter/material.dart';
import 'package:livraria_wda/components/publisher_single.dart';
import 'package:livraria_wda/main.dart';
import 'package:livraria_wda/models/publisher.dart';

class PublishersList extends StatelessWidget {
  const PublishersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Publisher> publishers = [
      Publisher(1, 'Aleph', 'Natal'),
      Publisher(2, 'Suma', 'São Paulo'),
      Publisher(3, 'Darkside Books', 'Rio de Janeiro'),
      Publisher(4, 'Editora Rocco', 'Rio de Janeiro'),
      Publisher(5, 'Editora Intrínseca', 'Fortaleza'),
      Publisher(6, 'Companhia da Letras', 'Fortaleza'),
      Publisher(7, 'Globo Livros', 'Bahia'),
      Publisher(8, 'Harper Collins', 'Bahia'),
      Publisher(9, 'Editora Arqueiro', 'Natal'),
    ];

    return Expanded(
      child: ListView.builder(
        itemCount: publishers.length,
        itemBuilder: (ctx, index) {
          final publisher = publishers[index];

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
                    Icons.my_library_books_rounded,
                    size: 35,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => PublisherSingle(publisher: publisher),
                    ),
                  );
                },
                title: Text(
                  publisher.name,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            publisher.city,
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
