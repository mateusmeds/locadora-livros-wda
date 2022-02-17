import 'package:flutter/material.dart';
import 'package:livraria_wda/models/publisher.dart';
import 'package:livraria_wda/providers/PublisherProvider.dart';
import 'package:provider/provider.dart';

class PublisherEditForm extends StatefulWidget {
  final Publisher publisher;

  const PublisherEditForm({required this.publisher, Key? key}) : super(key: key);

  @override
  _PublisherEditFormState createState() => _PublisherEditFormState();
}

class _PublisherEditFormState extends State<PublisherEditForm> {
  final _form = GlobalKey<FormState>();

  ///agrupa os dados do formulário após a validação
  final Map<String, String> _formData = {};

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);

    Future<void> _submitForm() async {
      final isValid = _form.currentState?.validate() ?? false;

      if (!isValid) {
        return;
      }

      _form.currentState?.save();

      _formData['id'] = widget.publisher.id.toString();

      setState(() => _isLoading = true);

      try {
        await Provider.of<PublisherProvider>(
          context,
          listen: false,
        ).savePublisher(_formData).then((value) {
          msg.showSnackBar(
            SnackBar(
              content: const Text(
                'Editora alterada com sucesso.',
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Editora'),
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
                  initialValue: widget.publisher.name,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.my_library_books_rounded),
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
                  initialValue: widget.publisher.city,
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
