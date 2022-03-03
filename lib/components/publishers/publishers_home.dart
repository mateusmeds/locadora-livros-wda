import 'package:flutter/material.dart';
import 'package:livraria_wda/components/list_empty.dart';
import 'package:livraria_wda/components/publishers/publisher_register_form.dart';
import 'package:livraria_wda/components/publishers/publishers_list.dart';
import 'package:livraria_wda/providers/PublisherProvider.dart';
import 'package:provider/provider.dart';

import '../menu_drawer.dart';

class PublishersHome extends StatefulWidget {
  const PublishersHome({Key? key}) : super(key: key);

  @override
  State<PublishersHome> createState() => _PublishersHomeState();
}

class _PublishersHomeState extends State<PublishersHome> {
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    Provider.of<PublisherProvider>(
      context,
      listen: false,
    ).loadPublishers().then((value) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((onError) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final publisherProvider = Provider.of<PublisherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Editoras'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _isError
                    ? ListEmptyMessage(
                        message: 'Nenhuma editora encontrada.',
                        icon: Icons.library_books_rounded,
                      )
                    : PublishersList(publisherProvider.publishers),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => const PublisherRegisterForm(),
            ),
          );
        },
      ),
      drawer: const Drawer(
        child: MenuDrawer(),
      ),
    );
  }
}
