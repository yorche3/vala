void test_sum_of_first_n_rec() {
    assert (Numbers.sum_of_first_n_rec(0) == 0);
    assert (Numbers.sum_of_first_n_rec(3) == 6);
}

void test_factorial_rec() {
    assert (Numbers.factorial_rec(0) == 1);
    assert (Numbers.factorial_rec(4) == 24);
}

void test_fibonacci_rec() {
    assert (Numbers.fibonacci_rec(0) == 0);
    assert (Numbers.fibonacci_rec(1) == 1);
    assert (Numbers.fibonacci_rec(6) == 8);
}

void test_greatest_common_divisor_rec() {
    assert (Numbers.greatest_common_divisor_rec(12, 8) == 4);
    assert (Numbers.greatest_common_divisor_rec(7, 5) == 1);
}

void test_least_common_multiple_rec() {
    assert (Numbers.least_common_multiple_rec(4, 6) == 12);
    assert (Numbers.least_common_multiple_rec(6, 8) == 24);
}

int main(string[] args) {
    Test.init(ref args);
    Test.add_func("/recursive/sum_of_first_n", test_sum_of_first_n_rec);
    Test.add_func("/recursive/factorial", test_factorial_rec);
    Test.add_func("/recursive/fibonacci", test_fibonacci_rec);
    Test.add_func("/recursive/greatest_common_divisor", test_greatest_common_divisor_rec);
    Test.add_func("/recursive/least_common_multiple", test_least_common_multiple_rec);
    return Test.run();
}
