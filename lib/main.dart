import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';  // for utf8.encode
import 'qr_screen.dart';
import 'settings_screen.dart';
import 'map_screen.dart';
import 'home_screen.dart';
import 'rewards.dart';
import 'wallet_screen.dart';
import 'daily_streak.dart';

// The main entry point of the application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('username');
  String? password = prefs.getString('password');

  if (username != null && password != null) {
    // Auto login with saved credentials
    var db = await mongo.Db.create("mongodb+srv://slayde:slayde9638@cluster0.ihgbn.mongodb.net/Gamify?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection("users");
    var user = await collection.findOne({
      'Name': username,
      'Password': password
    });

    if (user != null) {
      runApp(MyApp(initialRoute: '/home'));
    } else {
      runApp(MyApp(initialRoute: '/'));
    }
    await db.close();
  } else {
    runApp(MyApp(initialRoute: '/'));
  }
}

// MyApp class defining routes and the app's theme
class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gaming UI with Map',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: initialRoute,
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/map': (context) => const MapScreen(),
        '/qr': (context) => const GenerateQRScreen(),
        '/rewards': (context) => RewardScreen(userCP: ModalRoute.of(context)!.settings.arguments as int),
        '/wallet': (context) => const WalletScreen(),
        '/register': (context) => const RegisterScreen(),
        '/daily_streak': (context) => const DailyStreakScreen(),
      },
    );
  }
}

// LoginScreen class to handle user login
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Hash the password to securely compare with stored password
  String _hashPassword(String password) {
    var bytes = utf8.encode(password); // convert password to bytes
    var digest = sha256.convert(bytes); // apply SHA256 hash
    return digest.toString(); // return hashed password as a string
  }

  // Handle login logic and check against MongoDB
  Future<void> _login() async {
    var db = await mongo.Db.create("mongodb+srv://slayde:slayde9638@cluster0.ihgbn.mongodb.net/Gamify?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection("users");

    // Hash the password before checking
    var hashedPassword = _hashPassword(_passwordController.text);

    // Check if the user exists and the password matches
    var user = await collection.findOne({
      'Name': _usernameController.text,
      'Password': hashedPassword
    });

    if (user != null) {
      // Save user credentials for auto-login next time
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', _usernameController.text);  // Save the username
      prefs.setString('password', hashedPassword);  // Save the hashed password

      // Successful login
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Invalid login credentials
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid username or password")),
      );
    }

    await db.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Register New User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// RegisterScreen class to handle user registration
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Register a new user by adding them to MongoDB
  Future<void> _registerUser() async {
    var db = await mongo.Db.create("mongodb+srv://slayde:slayde9638@cluster0.ihgbn.mongodb.net/Gamify?retryWrites=true&w=majority");
    await db.open();

    var collection = db.collection("users");

    // Hash the password before storing
    var hashedPassword = _hashPassword(_passwordController.text);

    // Generate UserID - can be a simple counter or use ObjectId for unique ID
    var userId = DateTime.now().millisecondsSinceEpoch.toString();  // Generate unique ID based on timestamp

    // Default values for the new fields
    var userData = {
      'UserID': userId,
      'Name': _usernameController.text,
      'CP': 0,  // Starting CP is 0
      'Check_In_Time': null,  // No check-in time initially
      'Check_In_Status': null,  // No check-in status
      'Wallet_Info': null,  // No wallet info initially
      'Current_Streak': 0,  // Default streak is 0
      'Wheel_Spun_Today': false,  // Default is false
      'Password': hashedPassword, // Storing the hashed password
    };

    // Insert the user into the database
    await collection.insertOne(userData);

    await db.close();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("User registered and added to MongoDB")),
    );

    Navigator.pop(context);  // Go back to the login screen
  }

  String _hashPassword(String password) {
    var bytes = utf8.encode(password); // convert password to bytes
    var digest = sha256.convert(bytes); // apply SHA256 hash
    return digest.toString(); // return hashed password as a string
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerUser,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
