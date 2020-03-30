import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/user_bloc.dart';
import 'package:gerente_loja/widgets/user_tile.dart';

class UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      color: Colors.white,
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              style: TextStyle(color: Colors.green),
              decoration: InputDecoration(
                hintText: "Pesquisar",
                hintStyle: TextStyle(color: Colors.green),
                icon: Icon(Icons.search, color: Colors.green,),
                border: InputBorder.none
              ),
              onChanged: _userBloc.onChangedSearch,
            ),
          ),
          Expanded(
            child: StreamBuilder<List>(
              stream: _userBloc.outUsers,
              builder: (context, snapshot) {
                if(!snapshot.hasData)
                  return Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.green),
                    ),
                  );
                else if(snapshot.data.length == 0)
                  return Center(
                    child: Text("Nenhum usuário encontrado!", style: TextStyle(
                      color: Colors.green
                    ),),
                  );
                else
                  return ListView.separated(
                        
                      itemBuilder: (context, index){
                        return UserTile(snapshot.data[index]);
                      },
                      separatorBuilder: (context, index){
                        return Divider();
                      },
                      itemCount: snapshot.data.length
                  );
              }
            ),
          )
        ],
      ),
    );
  }
}
