import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:flutter/material.dart';

class SaveChangesButton extends StatelessWidget {
  const SaveChangesButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: MaterialButton(
            onPressed: () {},
            color: kBlueGray,
            textColor: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            height: 50,
            child: const Text(
              "Save Changes",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DecreaseButton extends StatefulWidget {
  const DecreaseButton({super.key});

  @override
  State<DecreaseButton> createState() => _DecreaseButtonState();
}

int eCounter = 0;

class _DecreaseButtonState extends State<DecreaseButton> {
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
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 30,
      decoration:
          BoxDecoration(border: Border.all(), color: Colors.blueGrey[900]),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          decrement();
        },
        icon: const Icon(
          Icons.minimize,
          color: kWhite,
        ),
      ),
    );
  }
}

class Counter extends StatelessWidget {
  final int? counter;
  const Counter({super.key, this.counter});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 40,
      decoration: BoxDecoration(border: Border.all()),
      child: Text(
        counter.toString(),
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class IncrementButton extends StatefulWidget {
  const IncrementButton({super.key});

  @override
  State<IncrementButton> createState() => _IncrementButtonState();
}

class _IncrementButtonState extends State<IncrementButton> {
  void increment() {
    setState(() {
      eCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration:
          BoxDecoration(border: Border.all(), color: Colors.blueGrey[900]),
      child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            increment();
          },
          icon: const Icon(
            Icons.add,
            color: kWhite,
          )),
    );
  }
}
