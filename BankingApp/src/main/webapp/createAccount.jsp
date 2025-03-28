<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        double balance = Double.parseDouble(request.getParameter("balance"));

        try {
            String sql = "INSERT INTO accounts (name, email, balance) VALUES (?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setDouble(3, balance);
            pstmt.executeUpdate();

            out.println("<p>Account created successfully!</p>");
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
            <button type="submit">Create Account</button>
        </form>
        <a href="index.jsp">Back to Home</a>
    </div>
</body>
</html>