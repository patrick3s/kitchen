//https://getemoji.com/



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
final listStats = ['Aguardando resposta','Seu pedido está sendo preparado','Seu pedido está indo até você','Pedido concluido'];
