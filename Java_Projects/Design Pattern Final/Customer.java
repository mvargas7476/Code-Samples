package ood.homeworkFinal;

import ood.homeworkFinal.coupons.CouponFactory.CouponType;
/**
 * A Customer and their invoice
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */

public class Customer {
    private String _name;
    private Invoice _invoice;
    private int _points=0;
    private int _age;
    
    public Customer (String name, int age, int points ) {
        _name = name;
        _invoice  = new Invoice( );
        _age = age;
        _points = points;
    }
    
    public void cancelInvoice() {
        _invoice = new Invoice();
    }
    
    public void completeInvoice() {
        _points += _invoice.getRentalPoints();
        cancelInvoice();
    }
    
    public void addItem(LineItem item) {
        _invoice.addLIneItem(item);  
    }
    
    public void applyCoupon(  CouponType couponType ) {
        _invoice.applyCoupon(couponType, this);
    }
    
    public String getName() { return _name; }
    
    public int getAge() { return _age  ; }
    
    public int getPoints() { return _points; }
    
    public void setPoints(int points) { _points = points;}
    
    public String invoice() {
        return _invoice.statement(_name);
    }
    public String xmlInvoice() {
        return _invoice.xmlStatement(_name);
    }   
}