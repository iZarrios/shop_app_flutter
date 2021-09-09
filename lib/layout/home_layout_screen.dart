import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
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
          floatingActionButton: FloatingActionButton(onPressed: () {
            // User? user = FirebaseAuth.instance.currentUser;
            // print(user!.uid);
            late UserData userModel;
            late Map u;
            final DatabaseReference db = FirebaseDatabase.instance.reference();
            User? user = FirebaseAuth.instance.currentUser;
            db.child(user!.uid).once().then(
              (value) {
                u = value.value;
                userModel = UserData(
                    id: u["id"],
                    name: u["name"],
                    email: u["email"],
                    phone: u["phone"],
                    password: u["password"]);
              },
            );

            // signOut(context);
          }),
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
