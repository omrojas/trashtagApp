import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/home/home_bloc.dart';

import 'src/bloc/authentication/authentication_bloc.dart';
import 'src/bloc/simple_delegate.dart';
import 'src/repository/user_repository.dart';
import 'src/screens/home/home_page.dart';
import 'src/screens/login/login_page.dart';
import 'src/screens/signup/independent_volunteer_page.dart';
import 'src/screens/signup/organization_volunteer_page.dart';
import 'src/screens/splash_screen/splash_screen.dart';
import 'src/widgets/loading_indicator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();

  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AuthenticationStarted());
      },
      child: TrashTagApp(
        userRepository: userRepository,
      ),
    ),
  );
}

class TrashTagApp extends StatelessWidget {
  final UserRepository userRepository;

  TrashTagApp({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trash Tag',
      theme: trashtagTheme(),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return _diplayScreen(state);
        },
      ),
    );
  }

  ThemeData trashtagTheme() {
    // Primary color:   00A79D => 0, 167, 157,
    // AccentColor color: FFC107 => 255,193,7
    // Background:      22223B => 34,34,59

    return ThemeData(
      primaryColor: Color.fromRGBO(0, 167, 157, 1),
      accentColor: Color.fromRGBO(255, 193, 7, 1),
      appBarTheme: AppBarTheme(
        color: Color.fromRGBO(34, 34, 59, 1),
      ),
      buttonColor: Color.fromRGBO(0, 167, 157, 1),
      backgroundColor: Color.fromRGBO(34, 34, 59, 1),
      fontFamily: 'Montserrat',
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  Widget _diplayScreen(AuthenticationState state) {
    if (state is AuthenticationInitial) {
      return SplashScreen();
    }
    if (state is Unauthentication) {
      return LoginPage(userRepository: userRepository);
    }
    if (state is AuthenticationSuccess) {
      return BlocProvider(
        create: (context) {
          return HomeBloc();
        },
        child: HomePage(),
      );
    }
    if (state is AuthenticationFailure) {
      return LoginPage(userRepository: userRepository);
    }
    if (state is AuthenticationInProgress) {
      return LoadingIndicator();
    }
    if (state is SignUpAsIndependentVolunteer) {
      return IndependentVolunteerPage(userRepository: userRepository);
    }
    if (state is SignUpAsOrganizationVolunteer) {
      return OrganizationVolunteerPage(userRepository: userRepository);
    }
    return SplashScreen();
  }
}
