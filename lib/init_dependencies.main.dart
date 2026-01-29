part of 'init_dependencies.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  _initAuth();
  _initBlog();
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogs'));
  //core
  serviceLocator.registerLazySingleton<AppUserCubit>(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(internetConnection: serviceLocator()),
  );
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
    )
    ..registerFactory<UserSignup>(
      () => UserSignup(authRepository: serviceLocator()),
    )
    ..registerFactory<UserLogin>(
      () => UserLogin(authRepository: serviceLocator()),
    )
    ..registerFactory<CurrentUser>(
      () => CurrentUser(authRepository: serviceLocator()),
    )
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        userSignUP: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator<AppUserCubit>(),
      ),
    );
}

void _initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(supabaseClient: serviceLocator()),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator<BlogRemoteDataSource>(),
        serviceLocator<BlogLocalDataSource>(),
        serviceLocator<ConnectionChecker>(),
      ),
    )
    ..registerFactory<UploadBlog>(
      () => UploadBlog(blogRepository: serviceLocator()),
    )
    ..registerFactory<GetAllBlogs>(
      () => GetAllBlogs(blogRepository: serviceLocator()),
    )
    ..registerLazySingleton<BlogBloc>(
      () => BlogBloc(
        getAllBlogs: serviceLocator<GetAllBlogs>(),
        uploadBlog: serviceLocator<UploadBlog>(),
      ),
    );
}
