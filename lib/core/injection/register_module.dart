import 'package:graphql_flutter/graphql_flutter.dart';

abstract class RegisterModule {
  GraphQLClient get gqlClient => GraphQLClient(
        cache: GraphQLCache(),
        link: HttpLink('https://graphql-blog.rover.digitalservice.id/graphql'),
      );
}
