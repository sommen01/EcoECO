import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/login_bloc.dart';
import 'package:gerente_loja/screens/home_screen.dart';
import 'package:gerente_loja/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    _loginBloc.outState.listen((state){
      switch(state){
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context)=>HomeScreen())
          );
          break;
        case LoginState.FAIL:
          showDialog(context: context, builder: (context)=>AlertDialog(
            title: Text("Erro"),
            content: Text("Você não possui os privilégios necessários"),
          ));
          break;
        case LoginState.LOADING:
        case LoginState.IDLE:
      }
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: StreamBuilder<LoginState>(
          stream: _loginBloc.outState,
          initialData: LoginState.LOADING,
          builder: (context, snapshot) {
            switch(snapshot.data){
              case LoginState.LOADING:
                return Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.green),),);
              case LoginState.FAIL:
              case LoginState.SUCCESS:
              case LoginState.IDLE:
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SingleChildScrollView(
                      child: Container(
                        width:  MediaQuery.of(context).size.width * 0.90,
                        margin: EdgeInsets.only(top : 50, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                           Padding(
                             padding: EdgeInsets.only(left:20.0),
                             child: Container(
                                height: 350.0,
                                width: 50.0,
                                decoration: new BoxDecoration(
                                  image: DecorationImage(
                                    image: new AssetImage(
                                        'assets/logo.png'),
                                    fit: BoxFit.contain,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                           ),
                            InputField(
                              icon: Icons.person_outline,
                              hint: "Usuário",
                              obscure: false,
                              stream: _loginBloc.outEmail,
                              onChanged: _loginBloc.changeEmail,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.030,
                            ),
                            InputField(
                              icon: Icons.lock_outline,
                              hint: "Senha",
                              obscure: true,
                              stream: _loginBloc.outPassword,
                              onChanged: _loginBloc.changePassword,
                            ),
                            SizedBox(height: 32,),
                            StreamBuilder<bool>(
                                stream: _loginBloc.outSubmitValid,
                                builder: (context, snapshot) {
                                  return Container(
                                    height: 50,
                                    width: 60,
                                    child: RaisedButton(
                                      color: Colors.green,
                                      child: Text("Entrar"),
                                      onPressed: snapshot.hasData ? _loginBloc.submit : null,
                                      textColor: Colors.white,
                                      disabledColor: Colors.green.withAlpha(140),
                                    ),
                                  );
                                }
                            )
                          ],
                        ),
                      )
                  ),
                ],
              );
            }
          }
        ),
      ),
    );
  }
}
