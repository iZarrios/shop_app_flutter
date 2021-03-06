import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import '../../models/categories_model.dart';
import '../../models/change_favorites_model.dart';
import '../../models/favorites_model.dart';
import '../../models/login_model.dart';
import '../../models/home_model.dart';
import '../../modules/cateogries/cateogries_screen.dart';
import '../../modules/favorites/favorites_screen.dart';
import '../../modules/products/products_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../shared/network/local/cache_data.dart';
import '../../shared/network/remote/dio_helper.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  static late DatabaseReference db = FirebaseDatabase.instance.reference();

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void changeBottomNavigationBarItems(int index) {
    currentIndex = index;
    emit(ChangeBottomNav());
  }

  // start get home data
  HomeModel? homeModel;

  void getHomeData() async {
    emit(LoadingHomeData());
    DioHelper.getData(
      path: ApiDataAndEndPoints.homePathUrl,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // _addHomeDataToFavorites();
      emit(SuccessHomeData());
    }).catchError((error) {
      print('getHomeData -- ${error.toString()}');
      emit(ErrorHomeData(error.toString()));
    });
  }

  // start Add favorites data local
  // Map<int, bool> favorites = {};
  //
  // void _addHomeDataToFavorites() {
  //   homeModel!.data.products.forEach((element) {
  //     favorites.addAll({
  //       element.id: element.inFavorites,
  //     });
  //   });
  // }

  // start get favorites data
  late Map favouritesMap;

  void getFavoritesData() async {
    emit(LoadingFavoritesData());
    User? user = FirebaseAuth.instance.currentUser;
    DatabaseReference db = FirebaseDatabase.instance.reference();
    await db
        .child("users")
        .child(user!.uid)
        .child("favourites")
        .once()
        .then((value) {
      favouritesMap = value.value;
      emit(SuccessFavoritesData());
    }).catchError((error) {
      print("getFavoritesData -- ${error.toString()}");
      emit(ErrorFavoritesData(error.toString()));
    });
  }

  // DioHelper.getData(
  //   path: ApiDataAndEndPoints.favoritesPathUrl,
  //   token: token,
  // ).then((value) {
  //   favoritesModel = FavoritesModel.fromJson(value.data);
  //
  // }).catchError((error) {
  //   print("getFavoritesData -- ${error.toString()}");
  //   emit(ErrorFavoritesData(error.toString()));
  // });

  // start change favorites
  // ChangeFavoritesModel? changeFavoritesModel;
  //
  // void changeFavorites(int productId) async {
  //   try {
  //     favorites[productId] = !favorites[productId]!;
  //     emit(SuccessChangeFavoritesDataLocal());
  //
  //     Response value = await DioHelper.postData(
  //       path: ApiDataAndEndPoints.favoritesPathUrl,
  //       data: {
  //         'product_id': productId,
  //       },
  //       token: token,
  //     );
  //
  //     changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
  //     if (!changeFavoritesModel!.status) {
  //       // in case the status in remote == false
  //       // redo the change color in local
  //       favorites[productId] = !favorites[productId]!;
  //     } else {
  //       getFavoritesData();
  //     }
  //
  //     emit(SuccessChangeFavoritesDataRemote(changeFavoritesModel!));
  //   } catch (error) {
  //     favorites[productId] = !favorites[productId]!;
  //     print('changeFavorites -- ${error.toString()}');
  //     emit(ErrorChangeFavoritesDataRemote(error.toString()));
  //   }
  // }

  // start get categories data
  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(LoadingCategoriesData());

    DioHelper.getData(
      path: ApiDataAndEndPoints.getCategoriesPathUrl,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuccessCategoriesData());
    }).catchError((error) {
      print('getCategoriesData -- ${error.toString()}');
      emit(ErrorCategoriesData(error.toString()));
    });
  }

  // start get user data
  UserData? userModel;

  // User
//TODO:: get data from here
  Future<void> getUserData(BuildContext context) async {
    emit(LoadingUserData());

    final DatabaseReference db = FirebaseDatabase.instance.reference();
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) signOut(context);
    await db.child("users").child(user!.uid).once().then(
      (value) {
        emit(SuccessUserData(userModel));
        Map u = value.value;
        userModel = UserData(
          id: u["id"],
          name: u["name"],
          email: u["email"],
          phone: u["phone"],
          password: u["password"],
          favourites: u["favourites"],
          credit: u["credit"],
          points: u["points"],
        );
      },
    ).catchError((error) {
      print('getUserData -- ${error.toString()}');
      emit(ErrorUserData(error.toString()));
    });
  }

// start update user data
  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(LoadingUpdateUserData());
    final DatabaseReference db = FirebaseDatabase.instance.reference();
    User? user = FirebaseAuth.instance.currentUser;
    UserData newData = UserData(
      id: user!.uid,
      name: name,
      email: userModel!.email,
      phone: phone,
      password: userModel!.password,
      favourites: userModel!.favourites,
    );
    userModel!.name = name;
    userModel!.phone = phone;
    await db.child("users").child(user.uid).set(newData.toMap()).then(
      (value) {
        print("Updated");
        showToast(text: "Successfully Updated", state: ToastStates.SUCCESS);
        emit(SuccessUpdateUserData(newData));
        // getUserData(context);
      },
    ).catchError((e) {
      print(e.toString());
      showToast(
          text: "Failure in Updating, Try Again Later!",
          state: ToastStates.ERROR);
      emit(ErrorUpdateUserData(e.toString()));
    });
  }
}
// DioHelper.putData(
//   path: ApiDataAndEndPoints.updateProfilePathUrl,
//   token: token,
//   data: {
//     'name': name,
//     'email': email,
//     'phone': phone,
//   },
// ).then((value) {
//   // userModel = LoginModel.fromJson(value.data);
//   emit(SuccessUpdateUserData(userModel!));
// }).catchError((error) {
//   print('updateUserData -- ${error.toString()}');
//   emit(ErrorUpdateUserData(error.toString()));
// });
