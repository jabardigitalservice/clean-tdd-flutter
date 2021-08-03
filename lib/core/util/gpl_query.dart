mixin GqlQuery {
  static String loginQuery = '''
  query (\$email: String!,\$password: String!){
    login(email: \$email, password: \$password){
    token
    userId
  }
  }
  ''';
}
