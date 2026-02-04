package ood.homework4;

import ood.homework4.coupons.CouponFactory.CouponType;
/**
 *
 * @author Robert Diepenbrock
 * @Author Mattias Vargas
 */

public class Customer {
    private String _name;
    private Statement _statement;
    private int _points=0;
    private int _age;
    
    public Customer (String name, int age, int points ) {
        _name = name;
        _statement  = new Statement( );
        _age = age;
        _points = points;
    }
    
    public void cancelRental() {
        _statement = new Statement();
    }
    
    public void completeRental() {
        _points += _statement.getRentalPoints();
        cancelRental();
    }
    
    public void addRental(Rental arg) {
        _statement.addRental(arg);  
    }
    
    public void applyCoupon(  CouponType type ) {
        _statement.addCoupon(type, this);
    }
    
    public String getName() { return _name; }
    public int getAge() { return _age  ; }
    public int getPoints() { return _points; }
    public void setPoints(int points) { _points = points;}
    
    public String statement() {
        return _statement.statement(_name);
    }
    public String xmlStatement() {
        return _statement.xmlStatement(_name);
    }   
}