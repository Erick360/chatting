import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
        upperBound: 100.0,
    );

    animation = ColorTween(begin: Colors.red,end: Colors.blue).animate(controller);
    /*
    animation = CurvedAnimation(
        parent: controller,
        curve: Curves.decelerate
    );
*/

    /*
    // reversed to forward animation
    animation.addStatusListener(
        (status){
          if(status == AnimationStatus.completed){
            controller.reverse(from: 1.0);
          }else if(status == AnimationStatus.dismissed){
            controller.forward();
          }
        }
    );
  */

    controller.forward();
    controller.addListener((){
      setState(() {

      });
    });
  }

  /*
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,//animation.value //withOpacity(controller.value),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                 tag: 'logo',
                  child: SizedBox(
                    height: controller.value,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                const Text(
                  'L’amour',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 45.0,
                  child: const Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text('Register'),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {
                //Navigate to home
              },
              icon: const Icon(Icons.home),
            ),
            const Text(
              'Copyright © New Horizons 2025',
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.info))
          ],
        ),
      ),
    );
  }
}
