<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MedChain - Home</title>
    <style>
        /* Add your styles here */
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background: linear-gradient(to bottom right, #83a4d4, #b6fbff);
            color: #333;
        }
        .container {
            text-align: center;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            width: 80%;
            max-width: 500px;
        }
        h1 {
            font-size: 2em;
            margin-bottom: 0.5em;
            color: #3a8dc5;
        }
        .role {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .button {
            padding: 15px 25px;
            font-size: 1em;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            color: #fff;
        }
        .button:hover {
            opacity: 0.8;
        }
        .request { background-color: #4caf50; }
        .supply { background-color: #2196f3; }
        .delivery { background-color: #ff9800; }
    </style>
</head>
<body>
    <div class="container">
        <h1>MedChain</h1>
        <p>Select your role to proceed:</p>
        <div class="role">
            <button class="button request" onclick="location.href='Requesting/role.jsp'">Chemist (Requesting Medicine)</button>
            <button class="button supply" onclick="location.href='Sending/role.jsp'">Chemist (Supplying Medicine)</button>
            <button class="button delivery" onclick="location.href='Delivery/role.jsp'">Delivery Person</button>
        </div>
    </div>
</body>
</html>
