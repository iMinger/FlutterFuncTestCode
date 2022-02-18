

/// case2

class A {
  printMessage() => print('A');
}

mixin B on A {
  @override
  printMessage() {
    super.printMessage();
    print('B');
  }
}

mixin C on B {
  @override
  printMessage() {
    // TODO: implement printMessage
    super.printMessage();
    print('C');
  }
}


class D with A,B,C {
  @override
  printMessage() => super.printMessage();
}

class MixinOnTest {
  test() {


    /// 输出结果是A,B,C
    /// 第一步： with A 就是 Object with A ,此时super 就是Object类
    /// 第二步： with B, 由于mixin B 是 on A的，所以对于B来说，其super就是A。则B的printMessage() 会调用A的printMessage()
    /// 第三步： with C, 由于mixin C 是 ob B的，所以对于C来说，其super就是B。则C的printMessage() 会调用B的printMessage()
    /// 第四步：D继承的就是ABC的混合类，由于A、B、C三个类都有同名方法，则B会覆盖A的同名方法，C会覆盖B的同名方法，最终ABC的混合类中的
    /// 方法就是C的printMessage()。D中的super就是ABC的混合类。
    D().printMessage();
  }
}