<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%
HttpSession session11 = request.getSession(false);
if (session11 == null || session11.getAttribute("name") == null) {
    response.sendRedirect("login.jsp");
    return;
}

// Retrieve session attributes safely
String name = (String) session11.getAttribute("name");
String id1 = String.valueOf(session11.getAttribute("id"));
String phoneNumber = (String) session11.getAttribute("phone_number");

// Ensure the ID is parsed only if it's valid
int id = -1;
try {
    id = Integer.parseInt(id1);
} catch (NumberFormatException e) {
    response.sendRedirect("login.jsp");
    return;
}

// Database connection variables
String jdbcURL = "jdbc:mysql://localhost:3306/Medicine"; // Adjust the URL as needed
String dbUser = "root"; // Replace with your DB user
String dbPassword = "password"; // Replace with your DB password

Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

// Action handling
String action = request.getParameter("action");
int orderId = action != null && (action.equals("accept") || action.equals("remove")) ? Integer.parseInt(request.getParameter("orderId")) : -1;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

    // Handle action
    if (action != null && orderId != -1) {
        if (action.equals("accept")) {
            // Update order status to Accepted
            String updateSql = "UPDATE orders SET status = 'Accepted', supplying_chemist_id = ?, supplying_chemist_name = ?, supplying_chemist_phone = ? WHERE order_id = ?";
            ps = conn.prepareStatement(updateSql);
            ps.setInt(1, id);
            ps.setString(2, name);
            ps.setString(3, phoneNumber);
            ps.setInt(4, orderId);
            ps.executeUpdate();
        } else if (action.equals("remove")) {
            // Hide the order from the user's view
            String hideSql = "INSERT INTO hidden_orders (id, order_id) VALUES (?, ?) ON DUPLICATE KEY UPDATE order_id = order_id"; // Prevent duplicates
            ps = conn.prepareStatement(hideSql);
            ps.setInt(1, id);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        }
        // Redirect to refresh the page and reflect changes
        response.sendRedirect("salesform.jsp");
        return;
    }

    // Query to get pending orders excluding those hidden by the user
    String sql = "SELECT o.order_id, o.requesting_chemist_name, o.requesting_chemist_phone, " +
                 "o.medicine_name, o.price, o.quantity " +
                 "FROM orders o " +
                 "LEFT JOIN hidden_orders h ON o.order_id = h.order_id AND h.id = ? " +
                 "WHERE o.status = 'Pending' AND h.order_id IS NULL";

    ps = conn.prepareStatement(sql);
    ps.setInt(1, id);
    rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Form</title>
    <style>
        /* Add your CSS styles */
        body {
            font-family: 'Roboto', sans-serif;
            background: #F0F4F8;
            color: #333;
            margin: 0;
        }
        header {
            background: linear-gradient(90deg, #2D6A4F, #52B788);
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
        h2 {
            color: #1e88e5;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            max-width: 800px;
            border-collapse: collapse;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #1e88e5;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #e3f2fd;
        }
        .action-buttons {
            display: flex;
            gap: 5px;
        }
        .action-buttons a {
            text-decoration: none;
            padding: 8px 12px;
            border-radius: 4px;
            color: white;
            font-weight: bold;
        }
        .accept {
            background-color: #28a745;
        }
        .remove {
            background-color: #dc3545;
        }
        .accept:hover {
            background-color: #218838;
        }
        .remove:hover {
            background-color: #c82333;
        }
        @media (max-width: 600px) {
            table {
                width: 100%;
                font-size: 14px;
            }
            h2 {
                font-size: 20px;
            }
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
    <center>
    <h2>Pending Orders</h2>
    <table>
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Requesting Chemist Name</th>
                <th>Phone Number</th>
                <th>Medicine Name</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                boolean hasOrders = false;
                while (rs.next()) {
                    hasOrders = true;
                    orderId = rs.getInt("order_id");
                    String chemistName = rs.getString("requesting_chemist_name");
                    String chemistPhone = rs.getString("requesting_chemist_phone");
                    String medicineName = rs.getString("medicine_name");
                    float price = rs.getFloat("price");
                    int quantity = rs.getInt("quantity");
            %>
            <tr>
                <td><%= orderId %></td>
                <td><%= chemistName %></td>
                <td><%= chemistPhone %></td>
                <td><%= medicineName %></td>
                <td><%= price %></td>
                <td><%= quantity %></td>
                <td class="action-buttons">
                    <a href="?action=accept&orderId=<%= orderId %>" class="accept">Accept</a>
                    <a href="?action=remove&orderId=<%= orderId %>" class="remove">Reject</a>
                </td>
            </tr>
            <%
                }
                if (!hasOrders) {
                    out.println("<tr><td colspan='7' style='text-align:center;'>No pending orders available.</td></tr>");
                }
            %>
        </tbody>
    </table>
    </center>
<%
} catch (Exception e) {
    e.printStackTrace();
    out.println("<p>Error: " + e.getMessage() + "</p>");
} finally {
    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
    if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
}
%>
</body>
</html>
