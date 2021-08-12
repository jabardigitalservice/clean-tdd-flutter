mixin GqlQuery {
  static String loginQuery = '''
  query (\$email: String!,\$password: String!){
    login(email: \$email, password: \$password){
    token
    userId
  }
  }
  ''';

  static String postQuery = '''
  query{
  posts(page: 1){
    posts{
      content
      title
    }
    totalPosts
  }
}
  ''';
}
