import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/home/home_bloc.dart';
import 'package:trashtagApp/src/screens/collect/add_trash_page.dart';

class AddTrash extends StatelessWidget {
  const AddTrash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _addTrash(context);
  }

  Widget _addTrash(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is CollectView) {
          return FloatingActionButton(
            backgroundColor: Theme.of(context).accentColor,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 40.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTrahsPage()),
              );
            },
          );
        }

        return Container();
      },
    );
  }
}
