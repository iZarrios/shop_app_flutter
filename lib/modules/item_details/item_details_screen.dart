import 'package:flutter/material.dart';
import 'package:shop_app/models/home_model.dart';
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
                    height: 300,
                    width: 250,
                    child: Row(
                      children: [
                        Image.network(
                          model.image,
                          fit: BoxFit.fill,
                        ),
                      ],
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
                    _buildText(model.price * 0.14 + model.price),
                  ],
                ),
                SizedBox(height: 20),
                defaultButton(
                    onPressedFunction: () {
                      showToast(
                          text: "Successfully Added",
                          state: ToastStates.SUCCESS);
                    },
                    text: "Add to cart")
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