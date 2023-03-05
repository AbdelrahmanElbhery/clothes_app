import 'package:clothes_shop/bottomnav.dart';
import 'package:clothes_shop/components/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../home/cubit/cubit.dart';
import '../home/cubit/states.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            titleSpacing: 0,
            elevation: 3,
            leading: IconButton(
                onPressed: () {
                  navigateandfinish(context: context, widget: BottomNav());
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            title: Text(
              'من نحن',
              style: TextStyle(
                  color: Colors.black.withOpacity(.7),
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .15,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/clothes_logo.png'))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'من نحن',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: HexColor('#005A95')),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => article(),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: 1),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'ماذا نقدم من خدمات',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: HexColor('#005A95')),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Image(
                                height:
                                    MediaQuery.of(context).size.height * .08,
                                width: MediaQuery.of(context).size.width * .5,
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/clothes.jpg'),
                              ),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              'قسم خاص بالملابس',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: HexColor('#005A95')),
                              textDirection: TextDirection.rtl,
                            ),
                            Text(
                              'تابع كل ما هو جدبد و حصري في عالم الملابس تابع كل ما هو جدبد و حصري في عالم الملابس تابع كل ما هو جدبد و حصري في عالم الملابس تابع كل ما هو جدبد و حصري في عالم الملابس تابع كل ما هو جدبد و حصري في عالم الملابس',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Image(
                                height:
                                    MediaQuery.of(context).size.height * .08,
                                width: MediaQuery.of(context).size.width * .5,
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/clothes.jpg'),
                              ),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              'خدمة الاقمشة',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: HexColor('#005A95')),
                              textDirection: TextDirection.rtl,
                            ),
                            Text(
                              'تابع كل ما هو جدبد و حصري في عالم الاقمشة تابع كل ما هو جدبد و حصري في عالم الافمشة تابع كل ما هو جدبد و حصري في عالم الافمشة تابع كل ما هو جدبد و حصري في عالم الافمشة تابع كل ما هو جدبد و حصري في عالم الافمشة',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget article() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'شركة متخصصة لتوريد الملابس و القماش ',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                textDirection: TextDirection.rtl,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 10,
            ),
          ],
        ),
      );
}
