import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livraria_wda/models/book.dart';
import 'package:livraria_wda/models/user.dart';
import 'package:livraria_wda/providers/BookProvider.dart';
import 'package:livraria_wda/providers/BookRentProvider.dart';
import 'package:livraria_wda/providers/UserProvider.dart';
import 'package:provider/provider.dart';

class BookRentRegisterForm extends StatefulWidget {
  const BookRentRegisterForm({Key? key}) : super(key: key);

  @override
  _BookRentRegisterFormState createState() => _BookRentRegisterFormState();
}

class _BookRentRegisterFormState extends State<BookRentRegisterForm> {
  final rentalDateController = TextEditingController();
  final previsionDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //Inicializando livros
    Provider.of<BookProvider>(
      context,
      listen: false,
    ).loadAvailableBooks().then((value) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((onError) {
      setState(() {
        _isLoading = false;
      });
    });

    //Inicializando usuários
    Provider.of<UserProvider>(
      context,
      listen: false,
    ).loadUsers().then((value) {
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

  var _selectedBook;
  var _selectedUser;

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    final userProvider = Provider.of<UserProvider>(context);
    final bookProvider = Provider.of<BookProvider>(context);

    Future<void> _submitForm() async {
      final isValid = _form.currentState?.validate() ?? false;

      if (!isValid) {
        return;
      }

      if (_selectedBook == null) {
        return;
      }

      if (_selectedUser == null) {
        return;
      }

      Book book = Provider.of<BookProvider>(
        context,
        listen: false,
      ).bookById(int.parse(_selectedBook));

      User user = Provider.of<UserProvider>(
        context,
        listen: false,
      ).userById(int.parse(_selectedUser));

      if (user.id < 0) {
        msg.showSnackBar(
          SnackBar(
            content: Text(
              'Usuário não selecionado.',
              style: TextStyle(fontSize: 17),
            ),
            backgroundColor: Colors.red[400],
            duration: Duration(seconds: 5),
          ),
        );

        return;
      }

      if (book.id < 0) {
        msg.showSnackBar(
          SnackBar(
            content: Text(
              'Livro não selecionado.',
              style: TextStyle(fontSize: 17),
            ),
            backgroundColor: Colors.red[400],
            duration: Duration(seconds: 5),
          ),
        );

        return;
      }

      _form.currentState?.save();

      _formData['id'] = '0';

      setState(() => _isLoading = true);

      try {
        await Provider.of<BookRentProvider>(
          context,
          listen: false,
        ).saveBookRental(_formData, book, user).then((value) {
          msg.showSnackBar(
            SnackBar(
              content: Text(
                'Aluguel cadastrado com sucesso.',
                style: TextStyle(fontSize: 17),
              ),
              backgroundColor: Colors.green[400],
              duration: Duration(seconds: 5),
            ),
          );
        });

        Navigator.of(context).pop();
      } catch (error) {
        msg.showSnackBar(
          SnackBar(
            content: Text(
              error.toString().replaceAll('HttpException: ', 'Erro: '),
              style: TextStyle(fontSize: 17),
            ),
            backgroundColor: Colors.red[400],
            duration: Duration(seconds: 5),
          ),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }

    void _dropDownBookItemSelected(String newId) {
      setState(() {
        this._selectedBook = newId;
      });
    }

    void _dropDownUserItemSelected(String newId) {
      setState(() {
        this._selectedUser = newId;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Aluguel'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.date_range,
                  size: 90,
                ),
                const SizedBox(height: 20),
                //Lista de livros
                DropdownButton<String>(
                  hint: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.menu_book_sharp,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 10),
                        Text('Selecione o livro...'),
                      ],
                    ),
                  ),
                  isExpanded: true,
                  items: bookProvider.books.map((Book bookItem) {
                    return DropdownMenuItem<String>(
                      value: bookItem.id.toString(),
                      child: Text(bookItem.name),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    _dropDownBookItemSelected(newValue!);
                    setState(() {
                      _selectedBook = newValue;
                      print(_selectedBook);
                    });
                  },
                  value: _selectedBook,
                ),
                const SizedBox(height: 10),
                //Lista de usuários
                DropdownButton<String>(
                  hint: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.person,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 10),
                        Text('Selecione o usuário...'),
                      ],
                    ),
                  ),
                  isExpanded: true,
                  items: userProvider.users.map((User userItem) {
                    return DropdownMenuItem<String>(
                      value: userItem.id.toString(),
                      child: Text(userItem.name),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    _dropDownUserItemSelected(newValue!);
                    setState(() {
                      _selectedUser = newValue;
                      print(_selectedUser);
                    });
                  },
                  value: _selectedUser,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Data de aluguel',
                    prefixIcon: Icon(Icons.date_range),
                  ),
                  readOnly: true,
                  controller: rentalDateController,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(Duration(hours: 3)),
                      firstDate: DateTime.now().add(Duration(hours: 3)),
                      lastDate: DateTime.now().add(Duration(hours: 3)),
                    ).then((pickedDate) {
                      if (pickedDate == null) {
                        return;
                      }

                      setState(() {
                        rentalDateController.text =
                            DateFormat('dd/MM/y').format(pickedDate);
                        _formData['rentalDate'] = rentalDateController.text;
                      });
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório.';
                    }
                  },
                ),
                TextFormField(
                  controller: previsionDateController,
                  decoration: const InputDecoration(
                    labelText: 'Data de previsão',
                    prefixIcon: Icon(Icons.date_range),
                  ),
                  readOnly: true,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(Duration(hours: 3)),
                      firstDate: DateTime.now().add(Duration(hours: 3)),
                      lastDate: DateTime.now().add(Duration(days: 30)),
                    ).then((pickedDate) {
                      if (pickedDate == null) {
                        return;
                      }

                      setState(() {
                        previsionDateController.text =
                            DateFormat('dd/MM/y').format(pickedDate);
                        _formData['previsionDate'] =
                            previsionDateController.text;
                      });
                    });
                  },
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
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        child: const Icon(
          Icons.save,
          size: 30,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
