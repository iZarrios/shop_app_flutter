import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/my_main_styles.dart';

class ItemDetailsScreen extends StatelessWidget {
  final ProductModel model;

  ItemDetailsScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            color: MyMainColors.myWhite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    child: Image.network(
                      model.image,
                      width: 300,
                      height: 300,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Divider(
                  height: 10,
                  color: Colors.black,
                ),
                Container(
                    // width: MediaQuery.of(context).size.width,
                    child: _buildText("Name: ${model.name}")),
                Divider(
                  height: 10,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    _buildText("Price :"),
                    Spacer(),
                    _buildText(model.oldPrice),
                  ],
                ),
                Divider(
                  height: 10,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    _buildText("Price After Discount:"),
                    Spacer(),
                    _buildText(model.price),
                  ],
                ),
                Divider(
                  height: 10,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    _buildText("Shipping Fees:"),
                    Spacer(),
                    _buildText((model.price * 0.14).round()),
                  ],
                ),
                Divider(
                  height: 10,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    _buildText("Total :"),
                    Spacer(),
                    _buildText((model.price * 0.14 + model.price).round()),
                  ],
                ),
                SizedBox(height: 20),
                defaultButton(
                  onPressedFunction: () async {
                    final DatabaseReference db =
                        FirebaseDatabase.instance.reference();
                    User? user = FirebaseAuth.instance.currentUser;
                    UserData? userModel = ShopCubit.get(context).userModel;
                    // await db //getting data
                    //     .child("cart")
                    //     .child(user!.uid)
                    //     .once()
                    //     .then((value) {
                    //   data = value;
                    // }).catchError((e) {});
                    await db
                        .child("carts")
                        .child(user!.uid)
                        .child(model.id.toString())
                        .set(model.toMap());
                    showToast(
                        text: "Successfully Added", state: ToastStates.SUCCESS);
                  },
                  text: "Add to Cart",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildText(dynamic text) => Text(
      text.toString(),
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
    );
