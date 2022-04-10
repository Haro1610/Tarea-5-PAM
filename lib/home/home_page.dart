import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share/auth/bloc/auth_bloc.dart';
import 'package:foto_share/content/agregar/add_form.dart';
import 'package:foto_share/content/espera/en_espera.dart';
import 'package:foto_share/content/foru/fotosu.dart';
import 'package:foto_share/content/mis_fotos/my_content.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 1;
  final _pagesNameList = [
    "Fotos 4U",
    "En espera",
    "Agregar",
    "Mi contenido",
  ];
  final _pagesList = [
    FotosU(),
    EnEspera(),
    AddForm(),
    MyContent(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            height: 120,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.green, Colors.blue]))),
        title: Text(_pagesNameList[_currentPageIndex]),
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(SingOutEvent());
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pagesList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
          // Respond to item press.
        },
        items: [
          BottomNavigationBarItem(
            label: _pagesNameList[0],
            icon: Icon(Icons.view_carousel),
          ),
          BottomNavigationBarItem(
            label: _pagesNameList[1],
            icon: Icon(Icons.query_builder),
          ),
          BottomNavigationBarItem(
            label: _pagesNameList[2],
            icon: Icon(Icons.photo_camera),
          ),
          BottomNavigationBarItem(
            label: _pagesNameList[3],
            icon: Icon(Icons.mobile_friendly),
          )
        ],
      ),
    );
  }
}
