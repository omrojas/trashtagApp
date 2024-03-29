import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/home/home_bloc.dart';
import 'package:trashtagApp/src/bloc/my-progress/my_progress_bloc.dart';
import 'package:trashtagApp/src/screens/home/home_option.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 40.0),
            _message(),
            SizedBox(height: 60.0),
            _options(context),
          ],
        ),
      ),
    );
  }

  Widget _message() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeView) {
          final user = state?.userInformation?.firstName ?? '';
          return PageTitle(
            title: 'Hello, $user!',
            subTitle: 'Select an option to continue.',
          );
        }

        return CircularProgressIndicator();
      },
    );
  }

  Widget _options(BuildContext context) {
    return Container(
      height: 350.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _cleanUp(context),
          _trackMyAdventure(context),
          _reports(context),
          _contact(context),
        ],
      ),
    );
  }

  Widget _cleanUp(BuildContext context) {
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

  Widget _trackMyAdventure(BuildContext context) {
    return HomeOption(
      assetName: 'assets/images/track-my-progress.jpeg',
      title: 'Track my adventure',
      subtitle: 'Take a look at your progress in making a change.',
      buttonText: 'SEE MY PROGRESS',
      onClick: () {
        BlocProvider.of<MyProgressBloc>(context).add(
          LoadStatistics(),
        );

        BlocProvider.of<HomeBloc>(context).add(
          TrackMyAdventureButtonPressed(),
        );
      },
    );
  }

  Widget _reports(BuildContext context) {
    return HomeOption(
      assetName: 'assets/images/reports.jpeg',
      title: 'Reports',
      subtitle: 'List all your collected garbage across a cleaning session.',
      buttonText: 'SEE REPORTS',
      onClick: () {
        BlocProvider.of<HomeBloc>(context).add(
          ReportsButtonPressed(),
        );
      },
    );
  }

  Widget _contact(BuildContext context) {
    return HomeOption(
      assetName: 'assets/images/contact-us.jpeg',
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
