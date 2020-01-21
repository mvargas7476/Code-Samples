public class OperatorPlus extends OperatorState {

    @Override
    public void doOperation(Calculator calc) {
        // Perform addtion
        calc.setTotal( calc.getTotal() + calc.getAccm() );
        calc.setAccm(0);
        return;
    }
    
}
