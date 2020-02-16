import 'package:backend/backend.dart';

class HeroController extends ResourceController{

  final ManagedContext context;
  final List Heros = [
    "Iron Man",
    "Homem Aranha",
    "Home de ferro",
    "Saitam"
  ];

  HeroController(this.context);

  @Operation.get()
  Future <Response>  getAll() async {
    try {
      return Response.ok(Heros);
    } catch (e) {
      return Response.badRequest(body: {"Erro": "Não possivel executar"});
    }
  }

  @Operation.get("id")
  Future <Response>  getHero(@Bind.path("id") int id) async {
    try {
      return Response.ok(Heros[id]);
    } catch (e) {
      return Response.badRequest(body: {"Erro": "Não possivel executar"});
    }
  }
}