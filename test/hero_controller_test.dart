import 'harness/app.dart';

void main(){
  final harness = Harness()..install();

  test("GET /heroes returns 200 OK", () async{
    final response = await harness.agent.get('/heroes');
    expectResponse(response, 200);
  });

  // verificar o tipo de lista recebida, verificar as propriedades id e name;
  test("GET /heroes returns 200 OK", () async {
    final response = await harness.agent.get("/heroes");
    expectResponse(response, 200, body: everyElement({
      "id": greaterThan(0),
      "name": isString,
    }));

  test("POST /heroes returns 200 OK", () async {
    final response = await harness.agent.post("/heroes", body: {
      "name": "Marcos"
    });
    expectResponse(response, 200, body: {
      "id": greaterThan(0),
      "name": "Lopes"
    });
    });
  });
}
