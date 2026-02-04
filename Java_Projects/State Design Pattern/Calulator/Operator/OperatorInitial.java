package Calulator.Operator;

import Calulator.Calculator;

/**
 *
 * @author Robert Diepenbrock
 */
public class OperatorInitial extends OperatorState {

    @Override
    public void doOperation(Calculator calc) {
        // Total is set to Accm, Accm is set to zero
        calc.setTotal(calc.getAccm());
        calc.setAccm(0);
    }
    
}
