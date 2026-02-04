
package ood.homework4;

import ood.homework4.coupons.CouponFactory;
import ood.homework4.Movie.Type;

/**
 *
 * @author Robert Diepenbrock
 * @Author Mattias Vargas
 */
public class RentalTesting {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        // Our Customer list
        Customer customer = new Customer("Customer", 0, 0 );
        Customer customer_1 = new Customer("Customer One", 0, 0 );
        Customer youngAdult = new Customer("Young Adult", 19, 0 );
        Customer withPoints = new Customer("Has points", 0, 12 );
        Customer zeroPoints = new Customer("Zero Points", 0, 0);
        
        // Our list of rentable movies
        Movie children = new Movie("Children's", Type.CHILDREN);
        Movie newRelease = new Movie("New Release",Type.NEW_RELEASE);
        Movie regular = new Movie("Regular",Type.REGULAR);
        Movie newRelease_1 = new Movie("New Release 1",Type.NEW_RELEASE);
        Movie newRelease_2 = new Movie("New Release 2",Type.NEW_RELEASE);


        System.out.println("\n --- Standard Test Case for POINTS and PRICE --- \n"); 
        System.out.println("Customer: " + customer.getName() + 
                " Has: " + customer.getPoints() + " points" ); 
        customer.addRental(new Rental(children, 2 ));
        customer.addRental(new Rental(newRelease, 2 ));
        customer.addRental(new Rental(regular, 2 ));

        System.out.println( customer.statement() );
        
        System.out.println( "\n ---xml statement---- \n");
        
        System.out.println( customer.xmlStatement());
        
        System.out.println("\n --- COUPON TEST CASE 2a (Valid) ---");
        System.out.println(" --- Applied Double points for multiple catagories Coupon --- \n");
        customer.applyCoupon(CouponFactory.CouponType.DOUBLE_POINTS);
         
        System.out.println( customer.statement() );
        customer.completeRental();
        System.out.println("Customer: " + customer.getName() + 
                " Has: " + customer.getPoints() + " points" );
        
        System.out.println("\n --- COUPON TEST CASE 2a (invalid) ---");
        System.out.println(" ---- Two New Releases only, Coupon invalid ");
        System.out.println("          (should be the same points twice)");
        System.out.println("Customer: " + customer_1.getName() + 
                " Has: " + customer_1.getPoints() + " points\n" );        
        customer_1.addRental(new Rental(newRelease_1, 2 ));
        customer_1.addRental(new Rental(newRelease_2, 2 ));

        System.out.println( customer_1.statement() );
 
        System.out.println("\n --- Applied Double points Coupon (No Change) --- \n");
        customer_1.applyCoupon(CouponFactory.CouponType.DOUBLE_POINTS);
        System.out.println( customer_1.statement() );
        customer_1.completeRental();
        System.out.println("Customer: " + customer_1.getName() + 
                " Has: " + customer_1.getPoints() + " points\n" );           
        System.out.println("\n --- COUPON TEST CASE 2b (invalid) --- ");       
        System.out.println(" ---- Test Case - Customer wrong age, no new releases ");
        System.out.println("          (should be the same points twice) \n");
        customer.addRental(new Rental(children, 4));
        customer.addRental(new Rental(regular, 4));
        System.out.println( customer.statement() );        
        
        System.out.println("\n -- Applying Coupon (SAME) ---- \n");        
        customer.applyCoupon(CouponFactory.CouponType.YOUNG_ADULT_NEW_RELEASE);
        System.out.println( customer.statement() );
        customer.completeRental();
        
        System.out.println("\n --- COUPON TEST CASE 2b (invalid) --- ");       
        System.out.println(" ---- Test Case - Customer right age but has no New Release ");
        System.out.println("          (should be the same points twice) \n");
        youngAdult.addRental(new Rental(children, 4));
        youngAdult.addRental(new Rental(regular, 4));
        System.out.println( youngAdult.statement() );        
        
        System.out.println("\n -- Applying Coupon (SAME) ---- \n");        
        customer.applyCoupon(CouponFactory.CouponType.YOUNG_ADULT_NEW_RELEASE);
        System.out.println( youngAdult.statement() );
        youngAdult.completeRental();
        
        System.out.println("\n --- COUPON TEST CASE 2b (invalid) --- ");       
        System.out.println(" ---- Test Case - Customer wrong age but has New Release ");
        System.out.println("          (should be the same points twice) \n");
        customer.addRental(new Rental(newRelease, 4));
        customer.addRental(new Rental(regular, 4));
        System.out.println( customer.statement() );        
        
        System.out.println("\n -- Applying Coupon (SAME) ---- \n");        
        customer.applyCoupon(CouponFactory.CouponType.YOUNG_ADULT_NEW_RELEASE);
        System.out.println( customer.statement() );
        customer.completeRental();
        
        System.out.println("\n --- COUPON TEST CASE 2b (valid) --- ");       
        System.out.println(" ---- Test Case - Customer right age and has New Release ");
        System.out.println("          (Points should double) \n");     
        youngAdult.addRental(new Rental(newRelease, 4));
        youngAdult.addRental(new Rental(regular, 4));
        System.out.println( youngAdult.statement() );        
        
        System.out.println("\n -- Applying Coupon (Double Points) ---- \n");        
        youngAdult.applyCoupon(CouponFactory.CouponType.YOUNG_ADULT_NEW_RELEASE);
        System.out.println( youngAdult.statement() );
        youngAdult.completeRental();
        
        System.out.println("\n ---  TEST CASE 3  --- ");       
        System.out.println(" ---- Test Case - Free Movie \n");   
        System.out.println("Customer: " + withPoints.getName() + 
                " Has: " + withPoints.getPoints() + " points" ); 
        withPoints.addRental(new Rental(newRelease, 4));
        withPoints.addRental(new Rental(regular, 4));
        System.out.println( withPoints.statement() );        
        
        System.out.println("\n -- Applying Coupon (One Movie is Free) ---- \n");        
        withPoints.applyCoupon(CouponFactory.CouponType.FREE_MOVIE_WITH_POINTS);
        System.out.println( withPoints.statement() );
        withPoints.completeRental();       
        System.out.println("Customer: " + withPoints.getName() + 
                " Has: " + withPoints.getPoints() + " points" ); 
    }    
}
