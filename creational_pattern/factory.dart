/// Let's say you have a type User which has two subtypes: Admin and Guest.
/// You can use factories to create the type you need without exposing the
/// constructor of the User class.

/// You can create these 2 classes from the start of structuring your app.
/// Later on if you want to add a new type of user, you can just create a new
/// class and implement the UserBuilder interface.
abstract class UserFactory {
  UserEntity build();
}

abstract class UserEntity {
  String get name;
  String get email;
}

/// Start to get the user with the factory use in a function
/// This function will return the user based on the role
UserEntity getUser(UserFactory factory) {
  return factory.build();
}

void main(List<String> args) {
  /// Create a admin user
  /// You can create a admin user by using the AdminUserFactory
  /// and pass it to the getUser function
  /// You can create many user without exposing the constructor of the User class
  /// This method ensures that you abide by the open-closed principle.
  /// You can add new types of users without modifying the existing code.
  final adminUser = getUser(AdminUserFactory());
  print(adminUser.name);
  print(adminUser.email);
  final guestUser = getUser(GuestUserFactory());
  print(guestUser.name);
  print(guestUser.email);
}

/// Admin user
class AdminUser implements UserEntity {
  final String name;
  final String email;
  final String role = 'admin';
  AdminUser(this.name, this.email);
}

class AdminUserFactory implements UserFactory {
  @override
  UserEntity build() {
    return AdminUser('admin1', 'admin@email.com');
  }
}

/// Guest user
class GuestUser implements UserEntity {
  final String name;
  final String email;
  final String role = 'guest';
  GuestUser(this.name, this.email);
}

class GuestUserFactory implements UserFactory {
  @override
  UserEntity build() {
    return GuestUser('guest1', 'guest1@gg.vn');
  }
}

/// You can apply this pattern to UI rendering as well.
/// For example, you can create a factory for rendering a button.
abstract class RunGame {
  void render();
  Button createButton();
}

abstract class Button {
  void render();
  void onClick();
  String get text;
}

/// Implements of the [RunGame] interfaces
class RunGameForm implements RunGame {
  @override
  Button createButton() {
    return RunButton();
  }

  @override
  void render() {
    final button = createButton();
    button.render();
  }
}

class JumpGameForm implements RunGame {
  @override
  Button createButton() {
    return JumpButton();
  }

  @override
  void render() {
    final button = createButton();
    button.render();
    print(button.text);

    /// Show button in game here
  }
}

/// Implements of the [Button] interfaces
class JumpButton implements Button {
  @override
  void onClick() {
    print('Jump');
  }

  @override
  void render() {
    print('Render Jump button');
  }

  @override
  String get text => 'Jump';
}

class RunButton implements Button {
  @override
  void onClick() {
    print('Run');
  }

  @override
  void render() {
    print('Render Run button');
  }

  @override
  String get text => 'Run';
}

void renderGame(RunGame game) {
  game.render();
}
