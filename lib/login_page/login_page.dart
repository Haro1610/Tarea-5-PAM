import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share/auth/bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: (ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                "Sing In",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            Image.asset(
              "assets/icons/app_icon.png",
              height: 120,
            ),
            SizedBox(height: 200),
            MaterialButton(
              child: Text("Iniciar como anonimo"),
              onPressed: () {},
              color: Colors.grey,
            ),
            Text("Utilizar una red social"),
            MaterialButton(
              child: Text("Iniciar con Google"),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(GoogleAuthEvent());
              },
              color: Color.fromARGB(255, 39, 139, 61),
            ),
          ],
        )),
      ),
    );
  }
}
