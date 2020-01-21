package Calulator.Operator;

import Calulator.Calculator;


/**
 *
 * @author Robert Diepenbrock
 */
public class OperatorMinus extends OperatorState {

    @Override
    public void doOperation(Calculator calc) {
        // Perform addtion
        calc.setTotal( calc.getTotal() - calc.getAccm() );
        calc.setAccm(0);    
    }
}
