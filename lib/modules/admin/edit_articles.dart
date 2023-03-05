import 'package:clothes_shop/components/component.dart';
import 'package:clothes_shop/models/articlemodel.dart';
import 'package:clothes_shop/modules/admin/show_article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class EditArticle extends StatelessWidget {
  ArticleModel? model;
  EditArticle({required this.model});
  @override
  Widget build(BuildContext context) {
    var titlecontroller = TextEditingController();
    var detailscontroller = TextEditingController();
    titlecontroller.text = model!.title!;
    detailscontroller.text = model!.details!;
    var formkey = GlobalKey<FormState>();
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is UpdateArticlesSuccess) {
          showToast(text: 'Article Updated', colors: Colors.green);
          AdminCubit.get(context).getArticles();
        } else if (state is DeleteArticlesSuccess) {
          showToast(text: 'Article Deleted', colors: Colors.green);
          navigateandfinish(context: context, widget: ShowArticlesAdmin());
          AdminCubit.get(context).getArticles();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                navigateandfinish(
                    context: context, widget: ShowArticlesAdmin());
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            elevation: 0,
            title: Text(
              'Articles',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                  fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
            actions: [
              TextButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      AdminCubit.get(context).updateArticle(
                          title: titlecontroller.text,
                          details: detailscontroller.text,
                          uid: model!.uid!,
                          articleimage: model!.articleimage);
                    }
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(fontSize: 18),
                  )),
              SizedBox(
                width: 10,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (state is UpdateArticlesLoading)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                    if (state is UpdateArticlesLoading)
                      CircularProgressIndicator(),
                    if (state is DeleteArticlesLoading)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                    if (state is DeleteArticlesLoading)
                      CircularProgressIndicator(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * .2,
                        child: Image(
                          image: NetworkImage(model!.articleimage!),
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    DefaultFormField(
                      controller: titlecontroller,
                      label: 'title',
                      validate: (validate) {
                        if (validate == '') {
                          return 'title can\'t be empty';
                        }
                        return null;
                      },
                      prefixicon: Icons.title,
                      texttype: TextInputType.text,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    DefaultFormField(
                      maxlines: 5,
                      controller: detailscontroller,
                      label: 'subject',
                      validate: (validate) {
                        if (validate == '') {
                          return 'details can\'t be empty';
                        }
                        return null;
                      },
                      prefixicon: Icons.info_outline,
                      texttype: TextInputType.text,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    DefaultButton(
                        function: () {
                          AdminCubit.get(context)
                              .deleteArticle(uid: model!.uid);
                        },
                        text: 'Delete',
                        containerheight:
                            MediaQuery.of(context).size.height * .045),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
