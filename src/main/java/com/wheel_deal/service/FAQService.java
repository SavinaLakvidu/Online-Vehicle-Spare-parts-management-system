package com.wheel_deal.service;

import com.wheel_deal.model.FAQs;
import com.wheel_deal.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FAQService {

	    // Create FAQ
	    public boolean createFAQ(FAQs faq) {
	        String query = "INSERT INTO FAQs (question, answer) VALUES (?, ?)";
	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement stmt = connection.prepareStatement(query)) {
	            stmt.setString(1, faq.getQuestion());
	            stmt.setString(2, faq.getAnswer());
	            return stmt.executeUpdate() > 0;
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return false;
	    }

	    // Get FAQ by ID
	    public FAQs getFAQ(int faqid) {
	        String query = "SELECT * FROM FAQs WHERE faqid = ?";
	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement stmt = connection.prepareStatement(query)) {
	            stmt.setInt(1, faqid);
	            ResultSet rs = stmt.executeQuery();
	            if (rs.next()) {
	                FAQs faq = new FAQs();
	                faq.setFaqid(rs.getInt("faqid"));
	                faq.setQuestion(rs.getString("question"));
	                faq.setAnswer(rs.getString("answer"));
	                faq.setCreated_at(rs.getDate("created_at"));
	                return faq;
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return null;
	    }

	    // Get All FAQs
	    public List<FAQs> getAllFAQs() {
	        List<FAQs> faqs = new ArrayList<>();
	        String query = "SELECT * FROM FAQs";
	        try (Connection connection = DBConnection.getConnection();
	             Statement stmt = connection.createStatement()) {
	            ResultSet rs = stmt.executeQuery(query);
	            while (rs.next()) {
	                FAQs faq = new FAQs();
	                faq.setFaqid(rs.getInt("faqid"));
	                faq.setQuestion(rs.getString("question"));
	                faq.setAnswer(rs.getString("answer"));
	                faq.setCreated_at(rs.getDate("created_at"));
	                faqs.add(faq);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return faqs;
	    }

	    // Update FAQ
	    public boolean updateFAQ(FAQs faq) {
	        String query = "UPDATE FAQs SET question = ?, answer = ? WHERE faqid = ?";
	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement stmt = connection.prepareStatement(query)) {
	            stmt.setString(1, faq.getQuestion());
	            stmt.setString(2, faq.getAnswer());
	            stmt.setInt(3, faq.getFaqid());
	            return stmt.executeUpdate() > 0;
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return false;
	    }

	    // Delete FAQ
	    public boolean deleteFAQ(int faqid) {
	        String query = "DELETE FROM FAQs WHERE faqid = ?";
	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement stmt = connection.prepareStatement(query)) {
	            stmt.setInt(1, faqid);
	            return stmt.executeUpdate() > 0;
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return false;
	    }
	}
	
	

