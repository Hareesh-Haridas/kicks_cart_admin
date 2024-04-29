// import 'package:admin/application/Presentation/screens/edit%20product%20screen/widgets/button_widgets.dart';
import 'package:admin/application/presentation/screens/edit_product_screen/widgets/button_widgets.dart';
import 'package:flutter/material.dart';

class CounterContainer extends StatefulWidget {
  final int intitialCounter;
  const CounterContainer({super.key, required this.intitialCounter});

  @override
  State<CounterContainer> createState() => _CounterContainerState();
}

class _CounterContainerState extends State<CounterContainer> {
  int eCounter = 0;
  @override
  void initState() {
    super.initState();
    eCounter = widget.intitialCounter;
  }

  void increment() {
    setState(() {
      eCounter++;
    });
  }

  void decrement() {
    setState(() {
      if (eCounter > 0) {
        eCounter--;
      } else {
        eCounter = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DecreaseButton(decrement: decrement),
        Counter(counter: eCounter),
        IncrementButton(increment: increment)
      ],
    );
  }
}

class DecreaseButton extends StatelessWidget {
  final VoidCallback decrement;
  const DecreaseButton({super.key, required this.decrement});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 30,
      decoration:
          BoxDecoration(border: Border.all(), color: Colors.blueGrey[900]),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: decrement,
        icon: const Icon(
          Icons.minimize,
          color: Colors.white,
        ),
      ),
    );
  }
}

class IncrementButton extends StatelessWidget {
  final VoidCallback increment;

  const IncrementButton({super.key, required this.increment});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration:
          BoxDecoration(border: Border.all(), color: Colors.blueGrey[900]),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: increment,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
