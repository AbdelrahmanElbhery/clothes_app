import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../components/component.dart';
import '../../models/productmodel.dart';
import '../../shared/const.dart';
import '../home/cubit/cubit.dart';
import '../home/cubit/states.dart';
import '../product/inside_product.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).favouriteid.length > 0,
          builder: (context) => ConditionalBuilder(
            condition: state is! GetProductFavouriteLoading,
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
                        children: HomeCubit.get(context)
                            .favouriteproducts
                            .map((e) => gridStructure(context, e))
                            .toList())
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
          fallback: (context) => Center(
              child: Text(
            'اضف منتجاتك المفضلة',
            style: Theme.of(context).textTheme.headline6,
          )),
        );
      },
    );
  }

  Widget gridStructure(context, ProductModel model) => InkWell(
        onTap: () {
          navigate_to(context: context, widget: InProduct(model));
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
                            onPressed: () {
                              HomeCubit.get(context)
                                  .removeFav(model.uid, uidfav);
                            },
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
