import 'package:clothes_shop/modules/admin/show_products.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/component.dart';
import '../../models/productmodel.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class EditProduct extends StatelessWidget {
  ProductModel? model;
  EditProduct(@required this.model);
  @override
  Widget build(BuildContext context) {
    var titlecontroller = TextEditingController();
    var detailscontroller = TextEditingController();
    var piecepricecontroller = TextEditingController();
    var minnumbercontroller = TextEditingController();
    titlecontroller.text = model!.title!;
    detailscontroller.text = model!.details!;
    piecepricecontroller.text = model!.price_piece.toString();
    minnumbercontroller.text = model!.minnumber.toString();
    var formkey = GlobalKey<FormState>();
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is UpdateProductsSuccess) {
          showToast(text: 'Product Updated', colors: Colors.green);
          AdminCubit.get(context).getProducts();
        } else if (state is DeleteProductsSuccess) {
          showToast(text: 'Product Deleted', colors: Colors.green);
          navigateandfinish(context: context, widget: ShowProductsAdmin());
          AdminCubit.get(context).getProducts();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                navigateandfinish(
                    context: context, widget: ShowProductsAdmin());
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
                      AdminCubit.get(context).updateProduct(
                          price_piece: double.parse(piecepricecontroller.text),
                          minnumber: int.parse(minnumbercontroller.text),
                          title: titlecontroller.text,
                          details: detailscontroller.text,
                          uid: model!.uid!,
                          mainimage: model!.mainimage,
                          secondimage: model!.secondimage,
                          thirdimage: model!.thirdimage);
                    }
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(fontSize: 18),
                  )),
              SizedBox(
                width: 10,
              )
            ],
          ),
          backgroundColor: Colors.white,
          body: ConditionalBuilder(
            condition: state is! GetProductsLoading,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state is UpdateProductsLoading)
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                      if (state is UpdateProductsLoading)
                        CircularProgressIndicator(),
                      if (state is DeleteProductsLoading)
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                      if (state is DeleteProductsLoading)
                        CircularProgressIndicator(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * .2,
                          child: Image(
                            image: NetworkImage(model!.mainimage!),
                            fit: BoxFit.cover,
                          )),
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
                                  image: NetworkImage(model!.secondimage!),
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
                                  image: NetworkImage(model!.thirdimage!),
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      DefaultButton(
                          function: () {
                            AdminCubit.get(context)
                                .deleteProduct(uid: model!.uid);
                          },
                          text: 'Delete',
                          containerheight:
                              MediaQuery.of(context).size.height * .045),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
