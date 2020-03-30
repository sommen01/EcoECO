import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _cpfController = new MaskedTextController(mask: '000.000.000-00');
  final _telefoneController = new MaskedTextController(mask: '(00) 00000-0000');
  var _cepCController =  MaskedTextController(mask: '00000-000');
  final _numeroCasaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Novo Colaborador"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            if(model.isLoading)
              return Center(child: CircularProgressIndicator(),);

            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  Container(
                                height: 200.0,
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

                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        hintText: "Nome Completo"
                    ),
                    validator: (text){
                      if(text.isEmpty) return "Nome Inválido!";
                    },
                  ),
                  SizedBox(height: 16.0,),
                    TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _cpfController,
                    decoration: InputDecoration(
                        hintText: "CPF"
                    ),
                    validator: (text){
                      if(text.isEmpty || text.length <14) return "CPF Inválido!";
                    },
                  ),
                  SizedBox(height: 16.0,),
                    TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _telefoneController,
                    decoration: InputDecoration(
                        hintText: "Telefone Celular"
                    ),
                    validator: (text){
                      if(text.isEmpty) return "Telefone Inválido!";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                  keyboardType: TextInputType.number,
                    controller: _numeroCasaController,
                    decoration: InputDecoration(
                        hintText: "Número da casa"
                    ),
                    validator: (text){
                      if(text.isEmpty) return "Número Inválido!";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: _cepCController,
                    decoration: InputDecoration(
                        hintText: "CEP"
                    ),
                    keyboardType: TextInputType.number,
                    validator: (text){
                      if(text.isEmpty) return "CEP Inválido!";
                    },
                  ),
                  SizedBox(height: 16.0,),
                   TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: "E-mail"
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty || !text.contains("@")) return "E-mail Inválido!";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(
                        hintText: "Senha"
                    ),
                    obscureText: true,
                    validator: (text){
                      if(text.isEmpty || text.length < 6) return "Senha Inválida!";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text("Criar Conta",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        if(_formKey.currentState.validate()){

                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "cpf": _cpfController.text,
                            "telefoneCelular": _telefoneController.text,
                            "numeroCasa": _numeroCasaController.text,
                            "cep": _cepCController.text,
                            "senha": _passController.text,
                            "email": _emailController.text,
                            "totalPontos": 0,
                            "habilitadoCupom" : false,
                            "habilitadoSistema" : false,
                          };
                          model.signUp(
                              userData: userData,
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        )
    );
  }

  void _onSuccess(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Usuário criado com sucesso!"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      )
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).maybePop();
    });
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao criar usuário!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }

}

