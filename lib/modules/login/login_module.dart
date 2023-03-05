import 'package:clothes_shop/modules/admin/admin_home.dart';
import 'package:clothes_shop/modules/login/cubit/cubit.dart';
import 'package:clothes_shop/modules/update%20info.dart';
import 'package:clothes_shop/shared/cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../bottomnav.dart';
import '../../components/component.dart';
import '../../shared/const.dart';
import 'cubit/states.dart';

class ShopLogin extends StatelessWidget {
  const ShopLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginFacebookErrorState) {
          showToast(text: state.error, colors: Colors.red);
        } else if (state is LoginGoogleSinginErrorStates) {
          showToast(text: state.error, colors: Colors.red);
        } else if (state is GetUserDataSuccess) {
          if (LoginCubit.get(context).usermodel?.phone != null) {
            CacheHelper.setdata(key: 'userid', value: state.uid).then((value) {
              navigateandfinish(context: context, widget: BottomNav());
            });
          } else {
            CacheHelper.setdata(key: 'mobileid', value: state.uid)
                .then((value) {
              navigateandfinish(context: context, widget: InfoComplete());
            });
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Card(
                    child: Image(
                        height: MediaQuery.of(context).size.height * .24,
                        width: MediaQuery.of(context).size.width * .5,
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/clothes_logo.png')),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    'اضف معلومات الدخول',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.transparent),
                      color: Colors.blue,
                    ),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            LoginCubit.get(context).singinwithgoogle();
                          },
                          height: 35,
                          child: Text('الدخول باستخدام جوجل',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white)),
                        ),
                        Icon(
                          MdiIcons.gmail,
                          color: Colors.white,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.transparent),
                      color: Colors.blue,
                    ),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            LoginCubit.get(context).facebooksignin();
                          },
                          height: 35,
                          child: Text('الدخول باستخدام فيس بوك',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white)),
                        ),
                        Icon(
                          MdiIcons.facebook,
                          color: Colors.white,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DefaultButton(
                      function: () {
                        navigateandfinish(
                            context: context, widget: AdminHome());
                      },
                      text: 'تخطي',
                      color: Colors.white,
                      textcolor: Colors.blue,
                      bordercolor: Colors.blue,
                      height: 30,
                      containerheight: 50,
                      radius: 40),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  if (state is GetUserDataLoading) CircularProgressIndicator()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
