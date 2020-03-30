import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gerente_loja/blocs/orders_bloc.dart';
import 'package:gerente_loja/blocs/user_bloc.dart';
import 'package:gerente_loja/screens/register_screen.dart';
import 'package:gerente_loja/tabs/orders_tab.dart';
import 'package:gerente_loja/tabs/products_tab.dart';
import 'package:gerente_loja/tabs/users_tab.dart';
import 'package:gerente_loja/widgets/edit_category_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController _pageController;
  int _page = 0;

  UserBloc _userBloc;
  OrdersBloc _ordersBloc;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _userBloc = UserBloc();
    _ordersBloc = OrdersBloc();
  }


  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.green,
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(
            caption: TextStyle(color: Colors.white54)
          )
        ),
        child: BottomNavigationBar(
          currentIndex: _page,
          onTap: (p){
            _pageController.animateToPage(
                p,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Colaboradores")
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_add),
                title: Text("Novo Colaborador")
            ),
             BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app),
              title: Text("Sair")
            ),
          ]
        ),
      ),
      body: SafeArea(
        child: BlocProvider<UserBloc>(
          bloc: _userBloc,
          child: BlocProvider<OrdersBloc>(
            bloc: _ordersBloc,
            child: PageView(
              controller: _pageController,
              onPageChanged: (p){
                setState(() {
                  _page = p;
                });
              },
              children: <Widget>[
                UsersTab(),
                SignUpScreen(),
                ProductsTab()
              ],
            ),
          ),
        ),
      ),
    );
  }

//   Widget _buildFloating(){
//     switch(_page){
//       case 0:
//         return null;
//       case 1:
//         return SpeedDial(
//           child: Icon(Icons.sort),
//           backgroundColor: Colors.green,
//           overlayOpacity: 0.4,
//           overlayColor: Colors.black,
//           children: [
//             SpeedDialChild(
//               child: Icon(Icons.arrow_downward, color: Colors.green,),
//               backgroundColor: Colors.white,
//               label: "Concluídos Abaixo",
//               labelStyle: TextStyle(fontSize: 14),
//               onTap: (){
//                 _ordersBloc.setOrderCriteria(SortCriteria.READY_LAST);
//               }
//             ),
//             SpeedDialChild(
//               child: Icon(Icons.arrow_upward, color: Colors.green,),
//               backgroundColor: Colors.white,
//               label: "Concluídos Acima",
//               labelStyle: TextStyle(fontSize: 14),
//               onTap: (){
//                 _ordersBloc.setOrderCriteria(SortCriteria.READY_FIRST);
//               }
//             )
//           ],
//         );
//       case 2:
//         return FloatingActionButton(
//           child: Icon(Icons.add),
//           backgroundColor: Colors.green,
//           onPressed: (){
//             showDialog(context: context,
//                 builder: (context) => EditCategoryDialog()
//             );
//           },
//         );
//     }
//   }
// }

}
