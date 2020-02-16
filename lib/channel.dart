import 'backend.dart';
import 'controllers/HeroController.dart';

class BackendChannel extends ApplicationChannel {

  ManagedContext context; 

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore =  PostgreSQLPersistentStore.fromConnectionInfo(
      'postgres', 
      'root', 
      'localhost', 
       5435, 
      'dart'
      );

    context = ManagedContext(dataModel,persistentStore);
  }
  @override
  Controller get entryPoint {
    final router = Router();

    router
      .route("/dart")
      .linkFunction((request) async {
        return Response.ok({"info": "RestAPI construida com Dart e aqueduct."});
      });

    router
      .route("/heroes/[:id]")
      .link(()=> HeroController(context));

    return router;
  }
}