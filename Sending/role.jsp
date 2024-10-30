<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Database connection
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String message = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Medicine", "root", "password");
        
        // Perform any necessary operations for requesting chemist role
        // Example: Fetch available medicines or handle requests
        
    } catch (Exception e) {
        message = "An error occurred: " + e.getMessage();
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supplying Chemist Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: antiquewhite;
            margin: 0;
            padding: 20px;
        }

        header {
            text-align: center;
            padding: 20px;
            background-color: #007bff;
            color: white;
            border-radius: 8px;
        }

        h1 {
            margin: 0;
        }

        .container {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .message {
            margin: 20px 0;
            padding: 10px;
            background-color: #d1ecf1;
            border-left: 5px solid #0c5460;
            color: #0c5460;
        }

        a {
            display: inline-block;
            margin: 10px;
            padding: 10px 20px;
            color: white;
            background-color: #28a745;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        a:hover {
            background-color: #218838;
        }

        .section {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #007bff;
            border-radius: 5px;
            background-color: #e9f7fd;
        }

        footer {
            text-align: center;
            margin-top: 20px;
            font-size: 0.9em;
            color: #555;
        }

        /* Mission section styles */
        .mission {
            text-align: center;
            margin: 20px 0;
        }

        .mission h2 {
            margin-bottom: 10px;
        }

        .mission p {
            margin: 0 0 20px;
            font-size: 1.2em;
        }

        /* Circular images */
        .circular-images {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
        }

        .circular-images img {
            width: 200px;
            height: 200px;
            border-radius: 50%;
            border: 3px solid #007bff;
            object-fit: cover;
        }

        /* Boxes for mission details */
        .mission-details {
            display: flex;
            justify-content: space-around;
        }

        .mission-box {
            background-color: #fff;
            border: 1px solid #007bff;
            border-radius: 5px;
            padding: 15px;
            flex: 1;
            margin: 0 10px;
            text-align: center;
        }

        .mission-box h3 {
            margin: 0 0 10px;
        }
    </style>
</head>
<body>
    <header>
        <h1>Supplying Chemist Dashboard</h1>
    </header>
    <p></p>
    <div class="container">
        <h2>Join Us in Improving Healthcare!</h2>
    <p>Become a part of our growing community of supplying chemists dedicated to ensuring that essential medicines are always accessible. Sign up today and make a difference!</p>
    
        <center>
            <a href="signup.jsp">Sign Up</a>
            <a href="login.jsp">Login</a>
        </center>
        
        <div class="section">
            <h2>General Information</h2>
            <p>Welcome to the Supplying Chemist Dashboard! This innovative platform seamlessly connects supplying chemists with medicine requests from small shops. With our user-friendly interface, you can efficiently manage your inventory, fulfill urgent requests, and stay informed about the latest available medicines. Our goal is to enhance collaboration within the healthcare supply chain, ensuring timely access to essential medications for your community.</p>
        </div>

        <!-- Mission Section -->
        <div class="mission">
            <h2>Our Mission</h2>
            <p>To provide efficient healthcare solutions by connecting supplying chemists with small shops to ensure timely medicine delivery.</p>
            <div class="circular-images">
                <img src="https://img.freepik.com/premium-photo/doctor-giving-medicine-patient_168410-439.jpg?w=360" alt="Image 1">
                <img src="https://satyafoundation.org/wp-content/uploads/2023/05/basoli9.jpg" alt="Image 2">
                <img src="https://img.freepik.com/premium-vector/male-doctor-uniform-riding-scooter-with-medical-surgical_132971-274.jpg" alt="Image 3">
            </div>
        </div>

        <div class="mission-details">
            <div class="mission-box">
                <h3>Quality Service</h3>
                <p>Ensuring that all medicine requests are fulfilled promptly and efficiently.</p>
            </div>
            <div class="mission-box">
                <h3>Community Support</h3>
                <p>Supporting local businesses and providing necessary resources for healthcare.</p>
            </div>
            <div class="mission-box">
                <h3>Quick Service</h3>
                <p>We make sure we deliever the medicine within 24 hours..</p>
            </div>
        </div>
        
        <div class="section">
            <h2>Recent Updates</h2>
            <ul>
                <li>New delivery options are now available for urgent requests!</li>
                <li>Updated inventory management tools for better tracking.</li>
                <li>Sign up for our newsletter to stay informed about the latest in healthcare!</li>
            </ul>
        </div>
        
        <div class="section">
            <h2>Announcements</h2>
            <p>We are launching a new mobile app soon! Stay tuned for more information.</p>
        </div>

      
        <!-- Add buttons or forms for specific operations -->
    </div>

    <footer>
        <p>&copy; 2024 Supplying Chemist Dashboard</p>
    </footer>
</body>
</html>
