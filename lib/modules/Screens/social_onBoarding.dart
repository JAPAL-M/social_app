import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/modules/Screens/social_login.dart';
import '../../models/onBoarding.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/style/colors.dart';

class onBoadingScreen extends StatefulWidget {
  const onBoadingScreen({Key? key}) : super(key: key);

  @override
  State<onBoadingScreen> createState() => _onBoadingScreenState();
}

class _onBoadingScreenState extends State<onBoadingScreen> {

  List<onBoardingModel> boarding = [
    onBoardingModel(image: 'assets/Images/onBoarding.png', title: 'onBoarding 1', body: 'on Body 1'),
    onBoardingModel(image: 'assets/Images/onBoarding.png', title: 'onBoarding 2', body: 'on Body 2'),
    onBoardingModel(image: 'assets/Images/onBoarding.png', title: 'onBoarding 3', body: 'on Body 3'),
  ];
  var boardingController = PageController();
  bool isLast = false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            submit();
          }, child: Text('SKIP'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index == boarding.length - 1 ){
                    setState(() {
                      isLast = true;
                    });
                  }else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardingController,
                itemBuilder: (context,index) => buildonBoarding(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: PrimaryColor,
                    dotWidth: 10,
                    dotHeight: 10,
                    spacing: 5,
                    expansionFactor: 4,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    isLast == true ? submit() : boardingController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn
                    );
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value){
        navigateAndFinish(context, LoginScreen());
      }
    });
  }

  Widget buildonBoarding(onBoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image.asset(
          model.image,
          height: 200,
          width: double.infinity,
          filterQuality: FilterQuality.high,
        ),
      ),
      SizedBox(height: 30,),
      Text(
        model.title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 25,
        ),
      ),
      Text(
        model.body,
        style: TextStyle(
            fontSize: 14,
            fontFamily: 'Janna'
        ),
      ),
    ],
  );
}