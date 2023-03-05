import 'package:clothes_shop/modules/admin/admin_home.dart';
import 'package:clothes_shop/modules/admin/edit_product.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/component.dart';
import '../../models/productmodel.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShowProductsAdmin extends StatelessWidget {
  const ShowProductsAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                navigateandfinish(context: context, widget: AdminHome());
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            elevation: 0,
            title: Text(
              'Products',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                  fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
          ),
          body: ConditionalBuilder(
            condition: state is! GetProductsLoading,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                            .products
                            .map((e) => gridStructure(context, e))
                            .toList())
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget gridStructure(context, ProductModel model) => InkWell(
        onTap: () {
          navigate_to(context: context, widget: EditProduct(model));
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
                              Icons.favorite_outline,
                              size: 20,
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
