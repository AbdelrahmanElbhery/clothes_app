import 'package:clothes_shop/modules/admin/cubit/cubit.dart';
import 'package:clothes_shop/modules/admin/cubit/states.dart';
import 'package:clothes_shop/modules/admin/show_users.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../components/component.dart';
import '../../models/productmodel.dart';
import 'inside_user_products.dart';

class UserFavourites extends StatelessWidget {
  String? username;
  UserFavourites({required this.username});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                navigateandfinish(context: context, widget: ShowUsers());
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            elevation: 0,
            title: Text(
              username!,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                  fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
          ),
          body: ConditionalBuilder(
            condition: AdminCubit.get(context).favouriteproducts.length > 0,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: MediaQuery.of(context).size.height *
                            0.175 /
                            MediaQuery.of(context).size.width *
                            1.6,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: AdminCubit.get(context)
                            .favouriteproducts
                            .map((e) => gridStructure(context, e))
                            .toList())
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(
                child: Text(
              'لا يوجد منتجات مفضلة',
              style: Theme.of(context).textTheme.headline6,
            )),
          ),
        );
      },
    );
  }

  Widget gridStructure(context, ProductModel model) => InkWell(
        onTap: () {
          navigate_to(context: context, widget: InsideUserProducts(model));
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 6,
          child: Container(
            height: MediaQuery.of(context).size.height * .1,
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  height: MediaQuery.of(context).size.height * .22,
                  image: NetworkImage(model.mainimage!),
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        model.title!,
                        textDirection: TextDirection.rtl,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            model.minnumber.toString(),
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Spacer(),
                          IconButton(
                            alignment: AlignmentDirectional.topCenter,
                            onPressed: () {},
                            icon: Icon(
                              MdiIcons.heart,
                              size: 20,
                              color: Colors.red,
                            ),
                            visualDensity:
                                VisualDensity(horizontal: -2, vertical: -2),
                          )
                        ],
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
