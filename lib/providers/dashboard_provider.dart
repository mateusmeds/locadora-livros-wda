import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livraria_wda/components/devolution_of_books.dart';
import 'package:livraria_wda/components/devolution_of_books_status.dart';
import 'package:livraria_wda/components/most_rented_books.dart';
import 'package:livraria_wda/models/book.dart';
import 'package:livraria_wda/models/book_rent.dart';
import 'package:livraria_wda/models/publisher.dart';
import 'package:http/http.dart' as http;
import 'package:livraria_wda/models/user.dart';
import 'package:livraria_wda/providers/PublisherProvider.dart';

class DashboardProvider with ChangeNotifier {
  List<BookRent> _booksRent = [];
  Map<String, Object> _dataBooks = {};
  Map<String, Object> _dataBooksRent = {};
  Map<String, Object> _dataUsers = {};
  Map<String, Object> _dataPublishers = {};
  List<MostRentedBooksData> _mostRentedBooks = [];

  Map<String, Object> get usersData {
    return _dataUsers;
  }

  List<MostRentedBooksData> get mostRentedBooks {
    _mostRentedBooks.sort((a, b) => a.totalRented.compareTo(b.totalRented));
    return _mostRentedBooks.reversed.take(3).toList();
  }

  Map<String, Object> get booksData {
    return _dataBooks;
  }

  Map<String, Object> get publishersData {
    return _dataPublishers;
  }

  Map<String, Object> get booksRentData {
    return _dataBooksRent;
  }

  Future<void> loadBooks() async {
    _mostRentedBooks.clear();

    List<dynamic> booksData = [];
    final response = await http.get(
      Uri.parse('http://wdaw.hopto.org:8185/api/livros'),
      headers: {'content-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      booksData = jsonDecode(utf8.decode(response.body.codeUnits));

      for (var book in booksData) {
        _mostRentedBooks.add(MostRentedBooksData(
            bookName: book['nome'], totalRented: book['totalalugado'] as int));
      }

      notifyListeners();
    }

    _dataBooks = {'label': 'Livros', 'count': booksData.length};
  }

  Future<void> loadBooksRent() async {
    _booksRent.clear();
    List<dynamic> booksRentData = [];
    final response = await http.get(
      Uri.parse('http://wdaw.hopto.org:8185/api/alugueis'),
      headers: {'content-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      booksRentData = jsonDecode(utf8.decode(response.body.codeUnits));
      for (var bookRent in booksRentData) {
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
        _booksRent.add(bookRentObj);
      }
    }

    _dataBooksRent = {'label': 'Aluguéis', 'count': booksRentData.length};
  }

  Future<void> loadUsers() async {
    List<dynamic> usersData = [];
    final response = await http.get(
      Uri.parse('http://wdaw.hopto.org:8185/api/usuarios'),
      headers: {'content-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      usersData = jsonDecode(utf8.decode(response.body.codeUnits));
    }

    _dataUsers = {'label': 'Usuários', 'count': usersData.length};
  }

  Future<void> loadPublishers() async {
    List<dynamic> publishersData = [];
    final response = await http.get(
      Uri.parse('http://wdaw.hopto.org:8185/api/editoras'),
      headers: {'content-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      publishersData = jsonDecode(utf8.decode(response.body.codeUnits));
    }

    _dataPublishers = {'label': 'Editoras', 'count': publishersData.length};
  }

  List<DevolutionOfBooksStatusData> devolutionOfBooksStatus() {
    late List<DevolutionOfBooksStatusData> devolutionOfBooksStatus;
    int totalBooksLate = 0;
    int totalBooksOnTime = 0;

    for (var bookRental in _booksRent) {
      bookRental.status.toLowerCase() == "no prazo"
          ? totalBooksOnTime++
          : totalBooksLate++;
    }

    devolutionOfBooksStatus = [
      DevolutionOfBooksStatusData(
        color: Colors.green,
        label: "No prazo",
        totalBooks: totalBooksOnTime,
      ),
      DevolutionOfBooksStatusData(
        color: Colors.red,
        label: "Atrasado",
        totalBooks: totalBooksLate,
      ),
    ];

    return devolutionOfBooksStatus;
  }

  List<DevolutionOfBooksData> devolutionOfBooks() {
    late List<DevolutionOfBooksData> devolutionOfBooks;
    int totalBooksReturned = 0;
    int totalBooksNotReturned = 0;
    int totalBooksLate = 0;
    int totalBooksOnTime = 0;

    for (var bookRental in _booksRent) {
      bookRental.returned.toLowerCase() == "devolvido"
          ? totalBooksReturned++
          : totalBooksNotReturned++;
    }

    devolutionOfBooks = [
      DevolutionOfBooksData(
        color: Colors.green,
        label: "Devolvido",
        totalBooks: totalBooksReturned,
      ),
      DevolutionOfBooksData(
        color: Colors.red,
        label: "Não devolvido",
        totalBooks: totalBooksNotReturned,
      ),
    ];

    return devolutionOfBooks;
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
}
