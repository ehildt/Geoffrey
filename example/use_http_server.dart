import 'dart:convert';
import 'package:geoffrey/hooks.dart'
    show useHttpServer, useGet, usePost, useRequestData;

void main() {
  // creates a new HttpServer, binds it to the given
  // host:port and handles incoming requests
  useHttpServer('localhost', 8080);

  // creates a new route with GET method
  // or if route exists appends a new method to it
  // overrides the method if it already exists
  // handleGuard is optional and must return a boolean!
  useGet(
      route: '/home/:amount/cookies/:flavor',
      handleRequest: (req, res) async {
        final myData = await useRequestData(req);
        res.write('hello ${myData.dynamicParams}');
      },
      handleGuard: (req, res) => true); // optional

  useGet(
      route: '/home',
      handleRequest: (req, res) => res.write('babuu'),
      handleGuard: (req, res) => true);

  // here we add an additional post method to the route /home
  usePost(
      route: '/home',
      handleRequest: (req, res) =>
          res.write('${jsonEncode({"hello": "world"})}'));
}
