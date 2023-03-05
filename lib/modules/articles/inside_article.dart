import 'package:clothes_shop/modules/articles/articles.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/component.dart';
import '../../models/articlemodel.dart';
import '../home/cubit/cubit.dart';
import '../home/cubit/states.dart';

class InsideArticles extends StatelessWidget {
  ArticleModel? article;
  InsideArticles({required this.article});
  @override
  Widget build(BuildContext context) {
    final Uri facebookurl = Uri.parse(
        'https://www.facebook.com/search/top?q=rayon%20wear%20%D8%B1%D9%8A%D9%88%D9%86%20%D9%88%D9%8A%D8%B1%20%D9%84%D9%84%D8%B5%D9%86%D8%A7%D8%B9%D8%A7%D8%AA%20%D8%A7%D9%84%D9%86%D8%B3%D9%8A%D8%AC%D9%8A%D8%A9%20%D9%80');
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                navigateandfinish(context: context, widget: ArticlesScreen());
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: ConditionalBuilder(
            condition: true,
            builder: (context) => SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image(
                        height: MediaQuery.of(context).size.height * .3,
                        image: NetworkImage(article!.articleimage!),
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              article!.date!,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.calendar_month,
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    article!.title!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  articleScr(article!),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget articleScr(ArticleModel model) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                model.details!,
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
