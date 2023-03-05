import 'package:auto_size_text/auto_size_text.dart';
import 'package:clothes_shop/bottomnav.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../components/component.dart';
import '../../models/articlemodel.dart';
import '../home/cubit/cubit.dart';
import '../home/cubit/states.dart';
import 'inside_article.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'المقالات',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 23,
                    fontWeight: FontWeight.w500),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  navigateandfinish(context: context, widget: BottomNav());
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: ConditionalBuilder(
              condition: state is! GetArticlesLoading,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.separated(
                    itemBuilder: (context, index) => articlescr(
                        context, HomeCubit.get(context).articles[index]),
                    separatorBuilder: (context, index) => SizedBox(
                          height: MediaQuery.of(context).size.height * .003,
                        ),
                    itemCount: HomeCubit.get(context).articles.length),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ));
      },
    );
  }

  Widget articlescr(context, ArticleModel model) => InkWell(
        onTap: () {
          navigate_to(
              context: context,
              widget: InsideArticles(
                article: model,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: MediaQuery.of(context).size.height * .4,
            width: MediaQuery.of(context).size.width * .9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                20,
              ),
              color: Colors.grey[200],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image(
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width * .7,
                    image: NetworkImage(model.articleimage!),
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                AutoSizeText(
                  model.title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: HexColor('#005A95')),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        model.date!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
