import 'package:clothes_shop/bottomnav.dart';
import 'package:clothes_shop/components/component.dart';
import 'package:clothes_shop/modules/login/cubit/cubit.dart';
import 'package:clothes_shop/modules/login/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cache.dart';

class OtpPage extends StatelessWidget {
  String verificationId;
  String phone;
  OtpPage({required this.verificationId, required this.phone});
  @override
  Widget build(BuildContext context) {
    var otpcontroller = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is VerifyOtpSuccessState) {
          LoginCubit.get(context).adduser_phone(phone);
        } else if (state is VerifyOtpErrorState) {
          showToast(text: 'كود التفعيل خطأ', colors: Colors.red);
        }
        if (state is AddPhoneSuccessState) {
          CacheHelper.setdata(key: 'userid', value: state.uid).then((value) {
            navigateandfinish(context: context, widget: BottomNav());
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  DefaultFormField(
                      controller: otpcontroller,
                      label: 'enter code',
                      prefixicon: Icons.message,
                      texttype: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'code can\'t be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  ConditionalBuilder(
                      condition: state is! AddPhoneloadingState,
                      builder: (context) => DefaultButton(
                          containerheight:
                              MediaQuery.of(context).size.height * .05,
                          function: () {
                            if (formkey.currentState!.validate()) {
                              LoginCubit.get(context).verifyotp(
                                  verificationId: verificationId,
                                  smsCode: otpcontroller.text);
                            }
                          },
                          text: 'الاستمرار'),
                      fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
