
package ood.homework4;
import ood.homework4.coupons.Coupon;
import ood.homework4.coupons.CouponFactory;

import java.util.Enumeration;
import java.util.Vector;

/**
 *
 * @author Robert Diepenbrock
 * @Author Mattias Vargas
 */
public class Statement {
    private Vector _rentals = new Vector();
    private int rentalPoints ;
    
    Statement( ) { }
    
    int getRentalPoints() { return rentalPoints; }
    
    public void addRental(Rental rental) {
        _rentals.addElement(rental);
    }
    
    public void addCoupon(CouponFactory.CouponType couponType, Customer customer ) {
        Coupon coupon = CouponFactory.build(couponType) ;
        coupon.applyCoupon(_rentals,  customer );  
    }
    
    private String xmlStatementFooter(double totalCost) {
        return "<AmountOwed>" + String.valueOf(totalCost) + "</AmountOwed>\n" 
           +   "<PointsEarned>" + rentalPoints + "</PointsEarned>\n";
    }
    
    private String statementFooter(double totalCost) {
        String result = "";
        // add footer lines
        result += "Amount owed is " + String.valueOf(totalCost) + "\n";
        result += "You earned " + String.valueOf(rentalPoints) +
                  " frequent renter points";
        return result;
    }
    
    public String xmlStatement( String custName ) {
        rentalPoints = 0 ;
        double totalCost = 0 ;
        Enumeration rentals = _rentals.elements();
        String      result  = "<statement>\n\n" + "<customerName>" + custName + "</customerName>\n";
        
        while (rentals.hasMoreElements()) {
            
            Rental rental       = (Rental) rentals.nextElement();
            double lineAmount = rental.getCost();
            rentalPoints += rental.getPoints();
            totalCost += lineAmount;
            // show figures for this rental
            result += "\t<rental>" + rental.getMovie().getTitle() + "</rental>" +
                      "<price>" + String.valueOf(lineAmount) + "</price>\n";
        }
        
        result += xmlStatementFooter( totalCost );

        return result + "</statement>\n";
    }
    
    public String statement(String custName) {
        rentalPoints = 0 ;
        double totalCost = 0 ;
        Enumeration rentals = _rentals.elements();
        String      result  = "Rental Record for " + custName + "\n";
        
        while (rentals.hasMoreElements()) {
            
            Rental rental       = (Rental) rentals.nextElement();
            double lineAmount = rental.getCost();
            rentalPoints += rental.getPoints();
            totalCost += lineAmount;
            
            // show figures for this rental
            result += "\t" + rental.getMovie().getTitle() +
                      "\t" + String.valueOf(lineAmount) + "\n";
        }
        
        result += statementFooter( totalCost );

        return result;
    } 
}
