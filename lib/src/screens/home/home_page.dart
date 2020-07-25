import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/collect/collect_bloc.dart';
import 'package:trashtagApp/src/bloc/contact/contact_bloc.dart';
import 'package:trashtagApp/src/bloc/home/home_bloc.dart';
import 'package:trashtagApp/src/repository/contact_repository.dart';
import 'package:trashtagApp/src/repository/trash_repository.dart';
import 'package:trashtagApp/src/screens/collect/collect_page.dart';
import 'package:trashtagApp/src/screens/contact/contact_page.dart';
import 'package:trashtagApp/src/screens/home/home_content.dart';
import 'package:trashtagApp/src/screens/items_collected/items_collected_page.dart';
import 'package:trashtagApp/src/widgets/menu.dart';
import 'package:trashtagApp/src/widgets/trashtag_app_bar.dart';
import 'package:trashtagApp/src/widgets/trashtag_drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _onHomeButtonPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      endDrawer: TrashTagDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _createProdivers(),
        ),
      ),
      // floatingActionButton: AddTrash(),
      bottomNavigationBar: Menu(),
    );
  }

  Widget _createProdivers() {
    return BlocProvider(
      create: (context) {
        final trashRepository = TrashRepository();
        return CollectBloc(repository: trashRepository);
      },
      child: _blocBuilder(),
    );
  }

  Widget _blocBuilder() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is CollectView) {
          return CollectPage();
        }
        if (state is UserListView) {
          return ItemsCollectedPage();
        }
        if (state is ContactView) {
          return _contact();
        }
        return HomeContent();
      },
    );
  }

  Widget _contact() {
    return BlocProvider(
      create: (context) {
        final ContactRepository contactRepository = ContactRepository();
        return ContactBloc(repository: contactRepository);
      },
      child: ContactPage(),
    );
  }

  _onHomeButtonPressed() {
    BlocProvider.of<HomeBloc>(context).add(
      HomeButtonPressed(),
    );
  }
}
