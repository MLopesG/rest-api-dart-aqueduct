import 'backend.dart';
import 'controllers/HeroController.dart';

class BackendChannel extends ApplicationChannel {

  ManagedContext context; 

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    context = null;
  }
  @override
  Controller get entryPoint {
    final router = Router();

    router
      .route("/example")
      .linkFunction((request) async {
        return Response.ok({"key": "value"});
      });

    router
      .route("/heroes/[:id]")
      .link(()=> HeroController(context));

    return router;
  }
}