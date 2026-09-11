namespace Numbers {
    public int sum_of_first_n_rec(int n) {
        if (n <= 0) {
            return 0;
        }
        return n + sum_of_first_n_rec(n - 1);
    }

    public int factorial_rec(int n) {
        if (n <= 1) {
            return 1;
        }
        return n * factorial_rec(n - 1);
    }

    public int fibonacci_rec(int n) {
        if (n <= 1) {
            return n;
        }
        return fibonacci_rec(n - 1) + fibonacci_rec(n - 2);
    }

    public int greatest_common_divisor_rec(int a, int b) {
        if (b == 0) {
            return a;
        }
        return greatest_common_divisor_rec(b, a % b);
    }

    public int least_common_multiple_rec(int a, int b) {
        if (a == 0 || b == 0) {
            return 0;
        }
        return (a / greatest_common_divisor_rec(a, b)) * b;
    }

    public int sum_of_first_n_acc(int n) {
        return sum_of_first_n_acc_help(n, 0);
    }

    private int sum_of_first_n_acc_help(int current, int accumulator) {
        if (current <= 0) {
            return accumulator;
        }
        return sum_of_first_n_acc_help(current - 1, current + accumulator);
    }

    public int factorial_acc(int n) {
        return factorial_acc_help(n, 1);
    }

    private int factorial_acc_help(int current, int accumulator) {
        if (current <= 1) {
            return accumulator;
        }
        return factorial_acc_help(current - 1, current * accumulator);
    }

    public int fibonacci_acc(int n) {
        return fibonacci_acc_help(n, 0, 1);
    }

    private int fibonacci_acc_help(int position, int previous, int current) {
        if (position <= 0) {
            return previous;
        }
        if (position == 1) {
            return current;
        }
        return fibonacci_acc_help(position - 1, current, previous + current);
    }

    public int greatest_common_divisor_acc(int a, int b) {
        return greatest_common_divisor_acc_help(a, b);
    }

    private int greatest_common_divisor_acc_help(int a, int b) {
        if (b == 0) {
            return a;
        }
        return greatest_common_divisor_acc_help(b, a % b);
    }

    public int least_common_multiple_acc(int a, int b) {
        if (a == 0 || b == 0) {
            return 0;
        }
        return (a / greatest_common_divisor_acc(a, b)) * b;
    }

    public int sum_of_first_n_ite(int n) {
        var result = 0;
        for (var current = 1; current <= n; current++) {
            result += current;
        }
        return result;
    }

    public int factorial_ite(int n) {
        var result = 1;
        for (var current = 2; current <= n; current++) {
            result *= current;
        }
        return result;
    }

    public int fibonacci_ite(int n) {
        if (n <= 1) {
            return n;
        }

        var previous = 0;
        var current = 1;
        for (var position = 2; position <= n; position++) {
            var next = previous + current;
            previous = current;
            current = next;
        }
        return current;
    }

    public int greatest_common_divisor_ite(int a, int b) {
        var x = a;
        var y = b;
        while (y != 0) {
            var remainder = x % y;
            x = y;
            y = remainder;
        }
        return x;
    }

    public int least_common_multiple_ite(int a, int b) {
        if (a == 0 || b == 0) {
            return 0;
        }
        return (a / greatest_common_divisor_ite(a, b)) * b;
    }
}
