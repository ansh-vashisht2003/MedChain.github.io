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
    <title>Delivery Person Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4; /* Light gray for contrast */
            color: #333;
        }

        header {
            position: relative;
            background: linear-gradient(to bottom, #333, #555);
            padding: 15px 0;
            text-align: center;
            color: #fff;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
        }

        .logo {
            font-size: 30px;
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
            font-size: 18px;
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: #ffdd57;
        }

        .hero {
            background: url('delivery-hero.jpg') no-repeat center center/cover;
            height: 400px;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .hero h1 {
            font-size: 50px;
            margin-bottom: 10px;
        }

        .hero p {
            font-size: 20px;
        }

        main {
            padding: 40px 20px;
            max-width: 1000px;
            margin: auto;
        }

        section {
            margin-bottom: 30px;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            animation: fadeInUp 0.5s ease-out;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            color: #555;
            margin-bottom: 15px;
        }

        .card {
            display: flex;
            gap: 15px;
            justify-content: space-around;
            flex-wrap: wrap;
        }

        .card-item {
            flex: 1;
            min-width: 280px;
            padding: 15px;
            border-radius: 8px;
            background: #fafafa;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s;
        }

        .card-item:hover {
            transform: translateY(-5px);
        }

        .icon {
            font-size: 40px;
            color: #ffdd57;
            margin-bottom: 10px;
        }

        footer {
            text-align: center;
            padding: 15px 0;
            background: #333;
            color: #fff;
            font-size: 14px;
        }

        /* Testimonial section */
        .testimonials {
            padding: 20px;
            text-align: center;
        }

        .testimonial-item {
            background: #e3f2fd;
            margin: 10px;
            padding: 15px;
            border-radius: 10px;
        }

        .testimonial-text {
            font-style: italic;
        }

        .testimonial-author {
            margin-top: 10px;
            font-weight: bold;
        }

    </style>
</head>
<body>
    <header>
        <nav>
            <div class="logo">Delivery Dashboard</div>
            <ul class="nav-links">
                <li><a href="dashboard.jsp">Home</a></li>
                <li><a href="yourOrders.jsp">Your Orders</a></li>
                <li><a href="past.jsp">Orders Delivered</a></li>
                <li><a href="thankYou.jsp">Logout</a></li>
            </ul>
        </nav>
    </header>

    <div class="hero" style="background-color: #FAEBD7; text-align: center; padding: 50px 20px;">
    <div style="display: inline-block; padding: 20px; background-color: #F0FFF0; border-radius: 12px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
        <h1 style="font-size: 2.5rem; color: #2E8B57; margin-bottom: 15px;">Welcome, <%= name %></h1>
        <p style="font-size: 1.25rem; color: #556B2F;">Your journey as a trusted delivery partner begins now. Delivering essential medicines efficiently and promptly.</p>
    </div>
</div>

<main style="padding: 30px 20px; max-width: 1200px; margin: auto;">
    <section id="highlights" style="margin-bottom: 30px; text-align: center;">
        <h2 style="font-size: 2rem; color: #2F4F4F; margin-bottom: 20px;">Why Choose Our Service</h2>
        <div style="display: flex; flex-wrap: wrap; gap: 20px; justify-content: center;">
            <div style="background: #fff; padding: 20px; border-radius: 12px; box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1); flex: 1; max-width: 300px;">
                <h3 style="color: #2E8B57; margin-bottom: 10px;">Reliable Delivery</h3>
                <p style="color: #333;">Ensuring timely delivery within 24 hours for urgent medical needs.</p>
            </div>
          
            <div style="background: #fff; padding: 20px; border-radius: 12px; box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1); flex: 1; max-width: 300px;">
                <h3 style="color: #2E8B57; margin-bottom: 10px;">24/7 Support</h3>
                <p style="color: #333;">Our support team is always ready to assist you with any inquiries.</p>
            </div>
        </div>
    </section>

    <section id="testimonials" style="margin-bottom: 30px;">
        <h2 style="font-size: 2rem; color: #2F4F4F; text-align: center; margin-bottom: 20px;">What Our Partners Say</h2>
        <div style="display: flex; flex-wrap: wrap; gap: 20px; justify-content: center;">
            <blockquote style="background: #FAEBD7; padding: 20px; border-radius: 12px; font-style: italic; box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1); max-width: 400px;">
                <p>"Delivering with this service has transformed how we operate. Fast and reliable!"</p>
               
            </blockquote>
            <blockquote style="background: #FAEBD7; padding: 20px; border-radius: 12px; font-style: italic; box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1); max-width: 400px;">
                <p>"The real-time tracking feature provides great peace of mind during deliveries."</p>
           
            </blockquote>
        </div>
    </section>

    <section id="cta" style="text-align: center; background: #2E8B57; padding: 40px; border-radius: 12px; color: #fff;">
        <h2 style="font-size: 2.5rem; margin-bottom: 20px;">Join Our Delivery Network</h2>
        <p style="font-size: 1.25rem;">Experience seamless and efficient deliveries. Be a part of a service that ensures the health and well-being of communities.</p>
        <a href="yourOrders.jsp" style="display: inline-block; margin-top: 20px; background: #FFDD57; padding: 10px 20px; border-radius: 8px; color: #333; text-decoration: none; font-weight: bold;">Your Orders</a>
    </section>
</main>


    <footer>
        <p>&copy; 2024 Delivery Service. All rights reserved.</p>
    </footer>
</body>
</html>
