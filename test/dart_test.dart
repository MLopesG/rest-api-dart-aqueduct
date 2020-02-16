import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  test("GET /dart returns 200 {'info': 'RestAPI construida com Dart e aqueduct.'}", () async {
    expectResponse(await harness.agent.get("/dart"), 200, body: {"info": "RestAPI construida com Dart e aqueduct."});
  });
}
