# Factory Design Pattern

A video-rental pricing system that demonstrates the **Factory Method** and **Strategy** patterns together. Factories build interchangeable strategies for pricing, renter points, and coupons, so a `Customer`'s rentals can be priced and turned into a statement without the calling code knowing the concrete strategy classes.

- **Patterns:** Factory Method, Strategy
- **Key types:** `PriceStrategyFactory` / `PriceStrategy`, `RenterPointsStrategyFactory` / `RenterPointsStrategy`, `CouponFactory` / `Coupon`, `Customer`, `Rental`, `Movie`
- **Entry point:** `RentalTesting` (`ood.homework4.RentalTesting`)

## Compile & run
```bash
javac -d out $(find . -name '*.java')
java -cp out ood.homework4.RentalTesting
```

> Graduate OOD coursework, co-authored with Robert Diepenbrock (see file headers).
