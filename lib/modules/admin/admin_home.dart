import 'package:clothes_shop/components/component.dart';
import 'package:clothes_shop/modules/admin/article_add.dart';
import 'package:clothes_shop/modules/admin/product_add.dart';
import 'package:clothes_shop/modules/admin/show_article.dart';
import 'package:clothes_shop/modules/admin/show_products.dart';
import 'package:clothes_shop/modules/admin/show_users.dart';
import 'package:clothes_shop/modules/login/login_module.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            navigateandfinish(context: context, widget: ShopLogin());
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        title: Text(
          'Admin',
          textDirection: TextDirection.rtl,
          style: TextStyle(
              color: Colors.blue, fontSize: 23, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        navigate_to(context: context, widget: ProductAdd());
                      },
                      child: Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          width: MediaQuery.of(context).size.width * .4,
                          child: Column(
                            children: [
                              Image(
                                  image:
                                      AssetImage('assets/images/clothes3.jpg'),
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.height * .15),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .01,
                              ),
                              Text(
                                'اضافة منتج',
                                style: Theme.of(context).textTheme.subtitle1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navigate_to(context: context, widget: ShowUsers());
                      },
                      child: Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          width: MediaQuery.of(context).size.width * .4,
                          child: Column(
                            children: [
                              Image(
                                  image:
                                      AssetImage('assets/images/clothes3.jpg'),
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.height * .15),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .01,
                              ),
                              Text(
                                'العملاء',
                                style: Theme.of(context).textTheme.subtitle1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        navigate_to(
                            context: context, widget: ShowProductsAdmin());
                      },
                      child: Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          width: MediaQuery.of(context).size.width * .4,
                          child: Column(
                            children: [
                              Image(
                                  image:
                                      AssetImage('assets/images/clothes3.jpg'),
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.height * .15),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .01,
                              ),
                              Text(
                                'تعديل منتج',
                                style: Theme.of(context).textTheme.subtitle1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navigate_to(context: context, widget: Addarticle());
                      },
                      child: Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          width: MediaQuery.of(context).size.width * .4,
                          child: Column(
                            children: [
                              Image(
                                  image:
                                      AssetImage('assets/images/clothes3.jpg'),
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.height * .15),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .01,
                              ),
                              Text(
                                'اضافة مقالة',
                                style: Theme.of(context).textTheme.subtitle1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                InkWell(
                  onTap: () {
                    navigate_to(context: context, widget: ShowArticlesAdmin());
                  },
                  child: Card(
                    elevation: 10,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.width * .4,
                      child: Column(
                        children: [
                          Image(
                              image: AssetImage('assets/images/clothes3.jpg'),
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height * .15),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Text(
                            'تعديل مقالة',
                            style: Theme.of(context).textTheme.subtitle1,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
