# Design Pattern Final

An extended version of the rental system that scales the **Factory Method** + **Strategy** patterns across more item types (movies, video games, books, and more) and three independent strategy axes — pricing, renter points, and coupons — producing a `LineItem`/`Invoice` model with XML invoice output.

- **Patterns:** Factory Method, Strategy
- **Key types:** `ItemFactory` / `Item`, `PriceStrategyFactory` / `PriceStrategy`, `RenterPointsStrategyFactory` / `RenterPointsStrategy`, `CouponFactory` / `Coupon`, `Invoice`, `LineItem`
- **Entry point:** `RentalTesting` (`ood.homeworkFinal.RentalTesting`) — a thorough driver that prints a labeled result for each test case

## Compile & run
```bash
javac -d out $(find . -name '*.java')
java -cp out ood.homeworkFinal.RentalTesting
```

> Graduate OOD coursework, co-authored with Robert Diepenbrock (see file headers).
