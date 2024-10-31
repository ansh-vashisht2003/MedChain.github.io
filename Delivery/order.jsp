<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            text-align: center;
            padding: 20px;
        }

        header {
            background-color: #4CAF50;
            color: white;
            padding: 15px;
            border-radius: 5px;
        }

        .order-list {
            margin: 20px 0;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: white;
        }

        .order {
            margin: 10px 0;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        .back-link {
            margin-top: 20px;
            display: inline-block;
            padding: 10px 20px;
            background-color: #008CBA;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .back-link:hover {
            background-color: #005f7f;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>My Orders</h1>
        </header>

        <div class="order-list">
            <div class="order">
                <h3>Order ID: 12345</h3>
                <p>Medicine: Pain Reliever</p>
                <p>Quantity: 2</p>
                <p>Status: Pending</p>
            </div>
            <div class="order">
                <h3>Order ID: 67890</h3>
                <p>Medicine: Cough Syrup</p>
                <p>Quantity: 1</p>
                <p>Status: Delivered</p>
            </div>
        </div>

        <a href="dashboard.jsp" class="back-link">Back to Dashboard</a>
    </div>
</body>
</html>
