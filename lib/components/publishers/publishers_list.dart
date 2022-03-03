import 'package:flutter/material.dart';
import 'package:livraria_wda/components/publishers/publisher_single.dart';
import 'package:livraria_wda/models/publisher.dart';

class PublishersList extends StatelessWidget {
  final List<Publisher> publishers;
  const PublishersList(this.publishers, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: publishers.length,
        itemBuilder: (ctx, index) {
          final publisher = publishers[index];

          return Container(
            margin: const EdgeInsets.all(5),
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
                      builder: (BuildContext context) =>
                          PublisherSingle(publisher: publisher),
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
