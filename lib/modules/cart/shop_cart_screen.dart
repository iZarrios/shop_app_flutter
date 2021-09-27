import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop_app/models/home_model.dart';
// import 'package:shop_app/modules/cart/cubit/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  CartScreen(this.data) {
    if (data != null) keys = data!.keys.toList();
  }

  final Map? data;
  late final List keys;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  Container _buildBody(BuildContext context) {
    return Container(
      child: Conditional.single(
        context: context,
        conditionBuilder: (context) => _conditionBuilder(),
        fallbackBuilder: (context) => _buildFallBack(),
        widgetBuilder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => _buildItem(
                  image: "${data![keys[index]]["image"]}",
                  title: "${data![keys[index]]["name"]}",
                ),
            separatorBuilder: (context, index) => SizedBox(height: 5),
            itemCount: data!.length),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${data!.length} Items",
            style: TextStyle(
              color: Colors.black38,
              fontSize: 10,
            ),
          ),
        ],
      ),
      elevation: 0,
      centerTitle: true,
    );
  }

  Widget _buildItem({required String title, required String image}) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Row(
          children: [
            SizedBox(
              width: 150,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildFallBack() => Center(child: Text("No Items in your cart!"));

  bool _conditionBuilder() {
    return data != null && data!.length > 0;
  }
}
