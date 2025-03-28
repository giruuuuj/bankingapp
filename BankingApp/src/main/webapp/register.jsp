<%@ page import="java.sql.*" %>
<%
    String error = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        if (username != null && password != null && email != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "password");
                PreparedStatement pstmt = conn.prepareStatement("INSERT INTO users (username, password, email) VALUES (?, ?, ?)");
                pstmt.setString(1, username);
                pstmt.setString(2, password); // In a real app, hash the password
                pstmt.setString(3, email);
                pstmt.executeUpdate();
                response.sendRedirect("login.jsp"); // Redirect to login page after registration
            } catch (Exception e) {
                error = "Registration failed: " + e.getMessage();
            }
        } else {
            error = "Please fill all fields.";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1>Register</h1>
        <% if (!error.isEmpty()) { %>
            <div class="error"><%= error %></div>
        <% } %>
        <form method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            <button type="submit">Register</button>
        </form>
        <p>Already have an account? <a href="login.jsp">Login here</a></p>
    </div>
</body>
</html>