
/// case3

///*
///这里对mixin做下简单的总结：
///1.mixin可以理解为对类的一种"增强"，但它与单继承兼容，因为它的继承关系是线性的。
///2.with后面的类会覆盖前面的类的同名方法。
///3.当我们想要在不共享相同类层次结构的多个类之间共享行为时，可以使用mixin。
///4.当声明一个mixin时，on后面的类是使用这个mixin的父类约束。
/// 也就是说一个类若是要with这个mixin， 则这个类必须要继承活实现这个mixin的父类约束。
///*/

class A {
  printMessage() => print('A');
}

mixin B {

  printMessage() => print('B');
}

mixin C on A {
  @override
  printMessage() {
    super.printMessage();
    print('C');
  }
}


class D with A,B,C {
  @override
  printMessage() => super.printMessage();
}

class MixinHard3 {
  test() {

    print('----------');
    /// 从上述例子中可以看出： with 后可以跟 class类，也可以跟 mixin 类， 说明mixin 是一种特殊的class。
    /// 输出B,C
    /// 这里为什么是B,C,而不是A,C 呢？
    /// mixin C on A, 那么C中的super不就是A么？结果应该是A,C 才符合常理啊？ 这是因为在with A 和 with C之间还有一个 with B，
    /// C里面的syper 其实是with A,B, 所以B的printMessage()覆盖了A的printMessage(),所以 with A,B 里面的 printMessage()
    /// 是B的printMessage(),所以，输出结果是BC。
    /// 这是个易错点，值得注意。
    D().printMessage();
  }
}