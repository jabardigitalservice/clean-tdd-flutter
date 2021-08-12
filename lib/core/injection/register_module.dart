import 'package:clean_tdd_flutter/core/util/SharedPreferences.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class RegisterModule {
  GraphQLClient get gqlClient => GraphQLClient(
        cache: GraphQLCache(),
        link: AuthLink(getToken: () async {
          String? token = await Preferences.getDataString('token');
          if (token == null) {
            print('Kosong');
            return "";
          } else {
            print('ada');
            print(token);

            return "Bearer $token";
          }
        }).concat(
            HttpLink('https://graphql-blog.rover.digitalservice.id/graphql')),
      );
}
