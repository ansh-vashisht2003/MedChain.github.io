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
    <title>Sending Chemist Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: #F0F4F8; /* Light, calming background */
            color: #333;
            margin: 0;
        }

        header {
            background: linear-gradient(90deg, #2D6A4F, #52B788); /* Green gradient */
            padding: 15px;
            color: #FFF;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        nav {
            display: flex;
            justify-content: space-around;
            background: #74C69D;
            padding: 10px 0;
        }

        .nav-links {
            list-style: none;
            display: flex;
            gap: 20px;
        }

        .nav-links li {
            display: inline;
        }

        .nav-links a {
            color: #FFF;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 15px;
            background: #2D6A4F;
            border-radius: 5px;
            transition: background 0.3s, transform 0.2s;
        }

        .nav-links a:hover {
            background: #52B788;
            transform: scale(1.05);
        }

        main {
            padding: 20px;
            max-width: 1100px;
            margin: auto;
        }

        section {
            margin: 20px 0;
            padding: 30px;
            background: #FFF;
            border-radius: 12px;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
            border-left: 5px solid #52B788;
        }

        footer {
            background: #2D6A4F;
            color: #FFF;
            text-align: center;
            padding: 15px 0;
            margin-top: 20px;
            box-shadow: 0 -4px 6px rgba(0, 0, 0, 0.1);
        }

        h1, h2 {
            color: #2C3E50; /* Consistent heading color */
        }

        ul {
            list-style: circle;
            margin-left: 20px;
        }

        p {
            line-height: 1.6;
        }

        .highlight {
            color: #52B788;
            font-weight: bold;
        }

        a {
            color: #2D6A4F;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .cta-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background: #52B788;
            color: #FFF;
            text-transform: uppercase;
            font-weight: bold;
            border-radius: 8px;
            box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
            transition: background 0.3s, transform 0.2s;
        }

        .cta-button:hover {
            background: #2D6A4F;
            transform: translateY(-3px);
        }
    </style>
</head>
<body>
    <header>
        <h1>Welcome to the Platform, <%= name %>!</h1>
    </header>
    
    <nav>
        <ul class="nav-links">
            <li><a href="#overview">Overview</a></li>
        <%--     <li><a href="#services">Services</a></li>
          <li><a href="#contact">Contact</a></li>   --%> 
            <li><a href="order.jsp">Order Requests</a></li>
            <li><a href="supplyHistory.jsp">Supply History</a></li>
            <li><a href="profile.jsp">Profile</a></li>
           
        </ul>
    </nav>

    <main>
        <section id="overview">
            <h2>Dashboard Overview</h2>
            <p>Stay informed about the current status of your orders and track all ongoing requests. Utilize this dashboard to efficiently manage your supply commitments and view key insights on recent requests and delivery statuses.</p>
            <a href="order.jsp" class="cta-button">View New Requests</a>
        </section>

        <section id="services">
            <h2>Our Services</h2>
            <p>We provide a range of services to support chemists, including:</p>
            <ul>
                <li>Real-time order tracking and management.</li>
                <li>Comprehensive supply history and records.</li>
                <li>Inventory updates and reminders for low stock.</li>
                <li>Detailed analytics for better decision-making.</li>
            </ul>
            <p>Our platform ensures streamlined communication between chemists and suppliers for a seamless experience.</p>
        </section>

        <section id="contact">
            <h2>Contact Us</h2>
            <p>If you have any questions, concerns, or feedback, feel free to reach out:</p>
            <p>Email: <a href="mailto:support@medchain.com">support@medchain.com</a></p>
            <p>Phone: +1 (800) 555-0199</p>
            <p>Address: 123 MedChain Street, Pharma City, PC 12345</p>
            <p>We look forward to assisting you with your inquiries!</p>
        </section>

        <section id="updates">
            <h2>Latest Updates</h2>
            <p class="highlight">New order requests and supply notifications will appear here as they are received. Keep an eye out for urgent updates!</p>
            <p>Review your current inventory and make timely dispatches to ensure prompt delivery to requesting chemists.</p>
        </section>
    </main>

    <footer>
        <p>&copy; 2024 MedChain Network. Empowering better pharmacy services.</p>
    </footer>
</body>
</html>

