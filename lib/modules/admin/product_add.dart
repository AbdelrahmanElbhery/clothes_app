import 'package:clothes_shop/modules/admin/admin_home.dart';
import 'package:clothes_shop/modules/admin/cubit/cubit.dart';
import 'package:clothes_shop/modules/admin/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/component.dart';

class ProductAdd extends StatelessWidget {
  const ProductAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titlecontroller = TextEditingController();
    var detailscontroller = TextEditingController();
    var piecepricecontroller = TextEditingController();
    var minnumbercontroller = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is AddClothesProductSuccess) {
          AdminCubit.get(context).mainimage = null;
          AdminCubit.get(context).secondimage = null;
          AdminCubit.get(context).thirdimage = null;
          titlecontroller.clear();
          detailscontroller.clear();
          piecepricecontroller.clear();
          minnumbercontroller.clear();
          showToast(text: 'تم اضافة المنتج ', colors: Colors.green);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
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
              'Admin',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                  fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
            actions: [
              TextButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      AdminCubit.get(context).uploadProductImages(
                          price_piece: double.parse(piecepricecontroller.text),
                          minnumber: int.parse(minnumbercontroller.text),
                          title: titlecontroller.text,
                          details: detailscontroller.text);
                    }
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(fontSize: 18),
                  )),
              SizedBox(
                width: 10,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (state is ImagesUploadLoading)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                    if (state is ImagesUploadLoading)
                      CircularProgressIndicator(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    InkWell(
                      onTap: () {
                        AdminCubit.get(context).getmainImage();
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          child: Image(
                            image: AdminCubit.get(context).mainimage != null
                                ? FileImage(AdminCubit.get(context).mainimage!)
                                    as ImageProvider
                                : AssetImage('assets/images/empty.png'),
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            AdminCubit.get(context).getsecondImage();
                          },
                          child: Container(
                              height: MediaQuery.of(context).size.height * .1,
                              width: MediaQuery.of(context).size.width * .3,
                              child: Image(
                                image:
                                    AdminCubit.get(context).secondimage != null
                                        ? FileImage(AdminCubit.get(context)
                                            .secondimage!) as ImageProvider
                                        : AssetImage('assets/images/empty.png'),
                                fit: BoxFit.cover,
                              )),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .1,
                        ),
                        InkWell(
                          onTap: () {
                            AdminCubit.get(context).getthirdImage();
                          },
                          child: Container(
                              height: MediaQuery.of(context).size.height * .1,
                              width: MediaQuery.of(context).size.width * .3,
                              child: Image(
                                image: AdminCubit.get(context).thirdimage !=
                                        null
                                    ? FileImage(
                                            AdminCubit.get(context).thirdimage!)
                                        as ImageProvider
                                    : AssetImage('assets/images/empty.png'),
                                fit: BoxFit.cover,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    DefaultFormField(
                      controller: titlecontroller,
                      label: 'title',
                      validate: (validate) {
                        if (validate == '') {
                          return 'title can\'t be empty';
                        }
                        return null;
                      },
                      prefixicon: Icons.title,
                      texttype: TextInputType.text,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    DefaultFormField(
                      maxlines: 5,
                      controller: detailscontroller,
                      label: 'details',
                      validate: (validate) {
                        if (validate == '') {
                          return 'details can\'t be empty';
                        }
                        return null;
                      },
                      prefixicon: Icons.info_outline,
                      texttype: TextInputType.text,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    DefaultFormField(
                      controller: piecepricecontroller,
                      label: 'price of piece',
                      validate: (validate) {
                        if (validate == '') {
                          return 'price of piece can\'t be empty';
                        }
                        return null;
                      },
                      prefixicon: Icons.price_change,
                      texttype: TextInputType.phone,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    DefaultFormField(
                      controller: minnumbercontroller,
                      label: 'minimum number to buy ',
                      validate: (validate) {
                        if (validate == '') {
                          return 'minimum number can\'t be empty';
                        }
                        return null;
                      },
                      prefixicon: Icons.price_change,
                      texttype: TextInputType.phone,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
