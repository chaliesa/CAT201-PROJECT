package com.purrfectstore.model;

import java.io.Serializable;

public class CartItem implements Serializable {
    private String name;
    private double price;
    private int qty;

    public CartItem() {}

    public CartItem(String name, double price, int qty) {
        this.name = name;
        this.price = price;
        this.qty = qty;
    }

    public String getName() { return name; }
    public double getPrice() { return price; }
    public int getQty() { return qty; }
    public void setQty(int qty) { this.qty = qty; }
    public double getSubtotal() { return price * qty; }
}
