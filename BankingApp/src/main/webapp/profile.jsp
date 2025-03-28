<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<%
    int accountId = Integer.parseInt(request.getParameter("accountId"));

    try {
        // Fetch profile data
        String sql = "SELECT * FROM profiles WHERE account_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, accountId);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            String fullName = rs.getString("full_name");
            String address = rs.getString("address");
            String phone = rs.getString("phone");
            String dob = rs.getString("date_of_birth");
%>
            <div class="container">
                <h1>Profile</h1>
                <p><strong>Full Name:</strong> <%= fullName %></p>
                <p><strong>Address:</strong> <%= address %></p>
                <p><strong>Phone:</strong> <%= phone %></p>
                <p><strong>Date of Birth:</strong> <%= dob %></p>
                <a href="editProfile.jsp?accountId=<%= accountId %>">Edit Profile</a>
            </div>
<%
        } else {
            out.println("<p>Profile not found!</p>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Profile</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <a href="index.jsp">Back to Home</a>
</body>
</html>