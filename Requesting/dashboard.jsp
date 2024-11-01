<%@ page import="java.sql.*" %>
<%

HttpSession session1 = request.getSession(false);
String name = (session1 != null) ? (String) session.getAttribute("name") : null;

if (name == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Requesting Medicine Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #E8F0F2; /* Light cyan background */
            color: #2C3E50; /* Dark gray text color */
        }

        header {
            position: relative;
            text-align: center;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #34495E; /* Dark blue-gray for navbar */
            padding: 10px 20px;
        }

        .logo {
            color: #F4D03F; /* Gold logo color */
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
            color: #F4F6F6; /* Light white text */
            text-decoration: none;
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: #85C1E9; /* Light blue hover effect */
        }

        main {
            padding: 20px;
            max-width: 800px;
            margin: auto;
        }

        section {
            margin: 20px 0;
            padding: 20px;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        footer {
            text-align: center;
            padding: 10px 0;
            background: #34495E;
            color: #F4F6F6;
            position: relative;
            bottom: 0;
            width: 100%;
        }

        h1, h2 {
            color: #2C3E50; /* Consistent heading color */
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
            <div class="logo">Requesting Dashboard</div>
            <ul class="nav-links">
                <li><a href="#home">Home</a></li>
                <li><a href="order.jsp">Order Now</a></li>
                <li><a href="past.jsp">Past Orders</a></li>
                <li><a href="contact.jsp">Profile</a></li>
            </ul>
        </nav>
    </header>
    
    <main>
       <section id="home">
    <h1>Welcome, <%= name %>!</h1>
    <p>We are here to make your pharmacy operations smoother and more efficient. Easily request essential medicines, keep track of your inventory needs, and get reliable assistance whenever you need it. Access the latest in pharmaceutical supplies with just a few clicks!</p>
</section>

<section id="about">
    <h2>About Us</h2>
    <p>Our mission is to streamline medicine procurement for chemists by ensuring fast, secure, and tailored access to essential drugs and supplies. Partnered with leading pharmaceutical distributors, we aim to support your commitment to community health by delivering medicines when you need them. Whether you are managing high demand, emergency stockouts, or seasonal shortages, we are here to keep your shelves full and your patients satisfied.</p>
    <p>With our user-friendly platform, inventory tracking, and quick delivery services, you can focus on what matters most is providing quality care.</p>
</section>

<section id="services">
    <h2>Order Services</h2>
    <p>As a registered chemist, you have exclusive access to our range of order management services designed to simplify the ordering process:</p>
    <ul>
        <li><strong>Easy Order Placement:</strong> Quickly search for and order medicines from our extensive catalog. Place single or bulk orders at your convenience.</li>
        <li><strong>Real-Time Order Tracking:</strong> Stay updated on your orders from dispatch to delivery. Access tracking details anytime to ensure you are prepared for incoming shipments.</li>
        <li><strong>Order History:</strong> View your past orders, allowing for easy reordering of high-demand items and better inventory planning.</li>
        <li><strong>24/7 Support Access:</strong> Our support team is available around the clock to answer questions, provide order updates, and assist with any issues that may arise.</li>
    </ul>
</section>

<section id="contact">
    <h2>Contact Information</h2>
    <p>If you need assistance, our dedicated support team is here to help! Reach out to us through the following channels:</p>
    <ul>
        <li><strong>Email:</strong> <a href="mailto:support@medchain.in">support@medchain.in</a> Contact us for any account, order, or technical inquiries.</li>
        <li><strong>Phone:</strong> +91 3464328750 — Available during business hours for urgent assistance.</li>
        <li><strong>Live Chat:</strong> Access our online chat support for quick answers and guidance during your order process.</li>
        <li><strong>Address:</strong> NMAMIT, Nitte ,Karkata, India 1406003</li>
    </ul>
</section>

    </main>

    <footer>
        <p>&copy; 2024 MedChain Delivery. All rights reserved.</p>
    </footer>
</body>
</html>

