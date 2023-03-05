import 'package:clothes_shop/components/component.dart';
import 'package:clothes_shop/shared/const.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    new Future.delayed(const Duration(seconds: 5), () {
      navigateandfinish(context: context, widget: widget);
    });
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Image(
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width * .6,
                image: AssetImage('assets/images/clothes_logo.png'),
                fit: BoxFit.fill,
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            SizedBox(
              height: 15,
            ),
            CircularProgressIndicator(
              color: Colors.lightGreenAccent,
            )
          ],
        ),
      ),
    );
  }
}
