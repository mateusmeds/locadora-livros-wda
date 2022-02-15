import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:livraria_wda/models/user.dart';
import 'package:livraria_wda/providers/UserProvider.dart';
import 'package:provider/provider.dart';

class UserEditForm extends StatefulWidget {
  final User user;

  UserEditForm({required this.user, Key? key}) : super(key: key);

  @override
  _UserEditFormState createState() => _UserEditFormState();
}

class _UserEditFormState extends State<UserEditForm> {
  final _form = GlobalKey<FormState>();

  ///agrupa os dados do formulário após a validação
  final Map<String, String> _formData = {};

  bool _isLoading = false;

  Future<void> _submitForm() async {
    final isValid = _form.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _form.currentState?.save();

    _formData['id'] = widget.user.id.toString();

    setState(() => _isLoading = true);

    try {
      await Provider.of<UserProvider>(
        context,
        listen: false,
      ).saveUser(_formData);

      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro ao tentar salvar o usuário.'),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Usuário'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.person,
                  size: 90,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: widget.user.name,
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
                  initialValue: widget.user.address,
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
                  initialValue: widget.user.city,
                  decoration: const InputDecoration(
                    labelText: 'Cidade',
                    prefixIcon: Icon(Icons.location_city_rounded),
                  ),
                  onSaved: (newValue) =>
                      _formData['city'] = newValue.toString(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório.';
                    } else if (value.length < 3) {
                      return 'No mínimo 3 caracteres.';
                    } else if (value.length > 50) {
                      return 'No máximo 20 caracteres.';
                    }
                  },
                ),
                TextFormField(
                  initialValue: widget.user.email,
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
        onPressed: _submitForm,
        backgroundColor: Colors.green,
        child: const Icon(Icons.save),
      ),
    );
  }
}
