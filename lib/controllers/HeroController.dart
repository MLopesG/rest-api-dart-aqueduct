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
      return Response.badRequest(body: {"Erro": "Não possivel encontrar registro"});
    }
  }

  @Operation.post()
  Future<Response> createHero() async{
    final Map<String, dynamic> body = await request.body.decode();
    final query = Query<Hero>(context)..values.name = body['name'] as String;
    final insertedHero = await query.insert();

    return Response.ok(insertedHero); 
  }

  @Operation.put("id")
  Future<Response> updateHero(@Bind.path("id") int id) async{
    final Map<String, dynamic> body = await request.body.decode();
    final query = Query<Hero>(context)..values.name = body['name'] as String
    ..where((u)=>u.id).equalTo(id);
    final updateHero = await query.update();

    return Response.ok(updateHero);
  }

  @Operation.delete("id")
  Future<Response> deleteHero(@Bind.path("id") int id) async{
    final query = Query<Hero>(context)..where((u)=>u.id).equalTo(id);
    final deleteHero = await query.delete();

    final response = {
      'msg':"Hero deletado com sucesso",
      'success': true
    };

    if(deleteHero > 0){
      return Response.ok(response);
    }else{
      return Response.badRequest(body: {"Erro": "Não possivel executar"});
    }
  }
}