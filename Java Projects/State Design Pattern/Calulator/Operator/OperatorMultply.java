/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Calulator.Operator;

import Calulator.Calculator;

/**
 *
 * @author Dad
 */
public class OperatorMultply extends OperatorState {

    @Override
    public void doOperation(Calculator calc) {
        // Perform Multiply
        calc.setTotal( calc.getAccm() * calc.getTotal() );
        calc.setAccm(0);
    }
    
}
