/// Abstract Factory is a creational design pattern that lets you produce
/// families of related objects without specifying their concrete classes.
/// It's a factory of factories.

/// Let's say you have a type User which has two subtypes: Admin and Guest.
/// But your users can be of different types Local and Global. You can use factories to create
/// the type you need without exposing the constructor of the User class.

abstract class UserFactory {
  GlobalUserEntity buildGlobal();
  LocalUserEntity buildLocal();
}

abstract class GlobalUserEntity {
  String get name;
  String get email;
  void exposeGlobally();
}

abstract class LocalUserEntity {
  String get name;
  String get email;
  void secureLocally();
}

/// Why do we have to do this? Why can't we just create the user directly?
/// Because we want to hide the implementation details of the user.
/// We don't want to expose the constructor of the user.
/// See the client code below to see how we can use this factory.

void showCurrentUserStatusWorldWide(UserFactory userFactory) {
  final globalUser = userFactory.buildGlobal();
  globalUser.exposeGlobally();
  final localUser = userFactory.buildLocal();
  localUser.secureLocally();
}

/// As we can see in the client code above client doesn't know about the
/// concrete implementation of the user. It just knows that it has to call
/// the build method of the factory to get the user.

/// now we can add concrete implementation of the user without modifying the
/// client code.

class GlobalUserAdmin implements GlobalUserEntity {
  final String name;
  final String email;
  final String role = 'admin';
  GlobalUserAdmin(this.name, this.email);

  @override
  void exposeGlobally() {
    print('exposing globally $role');
  }
}

class GlobalUserGuest implements GlobalUserEntity {
  final String name;
  final String email;
  final String role = 'guest';
  GlobalUserGuest(this.name, this.email);

  @override
  void exposeGlobally() {
    print('exposing globally $role + something else');
  }
}

class LocalUserAdmin implements LocalUserEntity {
  final String name;
  final String email;
  final String role = 'admin';
  LocalUserAdmin(this.name, this.email);

  @override
  void secureLocally() {
    print('securing locally');
  }
}

class LocalUserGuest implements LocalUserEntity {
  final String name;
  final String email;
  final String role = 'guest';
  LocalUserGuest(this.name, this.email);

  @override
  void secureLocally() {
    print('securing locally');
  }
}

/// Now we have to create factories for these users as well.
/// If the user is admin or guest we will create the global user.

class AdminUserFactory implements UserFactory {
  @override
  GlobalUserEntity buildGlobal() {
    return GlobalUserAdmin('admin', 'admin@global.com');
  }

  @override
  LocalUserEntity buildLocal() {
    return LocalUserAdmin('admin', 'admin@local.com');
  }
}

/// We can call the build method of the factory to get the user like this
void showAdminStatusLocallyAndGlobally() {
  final adminUserFactory = AdminUserFactory();
  showCurrentUserStatusWorldWide(adminUserFactory);
}
