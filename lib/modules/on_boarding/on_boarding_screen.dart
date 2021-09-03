import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;

  final List<BoardingModel> boarding = [
    BoardingModel(
        image: "assets/images/online_shopping.png",
        title: "On Board 1 Title",
        body: "On Board 1 Body"),
    BoardingModel(
        image: "assets/images/cart.png",
        title: "On Board 2 Title",
        body: "On Board 2 Body"),
    BoardingModel(
        image: "assets/images/online_shopping.png",
        title: "On Board 3 Title",
        body: "On Board 3 Body"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                    print("Last Page");
                  } else {
                    isLast = false;
                  }
                },
                itemBuilder: (context, index) =>
                    buildOnBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                    activeDotColor: Colors.blue,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(!isLast) {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                    else
                      {
                        navigateAndFinish(context,ShopLoginScreen());
                      }
                  },
                  child: Icon(Icons.arrow_forward),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage("${model.image}"),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 30),
          Text(
            "${model.title}",
            style: TextStyle(
              fontSize: 24,
              // fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 30),
          Text(
            "${model.body}",
            style: TextStyle(
              fontSize: 14,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
}
