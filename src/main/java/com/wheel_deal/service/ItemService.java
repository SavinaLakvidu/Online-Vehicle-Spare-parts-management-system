package com.wheel_deal.service;

import com.wheel_deal.model.Item;
import com.wheel_deal.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemService implements ItemServiceInterface {
    
    // Add Item
    @Override
    public boolean createItem(Item item) {
    	
        // Validate price
        if (item.getPrice() < 0) {
            System.err.println("Error: Cannot add item with negative price.");
            return false;
        }
    	
    	String checkQuery = "SELECT PartID, QuantityInStock FROM InventoryManagement WHERE PartName = ? AND Category = ? AND Price = ?";
        String updateQuery = "UPDATE InventoryManagement SET QuantityInStock = ?, LastUpdated = ? WHERE PartID = ?";
        String insertQuery = "INSERT INTO InventoryManagement (PartName, Category, QuantityInStock, Price, SupplierName, DateAdded, LastUpdated) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            // Check for existing item
            try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                checkStmt.setString(1, item.getPartName());
                checkStmt.setString(2, item.getCategory());
                checkStmt.setDouble(3, item.getPrice());

                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    // If item exists, update quantity
                    int partId = rs.getInt("PartID");
                    int existingQty = rs.getInt("QuantityInStock");
                    int newQty = existingQty + item.getQuantityInStock();

                    try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                        updateStmt.setInt(1, newQty);
                        updateStmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
                        updateStmt.setInt(3, partId);
                        return updateStmt.executeUpdate() > 0;
                    }
                } else {
                    // If item does not exist, insert it
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                        insertStmt.setString(1, item.getPartName());
                        insertStmt.setString(2, item.getCategory());
                        insertStmt.setInt(3, item.getQuantityInStock());
                        insertStmt.setDouble(4, item.getPrice());
                        insertStmt.setString(5, item.getSupplierName());
                        insertStmt.setDate(6, new java.sql.Date(item.getDateAdded().getTime()));
                        insertStmt.setTimestamp(7, new java.sql.Timestamp(item.getLastUpdated().getTime()));
                        return insertStmt.executeUpdate() > 0;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get Item by ID
    @Override
    public Item getItem(int partId) {
        String query = "SELECT * FROM InventoryManagement WHERE PartID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, partId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Item item = new Item();
                item.setPartId(rs.getInt("PartID"));
                item.setPartName(rs.getString("PartName"));
                item.setCategory(rs.getString("Category"));
                item.setQuantityInStock(rs.getInt("QuantityInStock"));
                item.setPrice(rs.getDouble("Price"));
                item.setSupplierName(rs.getString("SupplierName"));
                item.setDateAdded(rs.getDate("DateAdded"));
                item.setLastUpdated(rs.getTimestamp("LastUpdated"));
                return item;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get All Items
    @Override
    public List<Item> getAllItems() {
        List<Item> items = new ArrayList<>();
        String query = "SELECT * FROM InventoryManagement";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Item item = new Item();
                item.setPartId(rs.getInt("PartID"));
                item.setPartName(rs.getString("PartName"));
                item.setCategory(rs.getString("Category"));
                item.setQuantityInStock(rs.getInt("QuantityInStock"));
                item.setPrice(rs.getDouble("Price"));
                item.setSupplierName(rs.getString("SupplierName"));
                item.setDateAdded(rs.getDate("DateAdded"));
                item.setLastUpdated(rs.getTimestamp("LastUpdated"));
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    // Update Item
    @Override
    public boolean updateItem(Item item) {
    	
    	item.updateItemDetails(item.getPartName(), item.getCategory(), item.getQuantityInStock(), item.getPrice(), item.getSupplierName());
    	
        String query = "UPDATE InventoryManagement SET PartName = ?, Category = ?, QuantityInStock = ?, Price = ?, " +
                       "SupplierName = ?, DateAdded = ?, LastUpdated = ? WHERE PartID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, item.getPartName());
            stmt.setString(2, item.getCategory());
            stmt.setInt(3, item.getQuantityInStock());
            stmt.setDouble(4, item.getPrice());
            stmt.setString(5, item.getSupplierName());
            stmt.setDate(6, new java.sql.Date(item.getDateAdded().getTime()));
            stmt.setTimestamp(7, new java.sql.Timestamp(item.getLastUpdated().getTime()));
            stmt.setInt(8, item.getPartId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Item
    @Override
    public boolean deleteItem(int partId) {
        String query = "DELETE FROM InventoryManagement WHERE PartID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, partId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
