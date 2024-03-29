import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/collect/collect_bloc.dart';
import 'package:trashtagApp/src/bloc/contact/contact_bloc.dart';
import 'package:trashtagApp/src/bloc/garbage_list/garbage_list_bloc.dart';
import 'package:trashtagApp/src/bloc/home/home_bloc.dart';
import 'package:trashtagApp/src/bloc/my-progress/my_progress_bloc.dart';
import 'package:trashtagApp/src/bloc/reports/reports_bloc.dart';
import 'package:trashtagApp/src/repository/contact_repository.dart';
import 'package:trashtagApp/src/repository/statistics_repository.dart';
import 'package:trashtagApp/src/repository/trash_repository.dart';
import 'package:trashtagApp/src/screens/collect/collect_page.dart';
import 'package:trashtagApp/src/screens/contact/contact_page.dart';
import 'package:trashtagApp/src/screens/home/home_content.dart';
import 'package:trashtagApp/src/screens/items_collected/items_collected_page.dart';
import 'package:trashtagApp/src/screens/reports/reports_page.dart';
import 'package:trashtagApp/src/screens/track_my_adventure/track_my_adventure.dart';
import 'package:trashtagApp/src/widgets/menu.dart';
import 'package:trashtagApp/src/widgets/trashtag_app_bar.dart';
import 'package:trashtagApp/src/widgets/trashtag_drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _onHomeButtonPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(context),
      endDrawer: TrashTagDrawer(),
      body: SafeArea(
        child: _createProdivers(),
      ),
      bottomNavigationBar: Menu(),
    );
  }

  Widget _createProdivers() {
    final statisticsRepository = StatisticsRepository();
    final contactRepository = ContactRepository();
    final trashRepository = TrashRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return CollectBloc(repository: trashRepository);
        }),
        BlocProvider(create: (context) {
          return GarbageListBloc(repository: trashRepository);
        }),
        BlocProvider(create: (context) {
          return MyProgressBloc(repository: statisticsRepository);
        }),
        BlocProvider(create: (context) {
          return ReportsBloc(repository: statisticsRepository);
        }),
        BlocProvider(create: (context) {
          return ContactBloc(repository: contactRepository);
        }),
      ],
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
          return ContactPage();
        }
        if (state is TrackMyAdventure) {
          return TrackMyAdventurePage();
        }
        if (state is ReportsView) {
          return ReportsPage(scaffoldKey: _scaffoldKey);
        }
        return HomeContent();
      },
    );
  }

  _onHomeButtonPressed() {
    BlocProvider.of<HomeBloc>(context).add(
      HomeButtonPressed(),
    );
  }
}
