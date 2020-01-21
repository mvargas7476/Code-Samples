public class MainCalculator {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // Test Calculator
        Calculator myCalc = new Calculator();
        String keyStrokes = "12 + 15 =";
        System.out.println( "Processing: " + keyStrokes );
        // Iterate though the keyStroke string
        for(int i = 0, n = keyStrokes.length() ; i < n ; i++) { 
            char c = keyStrokes.charAt(i);
            myCalc.processKeystroke(c);
        }
        System.out.println("Calc Outputs: " + myCalc.getTotal() );
    }
    
}
