import 'package:clothes_shop/models/productmodel.dart';
import 'package:clothes_shop/modules/home/cubit/cubit.dart';
import 'package:clothes_shop/modules/home/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:photo_view/photo_view.dart';

import '../../shared/const.dart';

class InProduct extends StatelessWidget {
  ProductModel? model;
  InProduct(@required this.model);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 1,
              ),
              Column(
                children: [
                  Image(
                    image: NetworkImage(model!.mainimage!),
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height * .53,
                  ),
                ],
              ),
              Positioned.fill(
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * .53,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60))),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  alignment: AlignmentDirectional.topCenter,
                                  onPressed: () {
                                    HomeCubit.get(context)
                                        .checkiscontain(context, model!);
                                    if (HomeCubit.get(context).changefav!) {
                                      print(HomeCubit.get(context)
                                          .favouriteproducts
                                          .contains(model));
                                      HomeCubit.get(context)
                                          .removeFav(model?.uid, uidfav);
                                    } else {
                                      print(HomeCubit.get(context)
                                          .favouriteproducts
                                          .contains(model));
                                      HomeCubit.get(context)
                                          .addFav(model!, uidfav);
                                    }
                                  },
                                  icon: Icon(
                                    MdiIcons.heart,
                                    size: 30,
                                    color: HomeCubit.get(context)
                                            .checkiscontain(context, model!)
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  visualDensity: VisualDensity(
                                      horizontal: -2, vertical: -2),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  model!.title!,
                                  textDirection: TextDirection.rtl,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FullScreenWidget(
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height * .1,
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    child: PhotoView(
                                      backgroundDecoration:
                                          BoxDecoration(color: Colors.white),
                                      imageProvider:
                                          NetworkImage(model!.secondimage!),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                FullScreenWidget(
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height * .1,
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    child: PhotoView(
                                      backgroundDecoration:
                                          BoxDecoration(color: Colors.white),
                                      imageProvider:
                                          NetworkImage(model!.thirdimage!),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              model!.details!,
                              textDirection: TextDirection.rtl,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'اقل كمية للطلب ${model!.minnumber!}',
                              textDirection: TextDirection.rtl,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              'سعر القطعة التجريبية ${model!.price_piece!}',
                              textDirection: TextDirection.rtl,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
