
package Calulator;

import Calulator.EntryState.*;
import Calulator.Operator.*;

/**
 *
 * @author Robert Diepenbrock 
 */
public class Calculator {
    private int accm;
    private int total;
    private EntryState EntryState;
    private OperatorState OpState;
    
    public Calculator() {
        accm = 0; 
        total = 0;
        EntryState = new EnterFirstDigit();
        OpState = new OperatorInitial();
    }
    
    public void processKeystroke( char c ) {
        EntryState.processKeyStroke(this, c);
        System.out.println("Input: \'" + c + "\' Total: " + total + " Display: " + getDisplay() );
    }
    
    public int getDisplay() {
        if( accm == 0 )
            return total;
        return accm;
    }
    
    // Accessors 
    public int getTotal() { return total; }
    public void setTotal( int value)  { total=value; }
    public int getAccm()  { return accm; }
    public void setAccm( int value )  { accm = value; }
    public EntryState getEntryState() {return EntryState;}
    public void setEntryState(EntryState state) {EntryState = state;}
    public OperatorState getOpStae() { return OpState; }
    public void setOpStae(OperatorState state) { OpState = state; }
          
}
