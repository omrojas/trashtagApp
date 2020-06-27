import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/pages/login/login_page.dart';
import 'package:trashtagApp/src/pages/signup/independent_volunteer_page.dart';
import 'package:trashtagApp/src/pages/signup/organization_volunteer_page.dart';

import 'src/bloc/authentication/authentication_bloc.dart';
import 'src/pages/home/home_page.dart';
import 'src/pages/login/login_page.dart';
import 'src/pages/splash_screen/splash_screen.dart';
import 'src/repository/user_repository.dart';
import 'src/widgets/loading_indicator.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();

  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AuthenticationStarted());
      },
      child: TrashTagApp(userRepository: userRepository),
    ),
  );
}

class TrashTagApp extends StatelessWidget {
  final UserRepository userRepository;

  TrashTagApp({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build MyApp');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trash Tag',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return _diplayScreen(state);
        },
      ),
    );
  }

  Widget _diplayScreen(AuthenticationState state) {
    print('state $state');
    if (state is AuthenticationInitial) {
      return SplashScreen();
    }
    if (state is Unauthentication) {
      return LoginPage(userRepository: userRepository);
    }
    if (state is AuthenticationSuccess) {
      return HomePage();
    }
    if (state is AuthenticationFailure) {
      return LoginPage(userRepository: userRepository);
    }
    if (state is AuthenticationInProgress) {
      return LoadingIndicator();
    }
    if (state is SignUpAsIndependentVolunteer) {
      return IndependentVolunteerPage();
    }
    if (state is SignUpAsOrganizationVolunteer) {
      return OrganizationVolunteerPage();
    }
    return SplashScreen();
  }
}
