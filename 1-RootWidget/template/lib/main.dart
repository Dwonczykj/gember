import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:template/network/mock_service.dart';
import 'package:template/network/template_service.dart';
import 'package:template/ui/main_screen.dart';
import 'package:template/ui/models/app_state_manager.dart';
import 'package:template/ui/models/project_manager.dart';

import 'navigation/app_router.dart';
import 'network/api_query_model.dart';
import 'network/service_interface.dart';
import 'ui/models/consumer_manager.dart';

Future<void> main() async {
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();
  // final repository = SqliteRepository();
  // final repository = MoorRepository();
  // await repository.init();
  // runApp(MyApp(repository: repository));
  runApp(const Gember());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(
    (rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    },
  );
}

class Gember extends StatefulWidget {
  const Gember({Key? key}) : super(key: key);

  @override
  State<Gember> createState() => _GemberState();
}

class _GemberState extends State<Gember> {
  final _projectManager = ProjectManager();
  final _consumerManager = ConsumerManager();
  final _appStateManager = AppStateManager();

  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      profileManager: _consumerManager,
      projectManager: _projectManager,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider<Repository>(
        //   lazy: false,
        //   create: (_) => repository,
        //   dispose: (_, Repository repository) => repository.close(),
        // ),
        ChangeNotifierProvider(
          create: (context) => _consumerManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _projectManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _appStateManager,
        ),
        Provider<ServiceInterface>(
          create: (_) => MockService.create(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Recipes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Router(
          routerDelegate: _appRouter,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
