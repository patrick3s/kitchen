class AuthError {
  static String signin(String error){
    String errorText;
    switch(error){
      case "invalid-email":
      errorText = 'Endereço de email invalido.';
      break;
      case "user-disabled":
      errorText = "Usuario está desativado";
      break;
      case "user-not-found":
      errorText = "Usuario não encontrado";
      break;
      case "wrong-password":
      errorText = "A senha não é valida";
      break;
    }
    return errorText;
  }

  static String signup(String text){
    String errorText;
    switch(text){
      case "email-already-in-use":
      errorText = 'Email já existe';
      break;
      case "invalid-email":
      errorText = 'O endereço de email não é valido';
      break;
      case "operation-not-allowed":
      errorText = "contas de e-mail / senha não estão habilitadas";
    }
    return errorText;
  }
}



