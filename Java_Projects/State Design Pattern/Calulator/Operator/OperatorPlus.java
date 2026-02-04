package Calulator.Operator;

import Calulator.Calculator;

/**
 *
 * @author Robert Diepenbrock
 */
public class OperatorPlus extends OperatorState {

    @Override
    public void doOperation(Calculator calc) {
        // Perform addtion
        calc.setTotal( calc.getAccm() + calc.getTotal() );
        calc.setAccm(0);
    }
    
}
