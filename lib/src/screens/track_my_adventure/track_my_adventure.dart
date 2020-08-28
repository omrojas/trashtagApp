import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/home/home_bloc.dart';
import 'package:trashtagApp/src/bloc/my-progress/my_progress_bloc.dart';
import 'package:trashtagApp/src/models/user_statistics.dart';
import 'package:trashtagApp/src/widgets/loading_indicator.dart';
import 'package:trashtagApp/src/widgets/page_title.dart';
import 'package:trashtagApp/src/widgets/trashtag_container.dart';

class TrackMyAdventurePage extends StatelessWidget {
  const TrackMyAdventurePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _title(),
          SizedBox(height: 20.0),
          _name(context),
          _userStatisticsBuilder(context),
        ],
      ),
    );
  }

  Widget _title() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: PageTitle(
        title: 'My progress',
        subTitle: 'Keep track fo your adventure.',
      ),
    );
  }

  Widget _name(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (contex, state) {
        if (state is TrackMyAdventure) {
          final firstName = state.userInformation.firstName;
          final lastName = state.userInformation.lastName;
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            color: Theme.of(context).primaryColor,
            child: ListTile(
              title: Text(
                '${firstName ?? ''} ${lastName ?? ''}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _userStatisticsBuilder(BuildContext context) {
    return BlocBuilder<MyProgressBloc, MyProgressState>(
      builder: (context, state) {
        if (state is LoadingStatistics) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: LoadingIndicator(),
          );
        }

        if (state is StatisticsLoadsSuccessfully) {
          return _userStatistics(context, state.userStatistics);
        }

        if (state is ErrorLoadingStatistics) {
          return _errorMessage(state.error);
        }
        return Container();
      },
    );
  }

  Widget _userStatistics(
    BuildContext context,
    final UserStatistics userStatistics,
  ) {
    return TrashTagContainer(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _cup(userStatistics?.currentLevelIcon),
            _statistics(context, userStatistics),
          ],
        ),
      ),
    );
  }

  Widget _errorMessage(final String error) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          '${error ?? ''}',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget _cup(final String levelIconUrl) {
    if (levelIconUrl == null) {
      return Container();
    }
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/no-image.png',
      image: levelIconUrl,
      width: 120.0,
      height: 120.0,
      fit: BoxFit.cover,
    );
  }

  Widget _statistics(
    BuildContext context,
    final UserStatistics userStatistics,
  ) {
    final cleanups = userStatistics.cleanups;
    final itemsPicked = userStatistics.itemsPicked;
    final currentLevel = userStatistics?.currentLevel ?? '';

    return Flexible(
      child: Column(
        children: <Widget>[
          Text(
            '$currentLevel',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            '${cleanups ?? ''} Cleanups',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            '${itemsPicked ?? ''} items picked',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10.0),
          _nextLevel(userStatistics),
        ],
      ),
    );
  }

  Widget _nextLevel(final UserStatistics userStatistics) {
    final itemsToNextLevel = userStatistics.itemsToNextLevel;
    final nextLevel = userStatistics.nextLevel;
    if (itemsToNextLevel == null || itemsToNextLevel < 1) {
      return Container();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: ListTile(
            title: Text(
              '${itemsToNextLevel ?? ''} items left to ${nextLevel ?? 'next'} Level',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
