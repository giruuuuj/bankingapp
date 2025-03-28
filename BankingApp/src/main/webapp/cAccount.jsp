<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        double balance = Double.parseDouble(request.getParameter("balance"));
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("dob");

        try {
            // Insert into accounts table
            String sql = "INSERT INTO accounts (name, email, balance) VALUES (?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setDouble(3, balance);
            pstmt.executeUpdate();

            // Get the generated account_id
            ResultSet rs = pstmt.getGeneratedKeys();
            int accountId = 0;
            if (rs.next()) {
                accountId = rs.getInt(1);
            }

            // Insert into profiles table
            sql = "INSERT INTO profiles (account_id, full_name, address, phone, date_of_birth) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, accountId);
            pstmt.setString(2, fullName);
            pstmt.setString(3, address);
            pstmt.setString(4, phone);
            pstmt.setString(5, dob);
            pstmt.executeUpdate();

            out.println("<p>Account and profile created successfully!</p>");
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Account</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Create Account</h1>
        <form method="post">
            <label for="name">Name:</label>
            <input type="text" name="name" required><br>
            <label for="email">Email:</label>
            <input type="email" name="email" required><br>
            <label for="balance">Initial Balance:</label>
            <input type="number" name="balance" step="0.01" required><br>
            <label for="fullName">Full Name:</label>
            <input type="text" name="fullName" required><br>
            <label for="address">Address:</label>
            <input type="text" name="address" required><br>
            <label for="phone">Phone:</label>
            <input type="text" name="phone" required><br>
            <label for="dob">Date of Birth:</label>
            <input type="date" name="dob" required><br>
            <button type="submit">Create Account</button>
        </form>
        <a href="index.jsp">Back to Home</a>
    </div>
</body>
</html>