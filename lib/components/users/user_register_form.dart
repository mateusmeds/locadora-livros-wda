import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:livraria_wda/models/user.dart';
import 'package:provider/provider.dart';

class UserRegisterForm extends StatefulWidget {
  const UserRegisterForm({Key? key}) : super(key: key);

  @override
  _UserRegisterFormState createState() => _UserRegisterFormState();
}

class _UserRegisterFormState extends State<UserRegisterForm> {
  final _form = GlobalKey<FormState>();

  ///agrupa os dados do formulário após a validação
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Usuário'),
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
                  Icons.person_add_alt_1,
                  size: 90,
                ),
                const SizedBox(height: 20),
                //TODO: Alterar os ícones
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.person),
                  ),
                  onSaved: (newValue) =>
                      _formData['name'] = newValue.toString(),
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
                    labelText: 'Endereço',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  onSaved: (newValue) =>
                      _formData['address'] = newValue.toString(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório.';
                    } else if (value.length < 5) {
                      return 'No mínimo 5 caracteres.';
                    } else if (value.length > 50) {
                      return 'No máximo 50 caracteres.';
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Cidade',
                    prefixIcon: Icon(Icons.location_city_rounded),
                  ),
                  onSaved: (newValue) =>
                      _formData['city'] = newValue.toString(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório.';
                    } else if (value.length < 5) {
                      return 'No mínimo 3 caracteres.';
                    } else if (value.length > 50) {
                      return 'No máximo 20 caracteres.';
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(Icons.mail),
                  ),
                  onSaved: (newValue) =>
                      _formData['email'] = newValue.toString(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório.';
                    } else if (!EmailValidator.validate(value)) {
                      return 'E-mail inválido.';
                    } else if (value.length < 5) {
                      return 'No mínimo 5 caracteres.';
                    } else if (value.length > 50) {
                      return 'No máximo 100 caracteres.';
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final bool isValid = _form.currentState!.validate();
          if (isValid) {
            _form.currentState!.save();
            // Provider.of<UserProvider>(context).registerUser(
            //   User(
            //     -1,
            //     _formData['name'],
            //     _formData['email'],
            //     _formData['address'],
            //     _formData['city'],
            //   ),
            // );
            Navigator.of(context).pop();
          }
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.save),
      ),
    );
  }
}
