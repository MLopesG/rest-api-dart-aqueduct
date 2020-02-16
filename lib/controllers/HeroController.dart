import 'package:backend/backend.dart';
import 'package:backend/model/hero.dart';

class HeroController extends ResourceController{
  HeroController(this.context);
  final ManagedContext context;
  
  @Operation.get()
  Future <Response>  getAll() async {

    final heroQuery = Query<Hero>(context);
    final heroes = await heroQuery.fetch();
  
    try {
      return Response.ok(heroes);
    } catch (e) {
      return Response.badRequest(body: {"Erro": "Não possivel executar"});
    }
  }
  
  @Operation.get("id")
  Future <Response>  getHero(@Bind.path("id") int id) async { 
    final heroQuery = Query <Hero>(context)..where((h)=>h.id).equalTo(id);
    final hero = await heroQuery.fetchOne();

    try {
      if(hero == null){
        return Response.notFound();
      }
      return  Response.ok(hero);
    } catch (e) {
      return Response.badRequest(body: {"Erro": "Não possivel executar"});
    }
  }
}