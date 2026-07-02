# State Design Pattern

A calculator implemented with the **State** pattern. The calculator feeds each character of a keystroke stream (e.g. `"12 + 15 ="`) through state objects that decide how to interpret it, transitioning between digit-entry and operator states as it goes. A small factory produces the operator states.

- **Patterns:** State (+ a Factory for operator states)
- **Key types:** `Calculator`, `EntryState` (`EnterFirstDigit`, `EnterDigits`, `EatSpace`, `EatBlanksToOperator`), `OperatorState` + `OperatorStateFactory` (`OperatorPlus`, `OperatorMinus`, `OperatorMultply`, `OperatorInitial`)
- **Entry point:** `MainCalculator` (`Calculator.MainCalculator`)

## Compile & run
```bash
javac -d out $(find . -name '*.java')
java -cp out Calculator.MainCalculator
```

> Graduate OOD coursework. This implementation is predominantly **Robert Diepenbrock's** work (see file headers); it's kept here as a reference example of the State pattern.
