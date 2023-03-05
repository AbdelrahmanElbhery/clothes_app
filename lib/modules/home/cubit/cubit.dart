import 'package:bloc/bloc.dart';
import 'package:clothes_shop/models/articlemodel.dart';
import 'package:clothes_shop/modules/favourites/favourites.dart';
import 'package:clothes_shop/modules/home/cubit/states.dart';
import 'package:clothes_shop/modules/home/home.dart';
import 'package:clothes_shop/modules/product/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../models/productmodel.dart';
import '../../informations/settings.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialStates());
  static HomeCubit get(context) => BlocProvider.of(context);
  int count = 0;
  List<Widget> screens = [
    Home(),
    Products(),
    Favourites(),
    SettingsAbout(),
  ];
  void change_Bottom(int index) {
    count = index;
    emit(HomeBottomChangeSuccesStates());
  }

  Future<void> googlelogout() async {
    await GoogleSignIn().signOut();
    emit(HomeGoogleSingOutSuccesStates());
  }

  Future<void> facebooklogout() async {
    await FacebookAuth.instance.logOut();
    emit(HomeFacebookSingOutStates());
  }

  List<ProductModel> products = [];
  void getProducts() {
    emit(GetProductsLoading());
    products = [];
    FirebaseFirestore.instance.collection('products').get().then((value) {
      value.docs.forEach((element) {
        products.add(ProductModel.fromJson(element.data()));
      });
      print(products.where((element) => element.uid == products[0].uid));
      emit(GetProductsSuccess());
    }).catchError((error) {
      print(error);
      emit(GetProductsError());
    });
  }

  void getOneProduct(String id) {
    emit(GetProductsLoading());
    FirebaseFirestore.instance.collection('products').doc().get().then((value) {
      emit(GetProductsSuccess());
    }).catchError((error) {
      print(error);
      emit(GetProductsError());
    });
  }

  List<ArticleModel> articles = [];
  void getArticles() {
    emit(GetArticlesLoading());
    articles = [];
    FirebaseFirestore.instance.collection('articles').get().then((value) {
      value.docs.forEach((element) {
        articles.add(ArticleModel.fromJson(element.data()));
      });
      emit(GetArticlesSuccess());
    }).catchError((error) {
      print(error);
      emit(GetArticlesError());
    });
  }

  void addFav(
    ProductModel model,
    userid,
  ) {
    emit(AddProductFavouriteLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .collection('favourites')
        .doc(model.uid)
        .set({'uid': model.uid}).then((value) {
      getFavid(userid);
      getFav(userid);
      emit(AddProductFavouriteSuccess());
    }).catchError((error) {
      print(error);
      emit(AddProductFavouriteError());
    });
  }

  List<String> favouriteid = [];
  List<ProductModel> favouriteproducts = [];
  void getFavid(uid) {
    if (uid != null) {
      favouriteid = [];
      emit(GetProductFavouriteIdLoading());
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('favourites')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          favouriteid.add(element.id);
        });
        print(favouriteproducts[0].uid);
        emit(GetProductFavouriteIdSuccess());
      }).catchError((error) {
        print(error);
        emit(GetProductFavouriteIdError());
      });
    }
  }

  void getFav(uid) {
    if (uid != null) {
      favouriteproducts = [];
      emit(GetProductFavouriteLoading());
      FirebaseFirestore.instance.collection('products').get().then((value) {
        value.docs.forEach((element) {
          if (favouriteid.contains(element.id)) {
            print(element.id);
            print(element.data());
            favouriteproducts.add(ProductModel.fromJson(element.data()));
          }
        });
        print(favouriteproducts.length);
        emit(GetProductFavouriteSuccess());
      }).catchError((error) {
        print(error);
        emit(GetProductFavouriteError());
      });
    }
  }

  void removeFav(productuid, userid) {
    emit(DeleteProductFavouriteLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .collection('favourites')
        .doc(productuid)
        .delete()
        .then((value) {
      getFavid(userid);
      getFav(userid);
      emit(DeleteProductFavouriteSuccess());
    }).catchError((error) {
      print(error);
      emit(DeleteProductFavouriteError());
    });
  }

  bool changefav = false;

  bool checkiscontain(context, ProductModel model) {
    changefav = false;
    favouriteproducts.forEach((element) {
      if (element.uid == model.uid) {
        changefav = true;
      }
    });
    return changefav!;
  }
}
