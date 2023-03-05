import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/component.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class Addarticle extends StatelessWidget {
  const Addarticle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titlecontroller = TextEditingController();
    var detailscontroller = TextEditingController();
    var piecepricecontroller = TextEditingController();
    var minnumbercontroller = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is AddArticleSuccess) {
          titlecontroller.clear();
          detailscontroller.clear();
          piecepricecontroller.clear();
          minnumbercontroller.clear();
          AdminCubit.get(context).articleimage = null;
          showToast(text: 'تم اضافة المنتج ', colors: Colors.green);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
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
                      AdminCubit.get(context).uploadarticleimage(
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
                    if (state is UploadArticleImageLoading)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                    if (state is UploadArticleImageLoading)
                      CircularProgressIndicator(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    InkWell(
                      onTap: () {
                        AdminCubit.get(context).getarticleImage();
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          child: Image(
                            image: AdminCubit.get(context).articleimage != null
                                ? FileImage(
                                        AdminCubit.get(context).articleimage!)
                                    as ImageProvider
                                : AssetImage('assets/images/empty.png'),
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
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
                      label: 'subject',
                      validate: (validate) {
                        if (validate == '') {
                          return 'details can\'t be empty';
                        }
                        return null;
                      },
                      prefixicon: Icons.info_outline,
                      texttype: TextInputType.multiline,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
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
