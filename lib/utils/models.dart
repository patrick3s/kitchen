//https://getemoji.com/



import 'package:flutter/material.dart';

final utilPartner = <String,dynamic>{
  'name':"Steak",
  'city':'Águia Branca',
  'complement':'estabelecimento',
  'district':'Centro',
  'img':'https://i.pinimg.com/originals/c7/67/86/c767868e8629c9de094487dac4dcf804.png',
  'backgroundImg':'https://i.pinimg.com/originals/c7/67/86/c767868e8629c9de094487dac4dcf804.png',
  'numberHome':"20",
  'reference':'Praça do milhão',
  'street':'es 101',
  'uf':'ES',
  'phoneNumber':'(27) 99871-9607',
  'delivery':true,
  'deliveryTime':'30-20min',
  'deliveryPrice':2.5,
  'createAt':1625580900000,
  'averange':4.5,
  'specialtyCategory': utilCategory,
  'description':'descrição do parceiro',
  'categories':[utilCategory,utilCategorySalg,utilCategoryPizza],
  'products':[utilProd,utilProd]
};
final utilCategory = {
    'title':'Lanches',
    'emoji':'🍔'
  };
final utilCategoryPizza = {
    'title':'Pizzas',
    'emoji':'🍔'
  };

final utilCategorySalg = {
    'title':'Salgados',
    'emoji':'🍔'
  };

final utilOffer = <String,dynamic>{
  'city':'Águia Branca',
  'complement':'estabelecimento',
  'district':'Centro',
  'numberHome':"20",
  'reference':'Praça do milhão',
  'street':'es 101',
  'uf':'ES',
  'title':'Super Oferta',
  'discount':0,
  'product':utilProd,
  'price':10.50,
  'img':'https://i.pinimg.com/originals/c7/67/86/c767868e8629c9de094487dac4dcf804.png'
};
final utilProd = {
  'name':'X - Burguer',
  'price':12.50,
  'listAdditional':[utilAdditionalWithPrice,
  utilAdditionalWithPriceOneLimit,
  utilAdditionalWithoutPrice
  ],
  'img':"https://i.pinimg.com/originals/11/a5/5a/11a55a964c278eec04d849c5d312bfee.jpg",
  'partnerName':'Steak',
  'partnerId':'uZ3DIoHaT9rZGkLyGRkL',
  'partnerImg':'https://files.menudino.com/cardapios/15138/logo.png',
  'description':'Pão,hamburguer,batata palha, tomate, bacon,milho,ervilhas',
  'category':utilCategory
};

final utilProdSalg = {
  'name':'X - Burguer',
  'price':12.50,
  'listAdditional':[utilAdditionalWithPrice,
  utilAdditionalWithPriceOneLimit,
  utilAdditionalWithoutPrice
  ],
  'img':"https://i.pinimg.com/originals/11/a5/5a/11a55a964c278eec04d849c5d312bfee.jpg",
  'partnerName':'Steak',
  'partnerId':'uZ3DIoHaT9rZGkLyGRkL',
  'partnerImg':'https://files.menudino.com/cardapios/15138/logo.png',
  'description':'Pão,hamburguer,batata palha, tomate, bacon,milho,ervilhas',
  'category':utilCategorySalg
};

final utilProdPizza = {
  'name':'X - Burguer',
  'price':12.50,
  'listAdditional':[utilAdditionalWithPrice,
  utilAdditionalWithPriceOneLimit,
  utilAdditionalWithoutPrice
  ],
  'partnerName':'Steak',
  'img':'https://i.pinimg.com/originals/11/a5/5a/11a55a964c278eec04d849c5d312bfee.jpg',
  'partnerId':'uZ3DIoHaT9rZGkLyGRkL',
  'partnerImg':'https://files.menudino.com/cardapios/15138/logo.png',
  'description':'Pão,hamburguer,batata palha, tomate, bacon,milho,ervilhas',
  'category':utilCategoryPizza
};

final utilAdditionalWithPrice = {
  'title':'Cheddar',
  'limit':2,
  'description':'Cheddar inglês cremoso',
  'price':1.50
};

final utilAdditionalWithoutPrice = {
  'title':'Tomate',
  'limit':1,
  'description':'Cheddar inglês cremoso',
  'price':0.0
};

final utilAdditionalWithPriceOneLimit = {
  'title':'+ Bacon',
  'limit':1,
  'description':'Tiras de baicon bem passada',
  'price':1.5
};

final utilEvaluation = {
  'name':"Patrick",
  'createAt':DateTime.now().millisecondsSinceEpoch,
  'comment':'Muito bom, melhor da região',
  'averange':3.5,
  'aswer':'Agradecemos a preferencia',
  'userId':'1nAaWlJw6WUQZ5lq80drvZqMLk13',
  'partnerId':'MhdZmOqkcVPMznPUYMkX'
};

final weekdayList = ['Seg','Ter','Qua','Qui','Sex','Sab','Dom'];
final monthList = ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'];
final lastStatus = 3;
String listStats(int status, bool delivery){
  if(status == 2 && !delivery){
    return "Retire na loja";
  }
  final list = ['Aguardando resposta','Seu pedido está sendo preparado','Seu pedido está indo até você','Pedido concluido'];
  return list[status];
}

final List<List<Offset>> positions = [
  [
    Offset(0.63,.2),
    Offset(0.4,.3),
    Offset(0.25,.25),
    Offset(0.3,.43),
    Offset(0.5,.65)
  ],
  [
    Offset(0.35,.25),
    Offset(0.45,.35),
    Offset(0.6,.45),
    Offset(0.25,.53),
    Offset(0.5,.19)
  ],
  [
    Offset(0.28,.28),
    Offset(0.35,.48),
    Offset(0.41,.35),
    Offset(0.58,.53),
    Offset(0.61,.65)
  ],
  [
    Offset(0.25,.28),
    Offset(0.3,.33),
    Offset(0.46,.41),
    Offset(0.6,.53),
    Offset(0.52,.65)
  ],
  [
    Offset(0.42,.38),
    Offset(0.65,.42),
    Offset(0.21,.28),
    Offset(0.35,.53),
    Offset(0.5,.65)
  ],
  [
    Offset(0.515,.3),
    Offset(0.6,.4),
    Offset(0.46,.65),
    Offset(0.3,.2),
    Offset(0.2,.5)
  ],
  [
    Offset(0.6,.3),
    Offset(0.5,.4),
    Offset(0.31,.5),
    Offset(0.2,.7),
    Offset(0.41,6.0)
  ],
[
    Offset(0.41,.23),
    Offset(0.5,.4),
    Offset(0.3,.5),
    Offset(0.25,.6),
    Offset(0.6,.3)
  ],
[
    Offset(0.3,.6),
    Offset(0.6,.34),
    Offset(0.41,.28),
    Offset(0.5,.49),
    Offset(0.21,0.5)
  ],
  [
    Offset(0.3,.3),
    Offset(0.5,.4),
    Offset(0.4,.6),
    Offset(0.6,.4),
    Offset(0.25,.5)
  ],
];