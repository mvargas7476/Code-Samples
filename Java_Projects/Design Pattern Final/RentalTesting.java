
package ood.homeworkFinal;

import ood.homeworkFinal.coupons.CouponFactory;
import ood.homeworkFinal.item.Item;
import ood.homeworkFinal.item.ItemFactory;

/**
 *
 * @author Robert Diepenbrock
 * @author Matias Vargas
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
        
        // Test List of Items 
        
        // Our list of rentable movies
        //  In this list, we don't sell new releases, but all the rest are for sale
        Item children = (Item) ItemFactory.build(
                ItemFactory.ItemType.CHILDRENS_MOVIE, "Children's", true, true , 9.95);
        Item newRelease = (Item) ItemFactory.build(
                ItemFactory.ItemType.NEW_RELEASE_MOVIE, "New Release", true, false, 20.99 );
        Item regular = (Item) ItemFactory.build(
                ItemFactory.ItemType.REGULAR_MOVIE, "Regular", true, true, 9.95 );
        Item newRelease_1 = (Item) ItemFactory.build(
                ItemFactory.ItemType.NEW_RELEASE_MOVIE,"New Release 1",true, false, 25.99 );
        Item newRelease_2 = (Item) ItemFactory.build(
                ItemFactory.ItemType.NEW_RELEASE_MOVIE,"New Release 2",true, false, 29.50 );
        
        // Video Games, Sale or rent
        Item xBoxVideoGame = (Item) ItemFactory.build(
                ItemFactory.ItemType.XBOX_GAME , "XBox Video Game", true, true, 35.00);
        Item ps4VideoGame = (Item) ItemFactory.build(
                ItemFactory.ItemType.PS4_GAME , "PS4 Video Game", true, true, 39.00);
        
        // Items we can only sell and NOT rent
        Item audioCD = (Item) ItemFactory.build(
                ItemFactory.ItemType.MUSIC_CD , "Audio CD", false, true, 12.00); 
        Item book = (Item) ItemFactory.build(
                ItemFactory.ItemType.BOOK , "Book", false, true, 12.00); 
        Item candy = (Item) ItemFactory.build(
                ItemFactory.ItemType.MISC , "Candy", false, true, 2.00);
        Item xboxConsole = (Item) ItemFactory.build(
                ItemFactory.ItemType.MISC , "XBox Console", false, true, 250.00);
        Item ps4Console = (Item) ItemFactory.build(
                ItemFactory.ItemType.MISC , "PS4 Console", false, true, 280.00);
        
        System.out.println("\n --- BASE RENTAL Test Case for POINTS and PRICE --- \n"); 
        System.out.println("Customer: " + customer.getName() + 
                " Has: " + customer.getPoints() + " points" ); 
        customer.addItem(new LineItem(children, 2 ));
        customer.addItem(new LineItem(newRelease, 2 ));
        customer.addItem(new LineItem(regular, 2 ));

        System.out.println( customer.invoice() );
        
        System.out.println( "\n ---xml statement---- \n");
        
        System.out.println( customer.xmlInvoice());
        
        System.out.println("\n --- COUPON TEST CASE HW4 2a (Valid) ---");
        System.out.println(" --- Applied Double points for multiple catagories Coupon --- \n");
        customer.applyCoupon(CouponFactory.CouponType.DOUBLE_POINTS);
         
        System.out.println( customer.invoice() );
        customer.completeInvoice();
        System.out.println("Customer: " + customer.getName() + 
                " Has: " + customer.getPoints() + " points" );
        
        System.out.println("\n --- COUPON TEST CASE HW4  2a (invalid) ---");
        System.out.println(" ---- Two New Releases only, Coupon invalid ");
        System.out.println("          (should be the same points twice)");
        System.out.println("Customer: " + customer_1.getName() + 
                " Has: " + customer_1.getPoints() + " points\n" );        
        customer_1.addItem(new LineItem(newRelease_1, 2 ));
        customer_1.addItem(new LineItem(newRelease_2, 2 ));

        System.out.println( customer_1.invoice() );
 
        System.out.println("\n --- Applied Double points Coupon (No Change) --- \n");
        customer_1.applyCoupon(CouponFactory.CouponType.DOUBLE_POINTS);
        System.out.println( customer_1.invoice() );
        customer_1.completeInvoice();
        System.out.println("Customer: " + customer_1.getName() + 
                " Has: " + customer_1.getPoints() + " points\n" );           
        System.out.println("\n --- COUPON TEST CASE HW4  2b (invalid) --- ");       
        System.out.println(" ---- Test Case - Customer wrong age, no new releases ");
        System.out.println("          (should be the same points twice) \n");
        customer.addItem(new LineItem(children, 4));
        customer.addItem(new LineItem(regular, 4));
        System.out.println( customer.invoice() );        
        
        System.out.println("\n -- Applying Coupon (SAME) ---- \n");        
        customer.applyCoupon(CouponFactory.CouponType.YOUNG_ADULT_NEW_RELEASE);
        System.out.println( customer.invoice() );
        customer.completeInvoice();
        
        System.out.println("\n --- COUPON TEST CASE HW4 2b (invalid) --- ");       
        System.out.println(" ---- Test Case - Customer right age but has no New Release ");
        System.out.println("          (should be the same points twice) \n");
        youngAdult.addItem(new LineItem(children, 4));
        youngAdult.addItem(new LineItem(regular, 4));
        System.out.println( youngAdult.invoice() );        
        
        System.out.println("\n -- Applying Coupon (SAME) ---- \n");        
        customer.applyCoupon(CouponFactory.CouponType.YOUNG_ADULT_NEW_RELEASE);
        System.out.println( youngAdult.invoice() );
        youngAdult.completeInvoice();
        
        System.out.println("\n --- COUPON TEST CASE HW4 2b (invalid) --- ");       
        System.out.println(" ---- Test Case - Customer wrong age but has New Release ");
        System.out.println("          (should be the same points twice) \n");
        customer.addItem(new LineItem(newRelease, 4));
        customer.addItem(new LineItem(regular, 4));
        System.out.println( customer.invoice() );        
        
        System.out.println("\n -- Applying Coupon (SAME) ---- \n");        
        customer.applyCoupon(CouponFactory.CouponType.YOUNG_ADULT_NEW_RELEASE);
        System.out.println( customer.invoice() );
        customer.completeInvoice();
        
        System.out.println("\n --- COUPON TEST CASE HW4 2b (valid) --- ");       
        System.out.println(" ---- Test Case - Customer right age and has New Release ");
        System.out.println("          (Points should double) \n");     
        youngAdult.addItem(new LineItem(newRelease, 4));
        youngAdult.addItem(new LineItem(regular, 4));
        System.out.println( youngAdult.invoice() );        
        
        System.out.println("\n -- Applying Coupon (Double Points) ---- \n");        
        youngAdult.applyCoupon(CouponFactory.CouponType.YOUNG_ADULT_NEW_RELEASE);
        System.out.println( youngAdult.invoice() );
        youngAdult.completeInvoice();
        
        System.out.println("\n ---  TEST CASE 3  --- ");       
        System.out.println(" ---- Test Case - Free Movie \n");   
        System.out.println("Customer: " + withPoints.getName() + 
                " Has: " + withPoints.getPoints() + " points" ); 
        withPoints.addItem(new LineItem(newRelease, 4));
        withPoints.addItem(new LineItem(regular, 4));
        System.out.println( withPoints.invoice() );        
        
        System.out.println("\n -- Applying Coupon (One Movie is Free) ---- \n");        
        withPoints.applyCoupon(CouponFactory.CouponType.FREE_MOVIE_WITH_POINTS);
        System.out.println( withPoints.invoice() );
        withPoints.completeInvoice();       
        System.out.println("Customer: " + withPoints.getName() + 
                " Has: " + withPoints.getPoints() + " points" ); 
        
        System.out.println("\n============= FINAL PROJECT TESTING =======\n");
        
        System.out.println("Item 1:  Support different types");
        System.out.println("   a.  Movies (previously done) ");
        System.out.println("   b.  Video Games (Xbox and PS4) ");
        System.out.println("   c.  Music CDs ");
        System.out.println("   d.  XBOX (assumed consoles)");
        System.out.println("   e.  PS4 (assumed consoles)");
        System.out.println("   f.  BOOKS");
        
        zeroPoints.addItem(new LineItem(children, 3)); // Rental
        zeroPoints.addItem(new LineItem(children));    // Sale
        zeroPoints.addItem(new LineItem(xBoxVideoGame, 3));
        zeroPoints.addItem(new LineItem(xBoxVideoGame));
        zeroPoints.addItem(new LineItem(audioCD) );
        zeroPoints.addItem(new LineItem(book) );        
        zeroPoints.addItem(new LineItem(xboxConsole));
        zeroPoints.addItem(new LineItem(ps4Console));
        zeroPoints.addItem(new LineItem(candy) );
        
        System.out.println( zeroPoints.invoice() );
        zeroPoints.completeInvoice(); 
    }    
}
