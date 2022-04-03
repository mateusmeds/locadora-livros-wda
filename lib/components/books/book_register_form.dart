import 'package:flutter/material.dart';
import 'package:livraria_wda/models/publisher.dart';
import 'package:livraria_wda/providers/BookProvider.dart';
import 'package:livraria_wda/providers/PublisherProvider.dart';
import 'package:provider/provider.dart';

class BookRegisterForm extends StatefulWidget {
  const BookRegisterForm({Key? key}) : super(key: key);

  @override
  _BookRegisterFormState createState() => _BookRegisterFormState();
}

class _BookRegisterFormState extends State<BookRegisterForm> {
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
      });
    });
  }

  final _form = GlobalKey<FormState>();

  ///agrupa os dados do formulário após a validação
  final Map<String, Object> _formData = {};

  bool _isLoading = false;

  bool publisherIsSelected = true;

  var _selectedPublisher;

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    final publisherProvider = Provider.of<PublisherProvider>(context);

    Future<void> _submitForm() async {
      if (_selectedPublisher == null) {
        publisherIsSelected = false;
      }

      final isValid = _form.currentState?.validate() ?? false;

      if (!isValid || _selectedPublisher == null) {
        return;
      }

      _formData['publisher'] = _selectedPublisher;

      Publisher publisher = Provider.of<PublisherProvider>(
        context,
        listen: false,
      ).publisherById(int.parse(_selectedPublisher));

      if (publisher.id < 0) {
        msg.showSnackBar(
          SnackBar(
            content: const Text(
              'Editora não selecionada.',
              style: TextStyle(fontSize: 17),
            ),
            backgroundColor: Colors.red[400],
            duration: const Duration(seconds: 5),
          ),
        );
      }

      _form.currentState?.save();

      _formData['id'] = '0';

      setState(() => _isLoading = true);

      try {
        await Provider.of<BookProvider>(
          context,
          listen: false,
        ).saveBook(_formData, publisher).then((value) {
          msg.showSnackBar(
            SnackBar(
              content: const Text(
                'Livro cadastrado com sucesso.',
                style: TextStyle(fontSize: 17),
              ),
              backgroundColor: Colors.green[400],
              duration: const Duration(seconds: 5),
            ),
          );
        });

        Navigator.of(context).pop();
      } catch (error) {
        msg.showSnackBar(
          SnackBar(
            content: Text(
              error.toString().replaceAll('HttpException: ', 'Erro: '),
              style: const TextStyle(fontSize: 17),
            ),
            backgroundColor: Colors.red[400],
            duration: const Duration(seconds: 5),
          ),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }

    void _dropDownItemSelected(String novoItem) {
      setState(() {
        _selectedPublisher = novoItem;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Livro'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.menu_book_sharp,
                        size: 90,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                          prefixIcon: Icon(Icons.menu_book_sharp),
                        ),
                        onSaved: (newValue) {
                          _formData['name'] = newValue.toString();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório.';
                          } else if (value.length < 3) {
                            return 'No mínimo 3 caracteres.';
                          } else if (value.length > 30) {
                            return 'No máximo 30 caracteres.';
                          }
                        },
                      ),
                      DropdownButton<String>(
                        menuMaxHeight: 200,
                        hint: Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.my_library_books_rounded,
                                color: Colors.black54,
                              ),
                              SizedBox(width: 12),
                              Text('Selecione a Editora...'),
                            ],
                          ),
                        ),
                        isExpanded: true,
                        items: publisherProvider.publishers
                            .map((Publisher publisherItem) {
                          return DropdownMenuItem<String>(
                            value: publisherItem.id.toString(),
                            child: Container(
                              margin: const EdgeInsets.only(left: 12),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.my_library_books_rounded,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(publisherItem.name),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          _dropDownItemSelected(newValue!);
                          setState(() {
                            _selectedPublisher = newValue;
                          });
                        },
                        value: _selectedPublisher,
                      ),
                      !publisherIsSelected
                          ? Row(
                              children: [
                                Text(
                                  'Selecione uma editora.',
                                  style: TextStyle(
                                    color: Colors.red[700],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Autor',
                          prefixIcon: Icon(Icons.person),
                        ),
                        onSaved: (newValue) =>
                            _formData['author'] = newValue.toString(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório.';
                          } else if (value.length < 3) {
                            return 'No mínimo 3 caracteres.';
                          } else if (value.length > 30) {
                            return 'No máximo 30 caracteres.';
                          }
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Ano de lançamento',
                          prefixIcon: Icon(Icons.date_range),
                        ),
                        keyboardType: TextInputType.numberWithOptions(),
                        onSaved: (newValue) =>
                            _formData['releaseYear'] = newValue.toString(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório.';
                          } else if (value.length < 4) {
                            return 'Precisa ser 4 Dígitos.';
                          } else if (int.parse(value) > DateTime.now().year) {
                            return 'O ano limite é ${DateTime.now().year}.';
                          }
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Quantidade',
                          prefixIcon: Icon(Icons.add),
                        ),
                        keyboardType: TextInputType.numberWithOptions(),
                        onSaved: (newValue) =>
                            _formData['quantity'] = newValue.toString(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório.';
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Salvar'),
        icon: const Icon(Icons.save),
        onPressed: _submitForm,
        backgroundColor: Colors.green,
      ),
    );
  }
}
