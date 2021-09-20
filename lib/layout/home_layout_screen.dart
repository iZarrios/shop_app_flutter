import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/cart/shop_cart_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import '../app_router.dart';
import 'cubit/shop_cubit.dart';

class HomeLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit shopCubit = ShopCubit.get(context);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.shopping_cart),
            onPressed: () async {
              print("p");
              signOut(context);
              var x = UserData(
                phone: "phone",
                items: {
                  0: {"tesdasdasdt": "tesat"},
                  1: {"tesdasdasdt": "tesat"},
                  2: {"tesdasdasdt": "tesat"},
                },
                email: "btt8yr 3ady",
                name: "naame",
                password: "pass",
                id: "4",
              );
              x.items[0] = {"gg":"kek"};

              final DatabaseReference db =
                  FirebaseDatabase.instance.reference();
              await db.child("users").child("he5a").set(x.toMap());
              print(x.toMap());
              // ShopCubit.get(context).getUserData(context);
              // print("press me shop");
              // var goto = MaterialPageRoute(
              //   builder: (context) => CartScreen(),
              // );
              // Navigator.push(context, goto);
            },
          ),
          appBar: AppBar(
            title: Text('SHOP'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  _goToSearchScreen(context);
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body: shopCubit.screens[shopCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: shopCubit.currentIndex,
            onTap: (int index) {
              shopCubit.changeBottomNavigationBarItems(index);
            },
            items: shopCubit.bottomNavigationBarItems,
          ),
        );
      },
    );
  }

  void _goToSearchScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRouter.searchScreen);
  }
}
