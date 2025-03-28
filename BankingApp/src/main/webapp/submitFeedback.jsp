<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ include file="dbConnection.jsp" %>

<%
// Retrieve form data
String name = request.getParameter("name");
String email = request.getParameter("email");
String message = request.getParameter("message");

if (name != null && email != null && message != null) {
    try {
        // Insert feedback into the database
        String sql = "INSERT INTO feedback (name, email, message) VALUES (?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, message);
        pstmt.executeUpdate();

        // Display success message
        out.println("<p class='success'>Thank you for your feedback!</p>");
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p class='error'>An error occurred while submitting your feedback. Please try again.</p>");
    }
} else {
    out.println("<p class='error'>Please fill out all fields in the form.</p>");
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Feedback Submitted</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <a href="feedback.jsp">Back to Feedback Form</a>
    </div>
</body>
</html>