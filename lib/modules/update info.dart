import 'package:clothes_shop/modules/login/cubit/cubit.dart';
import 'package:clothes_shop/modules/login/cubit/states.dart';
import 'package:clothes_shop/modules/login/login_module.dart';
import 'package:clothes_shop/shared/cache.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/component.dart';
import 'otp_verify.dart';

class InfoComplete extends StatelessWidget {
  const InfoComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phonecontroller = TextEditingController();
    var formkey = GlobalKey<FormState>();
    String? phone;
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is VerifyNumberErrorState) {
          showToast(text: state.error, colors: Colors.red);
        } else if (state is VerifyNumberSuccessState) {
          navigate_to(
              context: context,
              widget: OtpPage(
                verificationId: LoginCubit.get(context).verification!,
                phone: phone!,
              ));
        }
      },
      builder: (context, state) {
        phonecontroller.text = LoginCubit.get(context).country;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  CacheHelper.removedata(key: 'userid').then((value) {
                    navigateandfinish(context: context, widget: ShopLogin());
                  });
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'إضافة رقم هاتف',
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      Text(
                        'الرجاء إضافة رقم هاتف للإستمرار',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DropdownSearch<String>(
                        popupProps: PopupProps.menu(
                          showSelectedItems: true,
                        ),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                                hintText: 'Choose Your Country')),
                        items: [
                          'EGYPT +20',
                          'SAUDI ARABIA +966',
                          'BAHRAIN +973',
                          'UNITED ARAB EMIRATES +971',
                        ],
                        onChanged: (value) {
                          print(value!
                              .substring(value.indexOf('+'), value.length));
                          LoginCubit.get(context).countryCode(value!
                              .substring(value.indexOf('+'), value.length));
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DefaultFormField(
                          controller: phonecontroller,
                          label: 'Phone',
                          prefixicon: Icons.phone,
                          texttype: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Phone can\'t be empty';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                        condition: state is! VerifyNumberLoadingState,
                        builder: (context) => DefaultButton(
                            containerheight:
                                MediaQuery.of(context).size.height * .05,
                            function: () {
                              if (formkey.currentState!.validate()) {
                                phone = phonecontroller.text;
                                LoginCubit.get(context).verifynumber(
                                    context, phonecontroller.text);
                              }
                            },
                            text: 'التالي'),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
