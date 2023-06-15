import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clothes_shop/components/component.dart';
import 'package:clothes_shop/models/productmodel.dart';
import 'package:clothes_shop/modules/home/cubit/cubit.dart';
import 'package:clothes_shop/modules/home/cubit/states.dart';
import 'package:clothes_shop/modules/login/cubit/cubit.dart';
import 'package:clothes_shop/modules/product/inside_product.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../shared/const.dart';
import '../articles/articles.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'assets/images/clothes.jpg',
      'assets/images/clothes2.jpg',
      'assets/images/clothes3.jpg'
    ];
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
          condition: LoginCubit.get(context).usermodel?.name != null,
          builder: (context) => ConditionalBuilder(
            condition: state is! GetProductsLoading,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CarouselSlider.builder(
                      options: CarouselOptions(
                          autoPlay: true,
                          autoPlayAnimationDuration: const Duration(seconds: 1),
                          scrollDirection: Axis.horizontal,
                          height: 250,
                          reverse: false,
                          initialPage: 0,
                          autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                          viewportFraction: 1,
                          autoPlayInterval: const Duration(seconds: 3),
                          enableInfiniteScroll: true),
                      itemCount: images.length,
                      itemBuilder: (context, index, pageindex) => Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Image(
                            image: AssetImage(images[index]),
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        navigate_to(
                            context: context, widget: const ArticlesScreen());
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.lightBlueAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: const AssetImage(
                                      'assets/images/clothes.jpg'),
                                  fit: BoxFit.cover,
                                  width:
                                      MediaQuery.of(context).size.width * .32,
                                  height:
                                      MediaQuery.of(context).size.height * .18,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .03,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        textDirection: TextDirection.rtl,
                                        'تابع احدث الاخبار والمقالات عن الملابس',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .11,
                                        child: const Text(
                                          'احصل على العديد من المعلومات الرائعة عن الاقمشة ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                          maxLines: 2,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        HomeCubit.get(context).change_Bottom(1);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.blue,
                          ),
                          Text(
                            textDirection: TextDirection.rtl,
                            'عرض كل المنتجات',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (HomeCubit.get(context).products.length > 1)
                      GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 10,
                        childAspectRatio:
                            MediaQuery.of(context).size.aspectRatio * 1.42,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: [
                          gridStructure(context, cubit.products[0]),
                          gridStructure(context, cubit.products[1]),
                        ],
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
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
                  height: MediaQuery.of(context).size.height * .20,
                  image: NetworkImage(model.mainimage!),
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AutoSizeText(
                        model.title!,
                        textDirection: TextDirection.rtl,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            model.price_piece.toString(),
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 15),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Spacer(),
                          IconButton(
                            alignment: AlignmentDirectional.topCenter,
                            onPressed: () {
                              HomeCubit.get(context)
                                  .checkiscontain(context, model);
                              if (HomeCubit.get(context).changefav) {
                                HomeCubit.get(context)
                                    .removeFav(model.uid, uidfav);
                              } else {
                                HomeCubit.get(context).addFav(model, uidfav);
                              }
                            },
                            icon: Icon(
                              MdiIcons.heart,
                              size: 20,
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
