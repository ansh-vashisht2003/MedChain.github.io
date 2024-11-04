<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
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

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

    // SQL query to retrieve past orders including delivery person's details
    String sql = "SELECT order_id, medicine_name, quantity, price, " +
                 "supplying_chemist_name, supplying_chemist_phone, " +
                 "delivery_person_name, delivery_person_phone, order_date " +
                 "FROM orders " +
                 "WHERE status = 'Delivered' AND supplying_chemist_id = ?";

    ps = conn.prepareStatement(sql);
    ps.setInt(1, id);
    rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Past Orders</title>
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

    h2 {
        color: #1e88e5;
        margin: 20px 0;
    }

    table {
        width: 100%;
        max-width: 1000px; /* Increased max-width for the table */
        border-collapse: collapse;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        background-color: #fff;
        border-radius: 8px;
        overflow: hidden;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 16px; /* Increased padding for more space */
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
        <nav>
            <div class="logo">Requesting Dashboard</div>
            <ul class="nav-links">
                <li><a href="dashboard.jsp">Home</a></li>
                <li><a href="order.jsp">Order Now</a></li>
                <li><a href="tot.jsp">Orders</a></li>
                <li><a href="past.jsp">Past Orders</a></li>
                <li><a href="pen.jsp">Pending Orders</a></li>
                <li><a href="contact.jsp">Profile</a></li>
            </ul>
        </nav>
    </header>

    <center>
    <h2>Past Orders</h2>
    <table>
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Medicine Name</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Supplier Name</th>
                <th>Supplier Phone</th>
                <th>Delivery Guy Name</th> <!-- New column for delivery guy name -->
                <th>Delivery Guy Phone</th> <!-- New column for delivery guy phone -->
                <th>Order Date</th> <!-- New column for order date -->
            </tr>
        </thead>
        <tbody>
            <%
                boolean hasOrders = false;
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // Date format
                while (rs.next()) {
                    hasOrders = true;
                    int orderId = rs.getInt("order_id");
                    String medicineName = rs.getString("medicine_name");
                    int quantity = rs.getInt("quantity");
                    float price = rs.getFloat("price");
                    String supplierName = rs.getString("supplying_chemist_name");
                    String supplierPhone = rs.getString("supplying_chemist_phone");
                    String deliveryGuyName = rs.getString("delivery_person_name");
                    String deliveryGuyPhone = rs.getString("delivery_person_phone");
                    java.sql.Date orderDate = rs.getDate("order_date"); // Retrieve order_date

                    String formattedDate = dateFormat.format(orderDate); // Format date
            %>
            <tr>
                <td><%= orderId %></td>
                <td><%= medicineName %></td>
                <td><%= quantity %></td>
                <td><%= price %></td>
                <td><%= supplierName %></td>
                <td><%= supplierPhone %></td>
                <td><%= deliveryGuyName %></td> <!-- Display delivery guy name -->
                <td><%= deliveryGuyPhone %></td> <!-- Display delivery guy phone -->
                <td><%= formattedDate %></td> <!-- Display the formatted date -->
            </tr>
            <%
                }
                if (!hasOrders) {
                    out.println("<tr><td colspan='9' style='text-align:center;'>No past orders available.</td></tr>");
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
