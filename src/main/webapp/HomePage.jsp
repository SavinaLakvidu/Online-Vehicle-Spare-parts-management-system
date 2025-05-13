<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
 <% String username = (String) session.getAttribute("username"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wheel Deal Home Page</title>
    <link rel="stylesheet" href="HomePage_Styles/HomePage.css">
</head>
<body>

    <header>
        <div class="container">
            <img src="HomePage_Styles/LOGO.png">
            <nav>
                <ul>
                    <li><a href="#">Home</a></li>
                    <li><a href="#">Spare Parts</a></li>
                    <li><a href="#">Contact Us</a></li>
                    <li><a href="faqs?view=user">FAQ</a></li>                    
                    <% if (username != null) { %>
        			<li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
    				<% } else { %>
        			<li><a href="Login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a></li>
    				<% } %>
                </ul>
            </nav>
        </div>
    </header>


    <div class="banner">
        <img src="HomePage_Styles/r.png" alt="Banner">
        <div class="bannerText">
                <h2> Get the Right Part, Right When You Need It! </h2>
                <p>Buy high-quality vehicle spare parts for your repairs and maintenance needs to ensure optimal performance and safety. 
                    Our extensive selection of durable components guarantees a perfect fit and extends the lifespan of your vehicle. 
                    Invest in reliability and drive with confidence knowing you've chosen the best for your car from WHEEL DEAL, your trusted source for 
                    quality auto parts.</p>


         <div class="bannerButton">
                <a href="#" class="button">Browse Parts</a>
        </div>
        </div>
    </div>

    <div class="feature">
        <h3>Why Rent With Us?</h3>
        <div class="feature-grid">
            <div class="feature-item">
                <img src="HomePage_Styles/1.png" alt="Cost-Effective">
                <h4>Cost-Effective</h4>
                <p>Avoid hefty purchase costs for rarely used parts. Renting provides a cost-effective alternative,
                     eliminating the need for significant upfront investment and storage expenses
                     for parts you may only need for occasional repairs or maintenance."</p>
            </div>
            <div class="feature-item">
                <img src="HomePage_Styles/1.png" alt="Wide Selection">
                <h4>Wide Selection</h4>
                <p>AAccess a diverse inventory of spare parts for various vehicle makes and models. 
                    We offer an extensive range of components, 
                    from essential maintenance parts to specialized repair items, 
                    ensuring compatibility with both domestic and foreign automobiles.</p>
            </div>
            <div class="feature-item">
                <img src="HomePage_Styles/1.png" alt="Convenient">
                <h4>Convenient</h4>
                <p>Easy online browsing, reservation, and pickup/delivery options. 
                    Our user-friendly website allows you to quickly find the exact parts you need, reserve them with ease, and choose between convenient pickup at our locations or have them delivered straight to your doorstep.</p>
            </div>
            <div class="feature-item">
                <img src="HomePage_Styles/1.png" alt="Quality Assured">
                <h4>Quality Assured</h4>
                <p>All our parts are regularly inspected and maintained for optimal performance. We adhere to strict quality control standards, 
                    ensuring that every component is thoroughly checked and serviced to provide you with reliable, 
                    high-performing parts that meet your vehicle's needs.</p>
            </div>
        </div>
    </div>

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