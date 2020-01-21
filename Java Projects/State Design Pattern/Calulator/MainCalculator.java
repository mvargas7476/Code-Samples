package Calulator;


/**
 *
 * @author Robert Diepenbrock
 */
public class MainCalculator {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // Test Calculator
        bulkRun( " 12 + 15 + + " ); // Test Multiple ops
        bulkRun( " 1+2-3-4=55 10"); // Test multiple Numbers
        bulkRun( " 05+10"); // Test leading zero
        bulkRun( "12+12-12-12*0 ");  //Test Successful

    }
    private static void bulkRun( String keyStrokes ) {
        Calculator myCalc = new Calculator();
        int i=0, n ;
        System.out.println( "\nProcessing: \"" + keyStrokes + "\"" );
        // Iterate though the keyStroke string
        try {
            for( i = 0, n = keyStrokes.length() ; i < n ; i++) { 
                char c = keyStrokes.charAt(i);
                myCalc.processKeystroke(c);
            }
        }
        catch ( java.lang.UnsupportedOperationException e ) {
            System.out.println( e.getMessage() );
            System.out.println( "Calculator Returned Error at keystroke # " + (i+1) );
            return;
        }
        System.out.println("Calc Displays: " + myCalc.getDisplay() );
        System.out.println("----------------------------------------");
    }
}
