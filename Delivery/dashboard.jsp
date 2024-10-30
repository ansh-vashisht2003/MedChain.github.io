<%@ page import="java.sql.*" %>
<%

// Retrieve the session
HttpSession session1 = request.getSession(false);
// Get the name from the session
String name = (session1 != null) ? (String) session.getAttribute("name") : null;

// Check if the user is logged in
if (name == null) {
    // If there is no session, redirect to the login page
    response.sendRedirect("login.jsp");
    return;
}
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delivery Person Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            background-color: #FAEBD7; /* Antique White */
            color: #333;
        }

        header {
            position: relative;
            text-align: center;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #333;
            padding: 10px 20px;
        }

        .logo {
            color: #fff;
            font-size: 24px;
            font-weight: bold;
        }

        .nav-links {
            list-style: none;
            display: flex;
        }

        .nav-links li {
            margin: 0 15px;
        }

        .nav-links a {
            color: #fff;
            text-decoration: none;
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: #ffdd57; /* Hover effect color */
        }

        .header-image img {
            width: 100%;
            height: auto;
        }

        main {
            padding: 20px;
            max-width: 800px;
            margin: auto;
        }

        section {
            margin: 20px 0;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        footer {
            text-align: center;
            padding: 10px 0;
            background: #333;
            color: #fff;
            position: relative;
            bottom: 0;
            width: 100%;
        }

        .section-image img {
            width: 100%;
            height: auto;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <header>
        <nav>
            <div class="logo">Delivery Dashboard</div>
            <ul class="nav-links">
                <li><a href="#home">Home</a></li>
                <li><a href="yourOrders.jsp">Your Orders</a></li>
                <li><a href="past.jsp">Past Orders</a></li>
                <li><a href="thankYou.jsp">Logout</a></li>
                
            </ul>
        </nav>
    </header>
    
    <main>
        <section id="home">
            <h1>Welcome, <%= name %></h1> <!-- Display the delivery person's name here -->
            <p>Your journey begins here. Check your pending deliveries and manage your orders!</p>
        </section>

        <section id="about">
    <h2>About Us</h2>
    <p>At our delivery service, we are dedicated to ensuring that essential medicines reach chemist shops within 24 hours. We understand the critical role that timely access to medications plays in the healthcare of communities.</p>
    <p>Our mission is to streamline the supply chain for local chemists, enabling them to serve their customers effectively and efficiently. We partner with trusted suppliers to guarantee that a wide range of medicines is readily available for prompt delivery.</p>
    <p>Our experienced team and advanced logistics ensure that all orders are processed swiftly, with real-time tracking and updates for both chemists and delivery personnel. We are committed to reliability, efficiency, and excellence in service, making healthcare more accessible for everyone.</p>
</section>

        <section id="services">
    <h2>Delivery Services</h2>
    <p>Our delivery service is designed to meet the unique needs of chemist shops, ensuring that essential medicines are delivered swiftly and efficiently. We offer a range of services to enhance your delivery experience:</p>
    
    <ul>
        <li><strong>24-Hour Delivery:</strong> We guarantee that all orders placed before the cut-off time will be delivered within 24 hours, ensuring your shop is always stocked with the medications your customers need.</li>
        
        <li><strong>Real-Time Tracking:</strong> Our advanced tracking system allows you to monitor your orders in real-time, providing transparency and peace of mind throughout the delivery process.</li>
        
        <li><strong>Flexible Delivery Options:</strong> Choose from various delivery time slots that best fit your shop's schedule, including same-day delivery for urgent requests.</li>
        
        <li><strong>Secure Handling:</strong> All medications are handled with the utmost care and delivered in compliance with safety regulations, ensuring that they arrive in perfect condition.</li>
        
        <li><strong>Dedicated Support:</strong> Our customer support team is available 24/7 to assist with any queries or issues you may encounter during the delivery process.</li>
    </ul>

    <p>With our commitment to reliability and service excellence, we strive to be the go-to delivery partner for chemist shops, helping you provide the best care for your customers.</p>
</section>


        <section id="contact">
    <h2>Contact Us</h2>
    <p>We value your feedback and are here to assist you with any questions or concerns you may have. Our dedicated support team is ready to help you!</p>
    
    <h3>Get in Touch</h3>
    <p>For inquiries or assistance, please use one of the following methods:</p>
    
    <ul>
        <li><strong>Email:</strong> <a href="mailto:demo@gmail.com.com"> queries@medchain.in</a> - Reach out to us for any queries or support requests.</li>
        <li><strong>Phone:</strong> +91 3464328750 - Call our support team for immediate assistance.</li>
        <li><strong>Live Chat:</strong> Visit our website to use our live chat feature for quick answers to your questions.</li>
        <li><strong>Office Hours:</strong> Monday to Friday, 9 AM to 5 PM - We're available during these hours to take your calls and respond to emails.</li>
    </ul>

    <p>We are committed to providing you with the best possible service. Your satisfaction is our priority, and we look forward to assisting you!</p>
</section>
        
    </main>

    <footer>
        <p>&copy; 2024 Delivery Service. All rights reserved.</p>
    </footer>
</body>
</html>
