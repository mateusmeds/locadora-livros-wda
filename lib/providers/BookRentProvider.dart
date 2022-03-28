import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livraria_wda/models/book.dart';
import 'package:livraria_wda/models/book_rent.dart';
import 'package:livraria_wda/models/publisher.dart';
import 'package:http/http.dart' as http;
import 'package:livraria_wda/models/user.dart';

class BookRentProvider with ChangeNotifier {
  List<BookRent> _booksRental = [];
  List<BookRent> _booksRentSearch = [];

  List<BookRent> get booksRentSearch => _booksRentSearch;
  List<BookRent> get booksRental => _booksRental;

  Future<bool> loadBooksRental() async {
    _booksRental.clear();

    final response = await http.get(
      Uri.parse('http://livraria--back.herokuapp.com/api/alugueis'),
      headers: {'content-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> booksRentalData =
          jsonDecode(utf8.decode(response.body.codeUnits));

      for (var bookRent in booksRentalData) {
        BookRent bookRentObj = BookRent(
          bookRent['id'],
          User(
            bookRent['usuario_id']['id'],
            bookRent['usuario_id']['nome'],
            bookRent['usuario_id']['email'],
            bookRent['usuario_id']['endereco'],
            bookRent['usuario_id']['cidade'],
          ),
          Book(
            bookRent['livro_id']['id'],
            bookRent['livro_id']['autor'],
            bookRent['livro_id']['nome'],
            Publisher(
              bookRent['livro_id']['editora']['id'],
              bookRent['livro_id']['editora']['nome'],
              bookRent['livro_id']['editora']['cidade'],
            ),
            bookRent['livro_id']['quantidade'],
            bookRent['livro_id']['lancamento'],
            bookRent['livro_id']['totalalugado'],
          ),
          bookRent['data_aluguel'],
          bookRent['data_previsao'],
          bookRent['data_devolucao'].toString(),
        );
        setStatus(bookRentObj);
        _booksRental.add(bookRentObj);
      }

      notifyListeners();

      return true;
    }
    return false;
  }

  void setStatus(BookRent bookRent) {
    DateTime previsionDate;
    DateTime rentalDate;

    try {
      previsionDate = DateFormat('y-MM-dd').parse(bookRent.previsionDate);
      rentalDate = DateFormat('y-MM-dd').parse(bookRent.rentalDate);
    } catch (e) {
      previsionDate = DateFormat('dd/MM/y').parse(bookRent.previsionDate);
      rentalDate = DateFormat('dd/MM/y').parse(bookRent.rentalDate);
    }

    var devolutionDate = '';

    ///Controla se o prazo de entrega do livro foi ultrapassado
    bool returnedBookDelayed = false;

    if (bookRent.devolutionDate != '' && bookRent.devolutionDate != 'null') {
      final DateTime devolutionDateParse =
          DateFormat('y-MM-dd').parse(bookRent.devolutionDate);

      //Verifica se o livro foi entregue atrasado
      if (devolutionDateParse.difference(previsionDate).inDays > 0) {
        returnedBookDelayed = true;
      }

      devolutionDate = DateFormat('dd/MM/y').format(devolutionDateParse);
    } else if (DateTime.now().difference(previsionDate).inDays > 0) {
      returnedBookDelayed = true;
    }

    bookRent.returned =
        bookRent.devolutionDate == 'null' ? 'Não devolvido' : 'Devolvido';
    bookRent.status = !returnedBookDelayed ? 'No prazo' : 'Atrasado';
  }

  void filterBooksRent({String text = ""}) {
    if (text.isNotEmpty) {
      _booksRentSearch = _booksRental
          .where((bookRental) =>
              bookRental.book.name.toLowerCase().contains(text.toLowerCase()) ||
              bookRental.book.publisher.name
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              bookRental.devolutionDate
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              bookRental.returned
                  .toLowerCase()
                  .startsWith(text.toLowerCase()) ||
              bookRental.status.toLowerCase().startsWith(text.toLowerCase()) ||
              bookRental.previsionDate
                  .toString()
                  .contains(text.toLowerCase()) ||
              bookRental.user.name.toString().contains(text.toLowerCase()) ||
              bookRental.user.city.toString().contains(text.toLowerCase()) ||
              bookRental.user.address.toString().contains(text.toLowerCase()) ||
              bookRental.user.email.toString().contains(text.toLowerCase()))
          .toList();
    }
  }

  BookRent bookRentalById(int id) {
    if (_booksRental.any((element) => element.id == id)) {
      return _booksRental.firstWhere((element) => element.id == id);
    }
    return BookRent(
      -100,
      User(-100, '_name', '_email', '_address', '_city'),
      Book(-100, '_author', '_name', Publisher(-100, '_name', '_city'), -100,
          2000, -100),
      DateTime.now().toString(),
      DateTime.now().toString(),
      DateTime.now().toString(),
    );
  }

  Future<void> saveBookRental(Map<String, Object> data, Book book, User user) {
    BookRent bookRental = BookRent(
      0,
      user,
      book,
      data['rentalDate'].toString(),
      data['previsionDate'].toString(),
      'null',
    );
    return addBookRental(bookRental);
  }

  Future<void> addBookRental(BookRent bookRental) async {
    DateTime rentalDateFormat =
        DateFormat('dd/MM/y').parse(bookRental.rentalDate);
    DateTime previsionDateFormat =
        DateFormat('dd/MM/y').parse(bookRental.previsionDate);

    final response = await http.post(
      Uri.parse('http://livraria--back.herokuapp.com/api/aluguel'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(
        {
          "data_aluguel": DateFormat('y-MM-dd').format(rentalDateFormat),
          "data_devolucao": "",
          "data_previsao": DateFormat('y-MM-dd').format(previsionDateFormat),
          "id": 0,
          "livro_id": {
            "autor": bookRental.book.author,
            "editora": {
              "cidade": bookRental.book.publisher.city,
              "id": bookRental.book.publisher.id,
              "nome": bookRental.book.publisher.name,
            },
            "id": bookRental.book.id,
            "lancamento": bookRental.book.releaseYear,
            "nome": bookRental.book.name,
            "quantidade": bookRental.book.quantity,
            "totalalugado": bookRental.book.totalRented,
          },
          "usuario_id": {
            "cidade": bookRental.user.city,
            "email": bookRental.user.email,
            "endereco": bookRental.user.address,
            "id": bookRental.user.id,
            "nome": bookRental.user.name
          }
        },
      ),
    );

    if (response.statusCode == 200) {
      //Pegando id do aluguel cadastrado
      final bookRentalId = jsonDecode(response.body)['id'];
      BookRent bookRent = BookRent(
        bookRentalId,
        bookRental.user,
        bookRental.book,
        bookRental.rentalDate,
        bookRental.previsionDate,
        bookRental.devolutionDate,
      );

      setStatus(bookRent);

      _booksRental.add(bookRent);

      notifyListeners();
    } else if (response.statusCode == 400) {
      throw HttpException(
          jsonDecode(utf8.decode(response.body.codeUnits))['error']);
    } else {
      throw const HttpException(
        'Ocorreu um erro ao tentar salvar o aluguel do livro.',
      );
    }
  }

  Future<void> returnBook(BookRent bookRental) async {
    DateTime rentalDateFormat;
    DateTime previsionDateFormat;
    String rentalDateFormatString;
    String previsionDateFormatString;

    try {
      rentalDateFormat = DateFormat('y-MM-dd').parse(bookRental.rentalDate);
      previsionDateFormat =
          DateFormat('y-MM-dd').parse(bookRental.previsionDate);
    } catch (e) {
      rentalDateFormat = DateFormat('dd/MM/y').parse(bookRental.rentalDate);
      previsionDateFormat =
          DateFormat('dd/MM/y').parse(bookRental.previsionDate);
    }

    rentalDateFormatString = DateFormat('y-MM-dd').format(rentalDateFormat);
    previsionDateFormatString =
        DateFormat('y-MM-dd').format(previsionDateFormat);

    //Pegando index do livro para poder substituir
    int index = _booksRental.indexWhere((p) => p.id == bookRental.id);

    if (index >= 0) {
      final response = await http.put(
        Uri.parse('http://livraria--back.herokuapp.com/api/aluguel'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(
          {
            "data_aluguel": rentalDateFormatString,
            "data_devolucao":
                DateFormat('y-MM-dd').format(DateTime.now()).toString(),
            "data_previsao": previsionDateFormatString,
            "id": bookRental.id,
            "livro_id": {
              "autor": bookRental.book.author,
              "editora": {
                "cidade": bookRental.book.publisher.city,
                "id": bookRental.book.publisher.id,
                "nome": bookRental.book.publisher.name,
              },
              "id": bookRental.book.id,
              "lancamento": bookRental.book.releaseYear,
              "nome": bookRental.book.name,
              "quantidade": bookRental.book.quantity,
              "totalalugado": bookRental.book.totalRented,
            },
            "usuario_id": {
              "cidade": bookRental.user.city,
              "email": bookRental.user.email,
              "endereco": bookRental.user.address,
              "id": bookRental.user.id,
              "nome": bookRental.user.name
            }
          },
        ),
      );

      if (response.statusCode == 200) {
        bookRental.devolutionDate = DateFormat('y-MM-dd')
            .format(DateTime.now().add(const Duration(hours: 3)))
            .toString();
        setStatus(bookRental);
        _booksRental[index] = bookRental;

        notifyListeners();
      } else if (response.statusCode == 400) {
        throw HttpException(jsonDecode(response.body)['error']);
      } else {
        throw const HttpException(
          'Ocorreu um erro ao tentar devolver o livro.',
        );
      }
    }
  }

  Future<void> removeBookRental(BookRent bookRental) async {
    int index = _booksRental.indexWhere((u) => u.id == bookRental.id);

    if (index >= 0) {
      DateTime rentalDateFormat;
      DateTime previsionDateFormat;
      String rentalDateFormatString;
      String previsionDateFormatString;

      try {
        rentalDateFormat = DateFormat('y-MM-dd').parse(bookRental.rentalDate);
        previsionDateFormat =
            DateFormat('y-MM-dd').parse(bookRental.previsionDate);
      } catch (e) {
        rentalDateFormat = DateFormat('dd/MM/y').parse(bookRental.rentalDate);
        previsionDateFormat =
            DateFormat('dd/MM/y').parse(bookRental.previsionDate);
      }

      rentalDateFormatString = DateFormat('y-MM-dd').format(rentalDateFormat);
      previsionDateFormatString =
          DateFormat('y-MM-dd').format(previsionDateFormat);
      final response = await http.delete(
        Uri.parse('http://livraria--back.herokuapp.com/api/aluguel'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(
          {
            "data_aluguel": rentalDateFormatString,
            "data_devolucao": "",
            "data_previsao": previsionDateFormatString,
            "id": bookRental.id,
            "livro_id": {
              "autor": bookRental.book.author,
              "editora": {
                "cidade": bookRental.book.publisher.city,
                "id": bookRental.book.publisher.id,
                "nome": bookRental.book.publisher.name,
              },
              "id": bookRental.book.id,
              "lancamento": bookRental.book.releaseYear,
              "nome": bookRental.book.name,
              "quantidade": bookRental.book.quantity,
              "totalalugado": bookRental.book.totalRented,
            },
            "usuario_id": {
              "cidade": bookRental.user.city,
              "email": bookRental.user.email,
              "endereco": bookRental.user.address,
              "id": bookRental.user.id,
              "nome": bookRental.user.name
            }
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        _booksRental.remove(_booksRental[index]);
        notifyListeners();
      } else {
        throw const HttpException(
          'Ocorreu um erro ao tentar remover o aluguel.',
        );
      }
    } else {
      throw const HttpException(
        'Aluguel não existe.',
      );
    }
  }
}
