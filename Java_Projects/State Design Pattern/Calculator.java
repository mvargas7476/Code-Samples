public class Calculator {
    private int total = 0;
    private int accm = 0;

    public Calculator() {
    }
    
    // Process each keystroke
    public void processKeystroke (char KeyPressed) {
        KeyEntryStateSingleton.instance().processKeyStroke(this, KeyPressed);
        System.out.println( "Key: " + KeyPressed +" Total: "+ total + " Accm: " + accm);
    }
    
    // Access Functions
    public int getTotal() { return total; };
    public void setTotal(int value) { total = value; };
    public int getAccm() { return accm; };
    public void setAccm( int value) { accm = value; };
}
