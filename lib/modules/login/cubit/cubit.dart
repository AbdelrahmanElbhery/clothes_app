import 'package:clothes_shop/models/usermodel.dart';
import 'package:clothes_shop/modules/login/cubit/states.dart';
import 'package:clothes_shop/shared/cache.dart';
import 'package:clothes_shop/shared/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../models/Register.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialStates());
  static LoginCubit get(context) => BlocProvider.of(context);

  GoogleSignIn googlesingin = GoogleSignIn(scopes: ['email']);
  FacebookLogin facebookLogin = FacebookLogin();
  UserModel? usermodel;
  Future<void> singinwithgoogle() async {
    emit(LoginGoogleSinginLoadingStates());
    try {
      String? uid;
      GoogleSignInAccount? googleaccount = await googlesingin.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleaccount!.authentication;
      if (googleSignInAuthentication.accessToken != null &&
          googleSignInAuthentication.idToken != null) {
        AuthCredential googleauth = await GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        UserCredential usercreate =
            await FirebaseAuth.instance.signInWithCredential(googleauth);
        if (usercreate.user != null) {
          if (usercreate.additionalUserInfo!.isNewUser) {
            userCreate(
                email: usercreate.user?.email,
                uid: usercreate.user?.uid,
                name: usercreate.user?.displayName,
                image: usercreate.user?.photoURL,
                phone: usercreate.user?.phoneNumber);
          }
        }
        CacheHelper.setdata(key: 'google_id', value: '1');
        emit(LoginGoogleSinginSuccesStates(usercreate.user?.uid));
        uid = usercreate.user?.uid;
      }
      getUserData(uid);
    } catch (error) {
      print(error);
      emit(LoginGoogleSinginErrorStates(error.toString()));
    }
  }

  Future<void> facebooksignin() async {
    emit(LoginFacebookLoadingState());
    try {
      String? uid;
      final LoginResult result = await FacebookAuth.instance.login();
      print(result.accessToken!.userId);
      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken!.token;
        final faceauth = FacebookAuthProvider.credential(accessToken);
        UserCredential usercredential =
            await FirebaseAuth.instance.signInWithCredential(faceauth);
        print(usercredential.user);
        if (usercredential.additionalUserInfo!.isNewUser) {
          userCreate(
              email: usercredential.user?.email,
              uid: usercredential.user?.uid,
              name: usercredential.user?.displayName,
              image: usercredential.user?.photoURL,
              phone: usercredential.user?.phoneNumber);
        }
        CacheHelper.setdata(key: 'facebook_id', value: '1');
        uid = usercredential.user?.uid;
        getUserData(uid);
        emit(LoginFacebookSuccessState(usercredential.user?.uid));
      }
    } catch (error) {
      print(error);
      emit(LoginFacebookErrorState(error.toString()));
    }
  }

  Future<AccessToken?> facebookcondition() async {
    var result = await FacebookAuth.instance.accessToken;
    return result;
  }

  void userCreate(
      {@required String? email,
      @required String? uid,
      @required String? name,
      @required String? image,
      String? phone = ''}) {
    SocialRegisterModel socialregisterModel = SocialRegisterModel(
        email: email, name: name, image: image, uid: uid, phone: phone);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(socialregisterModel.todata())
        .then((value) {
      emit(LoginSuccessState(uid));
    }).catchError((error) {
      print(error);
      emit(LoginErrorState(error));
    });
  }

  void getUserData(id) {
    if (id != null) {
      emit(GetUserDataLoading());
      FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get()
          .then((value) {
        usermodel = UserModel.fromJson(value.data()!);
        print(usermodel?.name);
        print(usermodel?.email);
        uidfav = usermodel?.uid;
        emit(GetUserDataSuccess(id));
      }).catchError((error) {
        print(error);
        emit(GetUserDataerror(error.toString()));
      });
    }
  }

  String? verification;
  int? resendTok;
  Future<void> verifynumber(context, phone) async {
    emit(VerifyNumberLoadingState());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        print(e.code);
        emit(VerifyNumberErrorState(e.code));
      },
      codeSent: (String verificationId, int? resendToken) {
        verification = verificationId;
        resendTok = resendToken;
        emit(VerifyNumberSuccessState());
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifyotp({verificationId, smsCode}) async {
    emit(VerifyOtpLoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    FirebaseAuth.instance.currentUser
        ?.linkWithCredential(credential)
        .then((value) {
      emit(VerifyOtpSuccessState());
    }).catchError((error) {
      print(error);
      emit(VerifyOtpErrorState());
    });
  }

  void adduser_phone(phone) {
    emit(AddPhoneloadingState());
    UserModel updatedata = UserModel(
        phone: phone,
        uid: usermodel?.uid,
        email: usermodel?.email,
        name: usermodel?.name);
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel?.uid)
        .update(updatedata.toJson())
        .then((value) {
      emit(AddPhoneSuccessState(usermodel?.uid));
    }).catchError((error) {
      print(error);
      emit(AddPhoneErrorState());
    });
  }

  String country = '';
  void countryCode(String value) {
    country = value;
    emit(ChangeCountryState());
  }
}
