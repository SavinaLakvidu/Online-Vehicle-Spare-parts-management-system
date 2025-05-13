<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
    String loggedInUser = (String) session.getAttribute("username");
    if (loggedInUser != null) {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQS</title>
    <link rel="stylesheet" href="FAQ1Styles/FAQUser.css">
</head>
<body>
<header>
    <div class="container">
        <img src="FAQ1Styles/LOGO.png">
        <nav>
            <ul>
                <li><a href="HomePage.jsp">Home</a></li>
                <li><a href="#">Spare Parts</a></li>
                <li><a href="#">Contact Us</a></li>
                <li><a href="faqs">FAQ</a></li>              
                <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
				<% } else { %>
    			<li><a href="Login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a></li>
				<% } %>
            </ul>
        </nav>
    </div>
    <hr>
</header>
      
<section class="faq-section">
    <h2>Frequently Asked Questions</h2>
    <div class="faq-list" id="faq-container">
        <c:forEach var="faq" items="${faqs}">
            <div class="faq-item">
                <h3 class="faq-question">${faq.question}</h3>
                <p class="faq-answer">${faq.answer}</p>               

            </div>
        </c:forEach>        
    </div>
</section>
<hr>
<footer class="f2">

        <div class="f2container">
            <ul>
                <li>Wheel Deal (Pvt) Ltd, </li>
                <li> New Kandy Rd,  </li> 
                <li>Malabe, </li>
                <li>Colombo District, </li>
                <li> Sri Lanka. </li>
            </ul>
            <ul>
                <li>+94 112 123 4123 - Head Office</li>
                <li>+94 112 123 4124 - General Inquiries</li>
                <li>+94 112 123 4125 - Supplier Inquiries</li>
                <li>info@wheeldeal.com</li>
            </ul>
            

             <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3960.798467277478!2d79.96807357565235!3d6.914682800690499!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae256db1a6771c5%3A0x2c63e344ab9a7536!2sSri%20Lanka%20Institute%20of%20Information%20Technology!5e0!3m2!1sen!2slk!4v1746612820302!5m2!1sen!2slk" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"> </iframe>

        </div>

</footer>

</body>
</html>
