import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share/auth/bloc/auth_bloc.dart';
import 'package:foto_share/content/agregar/bloc/create_bloc.dart';
import 'package:foto_share/content/espera/bloc/pendig_bloc.dart';
import 'package:foto_share/home/home_page.dart';
import 'package:foto_share/login_page/login_page.dart';
import 'package:foto_share/content/mis_fotos/bloc/content_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: ((context) => AuthBloc()..add(VerifyAuthEvent())),
      ),
      BlocProvider(
        create: (context) => PendigBloc()..add(GetAllMyDisabledFotosEvent()),
      ),
      BlocProvider(
        create: (context) => ContentBloc()..add(GetAllMyFotosEvent()),
      ),
      BlocProvider(
        create: ((context) => CreateBloc()),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is AuthSuccesState) {
            return HomePage();
          } else if (state is AuthErrorState) {
            return LoginPage();
          } else if (state is SingOutSucces) {
            return LoginPage();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
