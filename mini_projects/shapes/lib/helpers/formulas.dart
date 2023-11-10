import 'dart:math';

abstract class Shape {
  double calculateArea();
  double calculatePerimeter();
}

class Trapezoid implements Shape {
  double base1;
  double base2;
  double height;
  double side1;
  double side2;

  Trapezoid({required this.base1, required this.base2, required this.height, required this.side1, required this.side2});

  @override
  double calculateArea() {
    return 0.5 * (base1 + base2) * height;
  }

  @override
  double calculatePerimeter() {
    return base1 + base2 + side1 + side2;
  }
}

class Triangle implements Shape {
  double base;
  double height;
  double side1;
  double side2;
  double side3;

  Triangle({required this.base, required this.height, required this.side1, required this.side2, required this.side3});

  @override
  double calculateArea() {
    return 0.5 * base * height;
  }

  @override
  double calculatePerimeter() {
    return side1 + side2 + side3;
  }
}

class Circle implements Shape {
  double radius;

  Circle({required this.radius});

  @override
  double calculateArea() {
    return pi * radius * radius;
  }

  @override
  double calculatePerimeter() {
    return 2 * pi * radius;
  }
}