import 'package:flutter/material.dart';
import 'package:livraria_wda/components/dashboardItem.dart';
import 'package:livraria_wda/components/menu_drawer.dart';
import 'package:livraria_wda/components/most_rented_books.dart';
import 'package:livraria_wda/providers/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class MostRentedBooks extends StatelessWidget {
  final List<MostRentedBooksData> data;

  const MostRentedBooks({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(minimum: 0),
      title: ChartTitle(text: 'Livros Mais Alugados'),
      tooltipBehavior: TooltipBehavior(enable: true,),
      series: <ChartSeries<MostRentedBooksData, String>>[
        ColumnSeries<MostRentedBooksData, String>(
            dataSource: data,
            xValueMapper: (MostRentedBooksData data, _) => data.bookName,
            yValueMapper: (MostRentedBooksData data, _) => data.totalRented,
            name: 'Gold',
            color: Color.fromRGBO(8, 142, 255, 1))
      ],
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoadingUsers = true;
  bool _isLoadingBooks = true;
  bool _isLoadingBooksRent = true;
  bool _isLoadingPublishers = true;

  @override
  void initState() {
    super.initState();
    Provider.of<DashboardProvider>(
      context,
      listen: false,
    ).loadUsers().then((value) {
      setState(() {
        _isLoadingUsers = false;
      });
    }).catchError((onError) {
      setState(() {
        _isLoadingUsers = false;
      });
    });

    Provider.of<DashboardProvider>(
      context,
      listen: false,
    ).loadBooks().then((value) {
      setState(() {
        _isLoadingBooks = false;
      });
    }).catchError((onError) {
      setState(() {
        _isLoadingBooks = false;
      });
    });

    Provider.of<DashboardProvider>(
      context,
      listen: false,
    ).loadPublishers().then((value) {
      setState(() {
        _isLoadingPublishers = false;
      });
    }).catchError((onError) {
      setState(() {
        _isLoadingPublishers = false;
      });
    });

    Provider.of<DashboardProvider>(
      context,
      listen: false,
    ).loadBooksRent().then((value) {
      setState(() {
        _isLoadingBooksRent = false;
      });
    }).catchError((onError) {
      setState(() {
        _isLoadingBooksRent = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final Map<String, Object> usersData = provider.usersData;
    final Map<String, Object> booksData = provider.booksData;
    final Map<String, Object> booksRentData = provider.booksRentData;
    final Map<String, Object> publishersData = provider.publishersData;

    return Scaffold(
      //só para a tela não ficar muito branca e confundir no navegador
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('WDA Livraria'),
      ),
      drawer: const Drawer(
        child: MenuDrawer(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                DashboardItem(
                  count: usersData['count'].toString(),
                  label: usersData['label'].toString(),
                  icon: Icons.person,
                  color: Colors.blue,
                  isLoading: _isLoadingUsers,
                ),
                DashboardItem(
                  count: publishersData['count'].toString(),
                  label: publishersData['label'].toString(),
                  icon: Icons.my_library_books_rounded,
                  color: Colors.blueGrey,
                  isLoading: _isLoadingPublishers,
                ),
              ],
            ),
            Row(
              children: [
                DashboardItem(
                  count: booksData['count'].toString(),
                  label: booksData['label'].toString(),
                  icon: Icons.menu_book_outlined,
                  color: Colors.green,
                  isLoading: _isLoadingBooks,
                ),
                DashboardItem(
                  count: booksRentData['count'].toString(),
                  label: booksRentData['label'].toString(),
                  icon: Icons.date_range,
                  color: Colors.red,
                  isLoading: _isLoadingBooksRent,
                ),
              ],
            ),
            _isLoadingBooks
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : MostRentedBooks(
                    data: provider.mostRentedBooks,
                  ),
          ],
        ),
      ),
    );
  }
}
