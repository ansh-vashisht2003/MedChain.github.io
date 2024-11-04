<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // Ensure the user is logged in by checking the session
    HttpSession session11 = request.getSession(false);

    String name = (session11 != null) ? (String) session.getAttribute("name") : null;
    if (session11 == null || session11.getAttribute("id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get the supplier ID from the session
    int supplierId = (int) session.getAttribute("id");

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
    <title>Delivered Orders</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: #F0F4F8; /* Light background */
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
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #457B9D;
            color: #FFF;
            font-weight: bold;
            text-transform: uppercase;
            border-bottom: 4px solid #1D3557;
        }

        td {
            background-color: #F1FAEE;
            color: #1D3557;
            border-bottom: 1px solid #A8DADC;
        }

        tbody tr:hover td {
    background-color: #A8DADC;
    color: #1D3557;
}


        tr:nth-child(even) td {
            background-color: #E9F5F3;
        }

        tr:nth-child(odd) td {
            background-color: #F1FAEE;
        }
    </style>
</head>
<body>
<header>
    <h1>Welcome to the Platform, <%= name %>!</h1>
</header>

<nav>
    <ul class="nav-links">
        <li><a href="dashboard.jsp">Overview</a></li>
        <li><a href="order.jsp">Order Requests</a></li>
        <li><a href="supplyHistory.jsp">Supply History</a></li>
        <li><a href="profile.jsp">Profile</a></li>
    </ul>
</nav>

<h1>Delivered Orders</h1>

<table>
    <thead>
        <tr>
            <th>Order Date</th>
            <th>Medicine Name</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Requesting Chemist Name</th>
            <th>Requesting Chemist Phone</th>
            <th>Delivery Person Name</th>
            <th>Delivery Person Phone</th>
        </tr>
    </thead>
    <tbody>
        <%
            try {
                // Load MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                // Connect to the database
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Medicine", "root", "password");

                // SQL query to fetch delivered orders for the logged-in supplier
                String sql = "SELECT order_date, medicine_name, quantity, price, requesting_chemist_name, requesting_chemist_phone, delivery_person_name, delivery_person_phone " +
                             "FROM orders WHERE status = 'Delivered' AND supplying_chemist_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, supplierId);
                rs = pstmt.executeQuery();

                boolean hasOrders = false;
                while (rs.next()) {
                    hasOrders = true;
        %>
                    <tr>
                        <td><%= rs.getTimestamp("order_date") %></td>
                        <td><%= rs.getString("medicine_name") %></td>
                        <td><%= rs.getInt("quantity") %></td>
                        <td>Rs.<%= rs.getFloat("price") %></td>
                        <td><%= rs.getString("requesting_chemist_name") %></td>
                        <td><%= rs.getString("requesting_chemist_phone") %></td>
                        <td><%= rs.getString("delivery_person_name") %></td>
                        <td><%= rs.getString("delivery_person_phone") %></td>
                    </tr>
        <%
                }

                // If no orders are found, display a message
                if (!hasOrders) {
        %>
                    <tr>
                        <td colspan="8" style="text-align: center; color: #888888;">No delivered orders found.</td>
                    </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='8' style='color: red; text-align: center;'>Error: " + e.getMessage() + "</td></tr>");
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
