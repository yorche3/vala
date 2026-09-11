void test_sum_of_first_n_ite() {
    assert (Numbers.sum_of_first_n_ite(0) == 0);
    assert (Numbers.sum_of_first_n_ite(3) == 6);
}

void test_factorial_ite() {
    assert (Numbers.factorial_ite(0) == 1);
    assert (Numbers.factorial_ite(4) == 24);
}

void test_fibonacci_ite() {
    assert (Numbers.fibonacci_ite(0) == 0);
    assert (Numbers.fibonacci_ite(1) == 1);
    assert (Numbers.fibonacci_ite(6) == 8);
}

void test_greatest_common_divisor_ite() {
    assert (Numbers.greatest_common_divisor_ite(12, 8) == 4);
    assert (Numbers.greatest_common_divisor_ite(7, 5) == 1);
}

void test_least_common_multiple_ite() {
    assert (Numbers.least_common_multiple_ite(4, 6) == 12);
    assert (Numbers.least_common_multiple_ite(6, 8) == 24);
}

int main(string[] args) {
    Test.init(ref args);
    Test.add_func("/iterative/sum_of_first_n", test_sum_of_first_n_ite);
    Test.add_func("/iterative/factorial", test_factorial_ite);
    Test.add_func("/iterative/fibonacci", test_fibonacci_ite);
    Test.add_func("/iterative/greatest_common_divisor", test_greatest_common_divisor_ite);
    Test.add_func("/iterative/least_common_multiple", test_least_common_multiple_ite);
    return Test.run();
}
