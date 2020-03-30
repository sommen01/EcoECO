import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/user_model.dart';
import 'package:gerente_loja/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primaryColor: Colors.green
//       ),
//       debugShowCheckedModeBanner: false,
//       home: LoginScreen(),
//     );
//   }
// }

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
              return MaterialApp(
                  title: "Ecoponto",
                  theme: ThemeData(
                             primaryColor: Colors.green

                  ),
                  debugShowCheckedModeBanner: false,
                  home: LoginScreen()
              );
          }
      ),
    );
  }
}
