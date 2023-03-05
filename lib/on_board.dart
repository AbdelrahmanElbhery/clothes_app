import 'package:clothes_shop/components/component.dart';
import 'package:clothes_shop/shared/cache.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'modules/login/login_module.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  List<String> images = [
    'assets/images/clothes.jpg',
    'assets/images/clothes2.jpg',
    'assets/images/clothes3.jpg'
  ];
  List<String> titles = [
    'تابع كل م هو جديد في عالم الاقمشة و الملابس',
    'تابع كل م هو جديد في عالم الاقمشة و الملابس',
    'تابع كل م هو جديد في عالم الاقمشة و الملابس'
  ];
  var pageviewcontroll = PageController();
  bool islast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageviewcontroll,
                itemBuilder: (context, index) =>
                    pageview(context, images[index], titles[index]),
                itemCount: images.length,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index == images.length - 1) {
                    setState(() {
                      islast = true;
                    });
                  } else {
                    setState(() {
                      islast = false;
                    });
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                  controller: pageviewcontroll,
                  count: 3,
                ),
                SizedBox(
                  width: 20,
                ),
                FloatingActionButton.small(
                  onPressed: () {
                    if (islast == true) {
                      CacheHelper.setdata(key: 'onboard', value: true)
                          .then((value) {
                        navigateandfinish(
                            context: context, widget: ShopLogin());
                      });
                    } else {
                      setState(() {
                        pageviewcontroll.nextPage(
                            duration: Duration(milliseconds: 700),
                            curve: Curves.fastLinearToSlowEaseIn);
                      });
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
          ],
        ),
      ),
    );
  }

  Widget pageview(context, String image, String title) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .15,
            ),
            Image(
              image: AssetImage(image),
              height: MediaQuery.of(context).size.height * .4,
              width: MediaQuery.of(context).size.width * 1,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .15,
            ),
            Text(
              textAlign: TextAlign.center,
              title,
              style:
                  Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 20),
            ),
          ],
        ),
      );
}
