import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:clothes_shop/models/articlemodel.dart';
import 'package:clothes_shop/models/productmodel.dart';
import 'package:clothes_shop/modules/admin/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../models/usermodel.dart';

class AdminCubit extends Cubit<AdminStates> {
  String? articleid;

  AdminCubit() : super(AdminInitialState());

  static AdminCubit get(context) => BlocProvider.of(context);
  File? mainimage;
  var picker = ImagePicker();

  Future<void> getmainImage() async {
    final imagepick = await picker.pickImage(source: ImageSource.gallery);
    if (imagepick != null) {
      mainimage = File(imagepick.path);
      emit(GetMainImageSuccess());
    } else {
      print('error');
      emit(GetMainImageError());
    }
  }

  File? secondimage;

  Future<void> getsecondImage() async {
    final imagepick = await picker.pickImage(source: ImageSource.gallery);
    if (imagepick != null) {
      secondimage = File(imagepick.path);
      emit(GetSecondImageSuccess());
    } else {
      print('error');
      emit(GetSecondImageError());
    }
  }

  File? thirdimage;

  Future<void> getthirdImage() async {
    final imagepick = await picker.pickImage(source: ImageSource.gallery);
    if (imagepick != null) {
      thirdimage = File(imagepick.path);
      emit(GetThirdImageSuccess());
    } else {
      print('error');
      emit(GetThirdImageError());
    }
  }

  File? articleimage;

  Future<void> getarticleImage() async {
    final imagepick = await picker.pickImage(source: ImageSource.gallery);
    if (imagepick != null) {
      articleimage = File(imagepick.path);
      emit(GetThirdImageSuccess());
    } else {
      print('error');
      emit(GetThirdImageError());
    }
  }

  ProductModel? product;

  void addProduct({
    required double price_piece,
    required int minnumber,
    required String title,
    required String details,
    required String mainimage,
    required String secondimage,
    required String thirdimage,
  }) {
    emit(AddClothesProductLoading());
    ProductModel? addid;
    product = ProductModel(
        minnumber: minnumber,
        price_piece: price_piece,
        title: title,
        uid: '',
        details: details,
        mainimage: mainimage,
        secondimage: secondimage,
        thirdimage: thirdimage);
    FirebaseFirestore.instance
        .collection('products')
        .add(product!.todata())
        .then((value) {
      addid = ProductModel(
          minnumber: minnumber,
          price_piece: price_piece,
          title: title,
          uid: value.id,
          details: details,
          mainimage: mainimage,
          secondimage: secondimage,
          thirdimage: thirdimage);
      FirebaseFirestore.instance
          .collection('products')
          .doc(value.id)
          .update(addid!.todata())
          .then((value) {
        emit(FixIdProductSuccess());
      }).catchError((error) {
        print(error);
        emit(FixIdProductError());
      });
      print(value.id);
      getProducts();
      emit(AddClothesProductSuccess());
    }).catchError((error) {
      print(error);
      emit(AddClothesProductError());
    });
  }

  void uploadProductImages({
    required double price_piece,
    required int minnumber,
    required String title,
    required String details,
  }) {
    emit(ImagesUploadLoading());
    firebase_storage.FirebaseStorage.instance
        .ref('products/${Uri.file(mainimage!.path).pathSegments.last}')
        .putFile(mainimage!)
        .then((value) {
      value.ref.getDownloadURL().then((main) {
        print(main);
        firebase_storage.FirebaseStorage.instance
            .ref('products/${Uri.file(secondimage!.path).pathSegments.last}')
            .putFile(secondimage!)
            .then((value) {
          value.ref.getDownloadURL().then((second) {
            print(second);
            firebase_storage.FirebaseStorage.instance
                .ref('products/${Uri.file(thirdimage!.path).pathSegments.last}')
                .putFile(thirdimage!)
                .then((value) {
              value.ref.getDownloadURL().then((third) {
                addProduct(
                    price_piece: price_piece,
                    minnumber: minnumber,
                    title: title,
                    details: details,
                    mainimage: main,
                    secondimage: second,
                    thirdimage: third);
              }).catchError((error) {});
            }).catchError((error) {});
          }).catchError((error) {});
        }).catchError((error) {});
      }).catchError((error) {});
    }).catchError((error) {});
  }

  void uploadarticle({title, uid, details, articleimage}) {
    emit(AddArticleLoading());
    ArticleModel? art;
    ArticleModel article = ArticleModel(
        title: title,
        uid: uid,
        details: details,
        articleimage: articleimage,
        date: DateFormat.yMMMd().format(DateTime.now()));
    FirebaseFirestore.instance
        .collection('articles')
        .add(article.todata())
        .then((value) {
      FirebaseFirestore.instance
          .collection('articles')
          .doc(value.id)
          .update(ArticleModel(
                  title: title,
                  uid: value.id,
                  details: details,
                  date: DateFormat.yMMMd().format(DateTime.now()),
                  articleimage: articleimage)
              .todata())
          .then((value) {})
          .catchError((error) {
        print(error);
      });
      getArticles();
      emit(AddArticleSuccess());
    }).catchError((error) {
      print(error);
      emit(AddArticleError());
    });
  }

  void uploadarticleimage({title, uid, details}) {
    emit(UploadArticleImageLoading());
    firebase_storage.FirebaseStorage.instance
        .ref('articles/${Uri.file(articleimage!.path).pathSegments.last}')
        .putFile(articleimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        uploadarticle(
            title: title, details: details, uid: '', articleimage: value);
      }).catchError((error) {
        print(error);
        emit(UploadArticleImageError());
      });
    }).catchError((error) {
      print(error);
      emit(UploadArticleImageError());
    });
  }

  List<ProductModel> products = [];
  void getProducts() {
    emit(GetProductsLoading());
    products = [];
    FirebaseFirestore.instance.collection('products').get().then((value) {
      value.docs.forEach((element) {
        products.add(ProductModel.fromJson(element.data()));
      });
      emit(GetProductsSuccess());
    }).catchError((error) {
      print(error);
      emit(GetProductsError());
    });
  }

  void updateProduct({
    required double price_piece,
    required int minnumber,
    required String title,
    required String details,
    required String uid,
    required mainimage,
    required secondimage,
    required thirdimage,
  }) {
    emit(UpdateProductsLoading());
    FirebaseFirestore.instance
        .collection('products')
        .doc(uid)
        .update(ProductModel(
                price_piece: price_piece,
                title: title,
                uid: uid,
                details: details,
                minnumber: minnumber,
                mainimage: mainimage,
                secondimage: secondimage,
                thirdimage: thirdimage)
            .todata())
        .then((value) {
      emit(UpdateProductsSuccess());
    }).catchError((error) {
      print(error);
      emit(UpdateProductsError());
    });
  }

  void deleteProduct({required uid}) {
    emit(DeleteProductsLoading());
    FirebaseFirestore.instance
        .collection('products')
        .doc(uid)
        .delete()
        .then((value) {
      emit(DeleteProductsSuccess());
    }).catchError((error) {
      print(error);
      emit(DeleteProductsError());
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

  void updateArticle({
    required String title,
    required String details,
    required String uid,
    required articleimage,
  }) {
    emit(UpdateArticlesLoading());
    FirebaseFirestore.instance
        .collection('articles')
        .doc(uid)
        .update(ArticleModel(
                title: title,
                uid: uid,
                details: details,
                date: DateFormat.yMMMd().format(DateTime.now()),
                articleimage: articleimage)
            .todata())
        .then((value) {
      emit(UpdateArticlesSuccess());
    }).catchError((error) {
      print(error);
      emit(UpdateArticlesError());
    });
  }

  void deleteArticle({required uid}) {
    emit(DeleteArticlesLoading());
    FirebaseFirestore.instance
        .collection('articles')
        .doc(uid)
        .delete()
        .then((value) {
      emit(DeleteArticlesSuccess());
    }).catchError((error) {
      print(error);
      emit(DeleteArticlesError());
    });
  }

  List<UserModel> usersmodel = [];

  void getUsers() {
    emit(GetUsersLoading());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        usersmodel.add(UserModel.fromJson(element.data()));
      });
      emit(GetUsersSuccess());
    }).catchError((error) {
      print(error);
      emit(GetUsersError());
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
}
