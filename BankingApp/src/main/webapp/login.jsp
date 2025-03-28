<%@ page import="java.sql.*" %>
<%
    String error = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null && password != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "password");
                PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?");
                pstmt.setString(1, username);
                pstmt.setString(2, password); // In a real app, compare hashed passwords
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    session.setAttribute("user", username); // Store username in session
                    response.sendRedirect("index.jsp"); // Redirect to home page after login
                } else {
                    error = "Invalid username or password.";
                }
            } catch (Exception e) {
                error = "Login failed: " + e.getMessage();
            }
        } else {
            error = "Please fill all fields.";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1>Login</h1>
        <% if (!error.isEmpty()) { %>
            <div class="error"><%= error %></div>
        <% } %>
        <form method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <button type="submit">Login</button>
        </form>
        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
    </div>
</body>
</html>