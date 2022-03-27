import 'package:flutter/material.dart';
import 'package:livraria_wda/components/list_empty.dart';
import 'package:livraria_wda/components/publishers/publisher_register_form.dart';
import 'package:livraria_wda/components/publishers/publishers_list.dart';
import 'package:livraria_wda/models/publisher.dart';
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
  String filterText = "";

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Editoras');

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
    final List<Publisher> list = filterText.isEmpty
        ? publisherProvider.publishers
        : publisherProvider.publishersSearch;
    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
        actions: [
          IconButton(
            icon: customIcon,
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customSearchBar = ListTile(
                    title: TextField(
                      autofocus: true,
                      decoration: const InputDecoration(
                          hintText: 'Pesquisar...',
                          hintStyle: TextStyle(
                            color: Colors.white60,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          contentPadding: EdgeInsets.all(0)),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (text) {
                        setState(() {
                          filterText = text;
                          publisherProvider.filterPublishers(text: text);
                        });
                      },
                    ),
                  );
                  customIcon = const Icon(Icons.cancel);
                } else {
                  customIcon = const Icon(Icons.search);
                  customSearchBar = const Text('Editoras');
                  filterText = "";
                }
              });
            },
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(children: [
              Visibility(
                visible: !_isError && list.length > 0,
                child: PublishersList(list),
                replacement: ListEmptyMessage(
                  message: 'Nenhuma editora encontrada.',
                  icon: Icons.library_books_rounded,
                ),
              ),
            ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
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
