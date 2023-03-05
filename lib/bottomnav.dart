import 'package:clothes_shop/components/component.dart';
import 'package:clothes_shop/modules/home/cubit/cubit.dart';
import 'package:clothes_shop/modules/home/cubit/states.dart';
import 'package:clothes_shop/modules/login/cubit/cubit.dart';
import 'package:clothes_shop/modules/login/login_module.dart';
import 'package:clothes_shop/shared/cache.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetProductsLoading,
          builder: (context) => WillPopScope(
            onWillPop: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('تسجيل الخروج ؟',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl),
                  content: Text('هل تريد تسجيل الخروج ؟',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl),
                  actions: [
                    TextButton(
                        child: Text('نعم'),
                        onPressed: () {
                          if (CacheHelper.getdata(key: 'facebook_id') != null) {
                            HomeCubit.get(context).facebooklogout();
                            CacheHelper.removedata(key: 'facebook_id');
                            CacheHelper.removedata(key: 'userid');
                            navigateandfinish(
                                context: context, widget: ShopLogin());
                          } else if (CacheHelper.getdata(key: 'google_id') !=
                              null) {
                            HomeCubit.get(context).googlelogout();
                            CacheHelper.removedata(key: 'google_id');
                            CacheHelper.removedata(key: 'userid');
                            navigateandfinish(
                                context: context, widget: ShopLogin());
                          } else {
                            navigateandfinish(
                                context: context, widget: ShopLogin());
                          }
                        }),
                    TextButton(
                      child: Text('لا'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(
                    MdiIcons.logout,
                    color: Colors.blue,
                    size: 30,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('تسجيل الخروج ؟',
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl),
                        content: Text('هل تريد تسجيل الخروج ؟',
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl),
                        actions: [
                          TextButton(
                              child: Text('نعم'),
                              onPressed: () {
                                if (CacheHelper.getdata(key: 'facebook_id') !=
                                    null) {
                                  HomeCubit.get(context).facebooklogout();
                                  CacheHelper.removedata(key: 'facebook_id');
                                  CacheHelper.removedata(key: 'userid');
                                  navigateandfinish(
                                      context: context, widget: ShopLogin());
                                } else if (CacheHelper.getdata(
                                        key: 'google_id') !=
                                    null) {
                                  HomeCubit.get(context).googlelogout();
                                  CacheHelper.removedata(key: 'google_id');
                                  CacheHelper.removedata(key: 'userid');
                                  navigateandfinish(
                                      context: context, widget: ShopLogin());
                                } else {
                                  navigateandfinish(
                                      context: context, widget: ShopLogin());
                                }
                              }),
                          TextButton(
                            child: Text('لا'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                title: Text(
                  'مرحبا  ${LoginCubit.get(context).usermodel?.name}',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 23,
                      fontWeight: FontWeight.w500),
                ),
                centerTitle: true,
              ),
              body:
                  HomeCubit.get(context).screens[HomeCubit.get(context).count],
              bottomNavigationBar: BottomNavigationBar(
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.blue,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(MdiIcons.home), label: 'الرئيسية'),
                  BottomNavigationBarItem(
                      icon: Icon(MdiIcons.shopping), label: 'المنتجات'),
                  BottomNavigationBarItem(
                      icon: Icon(MdiIcons.heart), label: 'المفضلة'),
                  BottomNavigationBarItem(
                      icon: Icon(MdiIcons.information), label: ' من نحن'),
                ],
                onTap: (index) {
                  HomeCubit.get(context).change_Bottom(index);
                },
                currentIndex: HomeCubit.get(context).count,
              ),
            ),
          ),
          fallback: (context) => Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
