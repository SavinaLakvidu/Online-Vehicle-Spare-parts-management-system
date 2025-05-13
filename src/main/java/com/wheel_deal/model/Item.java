package com.wheel_deal.model;

import java.util.Date;

public class Item extends AbstractItem {

    public Item() {}

    @Override
    public void updateItemDetails(String partName, String category, int quantityInStock, double price, String supplierName) {
        // Implement logic to update item details
        setPartName(partName);
        setCategory(category);
        setQuantityInStock(quantityInStock);
        setPrice(price);
        setSupplierName(supplierName);
        setLastUpdated(new Date());
    }

    @Override
    public String toString() {
        return "Item{" +
                "partId=" + getPartId() +
                ", partName='" + getPartName() + '\'' +
                ", category='" + getCategory() + '\'' +
                ", quantityInStock=" + getQuantityInStock() +
                ", price=" + getPrice() +
                ", supplierName='" + getSupplierName() + '\'' +
                ", dateAdded=" + getDateAdded() +
                ", lastUpdated=" + getLastUpdated() +
                '}';
    }
}
