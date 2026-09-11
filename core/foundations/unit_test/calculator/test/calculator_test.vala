void test_addition() {
    assert (Calculator.addition(2, 3) == 5);
}

void test_subtraction() {
    assert (Calculator.subtraction(5, 2) == 3);
}

void test_multiplication() {
    assert (Calculator.multiplication(3, 4) == 12);
}

void test_division() {
    assert (Calculator.division(10, 3) == 3);
}

void test_modulus() {
    assert (Calculator.modulus(10, 3) == 1);
}

int main(string[] args) {
    Test.init(ref args);
    Test.add_func("/calculator/addition", test_addition);
    Test.add_func("/calculator/subtraction", test_subtraction);
    Test.add_func("/calculator/multiplication", test_multiplication);
    Test.add_func("/calculator/division", test_division);
    Test.add_func("/calculator/modulus", test_modulus);
    return Test.run();
}
