<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // Ensure the user is logged in by checking the session
    HttpSession session11 = request.getSession(false);
    String name = (session11 != null) ? (String) session11.getAttribute("name") : null;
    if (session11 == null || session11.getAttribute("id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get the delivery person ID from the session
    int deliveryId = (int) session11.getAttribute("id");

    // Database connection setup
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delivered Orders for Delivery Person</title>
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

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            border-radius: 10px;
            overflow: hidden;
            background-color: #ffffff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); /* Shadow for depth */
        }

        th, td {
            padding: 15px; /* Increased padding */
            text-align: left;
            border-bottom: 1px solid #A8DADC; /* Subtle border */
        }

        th {
            background-color: #457B9D;
            color: #FFF;
            font-weight: bold;
            text-transform: uppercase;
        }

        td {
            background-color: #F1FAEE;
            color: #1D3557;
        }

        tbody tr:hover {
            background-color: #A8DADC; /* Hover effect */
        }

        tr:nth-child(even) td {
            background-color: #E9F5F3;
        }

        tr:nth-child(odd) td {
            background-color: #F1FAEE;
        }

        /* Responsive design for smaller screens */
        @media (max-width: 768px) {
            table {
                font-size: 14px; /* Smaller font for mobile */
            }
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
    </header><br><br>
<center>
    <h1>Delivered Orders</h1>
</center>

<table>
    <thead>
        <tr>
            <th>Medicine Name</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Requesting Chemist Name</th>
            <th>Requesting Chemist Phone</th>
            <th>Supplier Name</th>
            <th>Supplier Phone</th>
        </tr>
    </thead>
    <tbody>
        <%
            try {
                // Load MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                // Connect to the database
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Medicine", "root", "password");

                // SQL query to fetch delivered orders for the logged-in delivery person
                String sql = "SELECT medicine_name, quantity, price, requesting_chemist_name, requesting_chemist_phone, " +
                             "supplying_chemist_name, supplying_chemist_phone " +
                             "FROM orders " +
                             "WHERE status = 'Delivered' AND delivery_person_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, deliveryId);
                rs = pstmt.executeQuery();

                boolean hasOrders = false;
                while (rs.next()) {
                    hasOrders = true;
        %>
                    <tr>
                        <td><%= rs.getString("medicine_name") %></td>
                        <td><%= rs.getInt("quantity") %></td>
                        <td>Rs.<%= rs.getFloat("price") %></td>
                        <td><%= rs.getString("requesting_chemist_name") %></td>
                        <td><%= rs.getString("requesting_chemist_phone") %></td>
                        <td><%= rs.getString("supplying_chemist_name") %></td>
                        <td><%= rs.getString("supplying_chemist_phone") %></td>
                    </tr>
        <%
                }

                // If no orders are found, display a message
                if (!hasOrders) {
        %>
                    <tr>
                        <td colspan="7" style="text-align: center; color: #888888;">No delivered orders found.</td>
                    </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='7' style='color: red; text-align: center;'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                // Close resources
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        %>
    </tbody>
</table>

</body>
</html>
