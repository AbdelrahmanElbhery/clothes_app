import 'package:clothes_shop/modules/home/cubit/cubit.dart';
import 'package:clothes_shop/modules/home/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../components/component.dart';
import '../../models/productmodel.dart';
import '../../shared/const.dart';
import 'inside_product.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio:
                        MediaQuery.of(context).size.aspectRatio * 1.38,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: HomeCubit.get(context)
                        .products
                        .map((e) => gridStructure(context, e))
                        .toList())
              ],
            ),
          ),
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
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  height: MediaQuery.of(context).size.height * .2,
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
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            model.minnumber.toString(),
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 15),
                          ),
                          IconButton(
                            alignment: AlignmentDirectional.topCenter,
                            onPressed: () {
                              HomeCubit.get(context)
                                  .checkiscontain(context, model);
                              if (HomeCubit.get(context).changefav!) {
                                print(HomeCubit.get(context)
                                    .favouriteproducts
                                    .contains(model));
                                HomeCubit.get(context)
                                    .removeFav(model.uid, uidfav);
                              } else {
                                print(HomeCubit.get(context)
                                    .favouriteproducts
                                    .contains(model));
                                HomeCubit.get(context).addFav(model, uidfav);
                              }
                            },
                            icon: Icon(
                              MdiIcons.heart,
                              size: 19,
                              color: HomeCubit.get(context)
                                      .checkiscontain(context, model)
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                            visualDensity: const VisualDensity(
                                horizontal: -2, vertical: -2),
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
