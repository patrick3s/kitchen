

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:multidelivery/shared/auth/apple_sign.dart';
import 'package:multidelivery/shared/auth/facebook_sign.dart';
import 'package:multidelivery/shared/auth/google_sign.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/src/domain/erros/auth.dart';
import 'package:multidelivery/src/infra/models/cart.dart';
import 'package:multidelivery/src/infra/models/usermodel.dart';



enum STATUSUSER {IDLE ,LOADING , LOGGED, WITHOUTDATA, ERROR ,UNLOGGED , CONNECTION}

class AuthUser {
  User user;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _googleSign = GoogleSignAuth();
  final status = ValueNotifier(STATUSUSER.IDLE);
  final _apple = AppleSignInAuth();
  final _facebook = FacebookSignInAuth();
  UserModel userModel;
  final Config config;
  final CartModel _cart;
  AuthUser(this.config,this._cart){
    config.showLog('AuthUser iniciado');
    
    _loadUser();
  }

  Future<void>signout()async{
    await _auth.signOut();
    userModel = null;
    await _googleSign.signout();
    await _facebook.singout();
    _cart.clearCart();
    status.value = STATUSUSER.UNLOGGED;
  }
  signinGoogle()async{
    status.value = STATUSUSER.LOADING;
    try{
      user =await _googleSign.login();  
    }catch(e){
      status.value = STATUSUSER.UNLOGGED;
      print(e);
      return "Desculpe houve um erro";
    }
    if(user != null){
      config.showLog('Login com google foi um sucesso.');
      await _loadUser();
      return;
    }
    status.value = STATUSUSER.UNLOGGED;
    config.showLog('Login com google sem sucesso.');
    return 'Falha ao realizar login';
  }

  signinApple()async{
    status.value = STATUSUSER.LOADING;
    AuthAppleResponse response;
    try{
      response =await _apple.login();  
    }catch(e){
      status.value = STATUSUSER.UNLOGGED;
      print(e);
      return "Desculpe houve um erro";
    }
    if(response.error == true){
      status.value = STATUSUSER.UNLOGGED;
       config.showLog('Error no login com a apple');
      return response.errorMsg;
    }
    if(response.user != null){
      user = response.user;
      await _loadUser();
      config.showLog('Login com apple foi um sucesso.');
      return;
    }
    status.value = STATUSUSER.UNLOGGED;
    config.showLog('Login com apple sem sucesso.');
    return 'Falha ao realizar login';
  }
   signinFacebook()async{
    status.value = STATUSUSER.LOADING;
    FacebookResponse response;
    try{
      response =await _facebook.login();  
    }catch(e){
      status.value = STATUSUSER.UNLOGGED;
      print(e);
      return "Desculpe houve um erro";
    }
    if(response.error == true){
      status.value = STATUSUSER.UNLOGGED;
       config.showLog('Error no login com a apple');
      return response.errorMsg;
    }
    if(response.user != null){
      user = response.user;
      await _loadUser();
      config.showLog('Login com apple foi um sucesso.');
      return;
    }
    status.value = STATUSUSER.UNLOGGED;
    config.showLog('Login com apple sem sucesso.');
    return 'Falha ao realizar login';
  }

  Future<String>singin(Map map)async{
    status.value = STATUSUSER.LOADING;
    try{
      final result = await _auth.signInWithEmailAndPassword(email: map['email'], password: map['password']);
      user = result.user;
      await _loadUser();
      config.showLog('Logado com sucesso');
      return null;
    }on FirebaseException catch(e){
      status.value = STATUSUSER.UNLOGGED;
      config.showLog('Firebase Excption \n ${e.code}');
      return AuthError.signin(e.code);
    }catch(e){
      status.value = STATUSUSER.UNLOGGED;
      config.showLog('Erro desconheido');
      return "Desculpe houve um erro, tente novamente mais tarde";
    }
  }

  Future<String>singup(Map<String,dynamic> map)async{
    status.value = STATUSUSER.LOADING;
    final _usermodel = UserModel.fromMap(map);
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: map['email'], password: map['password']);
      user = result.user;
      userModel = _usermodel;
      await _saveToken();
      status.value = STATUSUSER.WITHOUTDATA;
      config.showLog('Conta criada com sucesso');
      return null;
    }on FirebaseException catch(e){
      status.value = STATUSUSER.UNLOGGED;
      config.showLog('FirebaseException \n ${e.code}');
      return AuthError.signup(e.code);
  }catch(e){
    status.value = STATUSUSER.UNLOGGED;
    config.showLog('Erro desconhecido ');
    return "Desculpe houve um erro, tente novamente mais tarde";
  }
  }

  register(Map<String,dynamic> map)async{
    status.value = STATUSUSER.LOADING;
    try{
      final _userModel = UserModel.fromMap(map);
       _firestore.collection('users').doc(user.uid).set(map);
      userModel = _userModel;
      status.value = STATUSUSER.LOGGED;
      config.showLog('Dados do usuario gravado com sucesso');
    }catch(e){
      status.value = STATUSUSER.WITHOUTDATA;
      config.showLog('Erro $e');
    }
  }
  loadUser()async{
    await _loadUser();
  }

  Future<void> _loadUser()async{
      status.value = STATUSUSER.LOADING;
      if(await config.isConnection() == false){
        status.value = STATUSUSER.CONNECTION;
        return;
      }
      user =_auth.currentUser;
      if(user == null){
        status.value = STATUSUSER.UNLOGGED;
        config.showLog('Nenhum usuario conectado');
      }else{
        try{
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if(doc.exists){
        final  _usermodel = UserModel.fromMap(doc.data());
        userModel = _usermodel;
        userModel.id = user.uid;
        await _saveToken();
        status.value = STATUSUSER.LOGGED;
        config.showLog('Dados do usuario obtido');
      }else{
        status.value = STATUSUSER.WITHOUTDATA;
        config.showLog('Usuario não contém dados registrados no banco');
      }
      }catch(e){
        status.value = STATUSUSER.ERROR;
        config.showLog('Erro ao obter dados do usuario \n ${e.toString()}');
      } 
      }
  }

  Future<void> _saveToken() async {
    final fcm = FirebaseMessaging.instance;
    var token = await fcm.getToken();
    await _firestore.collection('users').doc(user.uid).collection('tokens').doc(token).set(
      {
        'token':token,
        'createAt':DateTime.now().millisecondsSinceEpoch,
        'device':Platform.isAndroid ? "Android": Platform.isWindows ?"Windows" :"IOS" 
      }
    );
    config.showLog('Token salvo no banco de dados');
}
}