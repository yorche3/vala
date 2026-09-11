namespace Calculator {
    public int addition(int a, int b) {
        return a + b;
    }

    public int subtraction(int a, int b) {
        return a - b;
    }

    public int multiplication(int a, int b) {
        if (b < 0) {
            assert_not_reached();
        }

        var result = 0;
        for (var count = 0; count < b; count++) {
            result = addition(result, a);
        }
        return result;
    }

    public int division(int a, int b) {
        if (b <= 0) {
            assert_not_reached();
        }

        var dividend = a;
        var quotient = 0;
        while (dividend >= b) {
            dividend = subtraction(dividend, b);
            quotient++;
        }
        return quotient;
    }

    public int modulus(int a, int b) {
        if (b <= 0) {
            assert_not_reached();
        }

        var quotient = division(a, b);
        var product = multiplication(quotient, b);
        return subtraction(a, product);
    }
}
