class Validators {
  static String mandatory(String text){
    if(text.isEmpty){
      return 'Campo obrigatório';
    }
    return null;
  }
  static String email(String text){
    if(text.isEmpty){
      return 'Campo obrigatório';
    }
    if(!text.contains('@')){
      return "Email invalido";
    }
    return null;
  }
  static String birthday(String text){
    if(text.isEmpty){
      return 'Informe sua data de nascimento';
    }
    if(text.length < 10){
      return 'Data invalida';
    }
    return null;
  }
  static String phoneNumber(String text){
    if(text.isEmpty){
      return 'Campo obrigatorio';
    }
    if(text.length < 15){
      return 'Número invalido';
    }
    return null;
  }

  static String password(String text){
    if(text.isEmpty){
      return 'Campo obrigatorio';
    }
    if(text.length < 6){
      return 'Senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

}