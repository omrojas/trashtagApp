import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/contact/contact_bloc.dart';
import 'package:trashtagApp/src/bloc/home/home_bloc.dart';
import 'package:trashtagApp/src/repository/contact_repository.dart';
import 'package:trashtagApp/src/screens/collect/collect_page.dart';
import 'package:trashtagApp/src/screens/contact/contact_page.dart';
import 'package:trashtagApp/src/screens/home/home_option.dart';
import 'package:trashtagApp/src/screens/items_collected/items_collected_page.dart';
import 'package:trashtagApp/src/widgets/add_trash.dart';
import 'package:trashtagApp/src/widgets/menu.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';
import 'package:trashtagApp/src/widgets/trashtag_app_bar.dart';
import 'package:trashtagApp/src/widgets/trashtag_drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      endDrawer: TrashTagDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _blocBuilder(),
        ),
      ),
      floatingActionButton: AddTrash(),
      bottomNavigationBar: Menu(),
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
          return BlocProvider(
            create: (context) {
              final ContactRepository contactRepository = ContactRepository();
              return ContactBloc(repository: contactRepository);
            },
            child: ContactPage(),
          );
        }
        return _homeContent();
      },
    );
  }

  Widget _homeContent() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 40.0),
          _message(),
          SizedBox(height: 60.0),
          _options(),
        ],
      ),
    );
  }

  Widget _message() {
    final name = 'Natasha';
    return PageTitle(
      title: 'Hello, $name!',
      subTitle: 'Select an option to continue.',
    );
  }

  Widget _options() {
    return Container(
      height: 350.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _cleanUp(),
          // _trackMyAdventure(),
          // _reports(),
          _contact(),
        ],
      ),
    );
  }

  Widget _cleanUp() {
    return HomeOption(
      assetName: 'assets/images/cleanUp.jpeg',
      title: 'Clean up!',
      subtitle:
          'Help us to collect information about littering in public open spaces.',
      buttonText: 'START CLEANING',
      onClick: () {
        BlocProvider.of<HomeBloc>(context).add(
          CollectButtonPressed(),
        );
      },
    );
  }

  Widget _trackMyAdventure() {
    return HomeOption(
      // TODO change image
      assetName: 'assets/images/cleanUp.jpeg',
      title: 'Track my adventure',
      subtitle: 'Take a look at your progress in making a change.',
      buttonText: 'SEE MY PROGRESS',
      onClick: () {
        // NAVIGATE BY BLOC
      },
    );
  }

  Widget _reports() {
    return HomeOption(
      // TODO change image
      assetName: 'assets/images/cleanUp.jpeg',
      title: 'Reports',
      subtitle: 'List all your collected garbage across a cleaning session.',
      buttonText: 'SEE REPORTS',
      onClick: () {
        // NAVIGATE BY BLOC
      },
    );
  }

  Widget _contact() {
    return HomeOption(
      // TODO change image
      assetName: 'assets/images/cleanUp.jpeg',
      title: 'Contact us',
      subtitle: 'Get in touch with us.',
      buttonText: 'CONTACT',
      onClick: () {
        BlocProvider.of<HomeBloc>(context).add(
          ContactButtonPressed(),
        );
      },
    );
  }
}
