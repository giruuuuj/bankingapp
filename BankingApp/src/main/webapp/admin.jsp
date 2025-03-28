<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ include file="dbConnection.jsp" %>

<%
// Pagination
int pageSize = 10; // Number of records per page
int pageNumber = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
int offset = (pageNumber - 1) * pageSize;

// Search Functionality
String searchQuery = request.getParameter("searchQuery");
String whereClause = "";
if (searchQuery != null && !searchQuery.isEmpty()) {
    whereClause = " WHERE a.name LIKE ? OR a.email LIKE ? OR a.account_id = ?";
}

// Sorting
String sortBy = request.getParameter("sortBy");
String sortOrder = request.getParameter("sortOrder");
if (sortBy == null) sortBy = "a.account_id";
if (sortOrder == null) sortOrder = "ASC";

// Base SQL Query
String sql = "SELECT a.account_id, a.name, a.email, p.full_name, p.address, p.phone, p.date_of_birth " +
             "FROM accounts a JOIN profiles p ON a.account_id = p.account_id" +
             whereClause + " ORDER BY " + sortBy + " " + sortOrder + " LIMIT ? OFFSET ?";

try {
    PreparedStatement pstmt = conn.prepareStatement(sql);
    if (searchQuery != null && !searchQuery.isEmpty()) {
        pstmt.setString(1, "%" + searchQuery + "%");
        pstmt.setString(2, "%" + searchQuery + "%");
        pstmt.setString(3, searchQuery);
        pstmt.setInt(4, pageSize);
        pstmt.setInt(5, offset);
    } else {
        pstmt.setInt(1, pageSize);
        pstmt.setInt(2, offset);
    }

    ResultSet rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - User Profiles</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Admin - User Profiles</h1>

        <!-- Search Form -->
        <form action="admin.jsp" method="GET">
            <input type="text" name="searchQuery" placeholder="Search by name, email, or ID" value="<%= searchQuery != null ? searchQuery : "" %>">
            <button type="submit">Search</button>
        </form>

        <!-- Table with Sorting -->
        <table>
            <tr>
                <th><a href="?sortBy=a.account_id&sortOrder=<%= sortOrder.equals("ASC") ? "DESC" : "ASC" %>">Account ID</a></th>
                <th><a href="?sortBy=a.name&sortOrder=<%= sortOrder.equals("ASC") ? "DESC" : "ASC" %>">Name</a></th>
                <th><a href="?sortBy=a.email&sortOrder=<%= sortOrder.equals("ASC") ? "DESC" : "ASC" %>">Email</a></th>
                <th><a href="?sortBy=p.full_name&sortOrder=<%= sortOrder.equals("ASC") ? "DESC" : "ASC" %>">Full Name</a></th>
                <th><a href="?sortBy=p.address&sortOrder=<%= sortOrder.equals("ASC") ? "DESC" : "ASC" %>">Address</a></th>
                <th><a href="?sortBy=p.phone&sortOrder=<%= sortOrder.equals("ASC") ? "DESC" : "ASC" %>">Phone</a></th>
                <th><a href="?sortBy=p.date_of_birth&sortOrder=<%= sortOrder.equals("ASC") ? "DESC" : "ASC" %>">Date of Birth</a></th>
                <th>Actions</th>
            </tr>
            <%
                while (rs.next()) {
                    int accountId = rs.getInt("account_id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String fullName = rs.getString("full_name");
                    String address = rs.getString("address");
                    String phone = rs.getString("phone");
                    String dob = rs.getString("date_of_birth");
            %>
            <tr>
                <td><%= accountId %></td>
                <td><%= name %></td>
                <td><%= email %></td>
                <td><%= fullName %></td>
                <td><%= address %></td>
                <td><%= phone %></td>
                <td><%= dob %></td>
                <td>
                    <a href="editProfile.jsp?id=<%= accountId %>">Edit</a>
                    <a href="deleteProfile.jsp?id=<%= accountId %>" onclick="return confirm('Are you sure you want to delete this profile?');">Delete</a>
                </td>
            </tr>
            <%
                }
            %>
        </table>

        <!-- Pagination -->
        <div class="pagination">
            <%
                if (pageNumber > 1) {
                    out.println("<a href='?page=" + (pageNumber - 1) + "&searchQuery=" + (searchQuery != null ? searchQuery : "") + "&sortBy=" + sortBy + "&sortOrder=" + sortOrder + "'>Previous</a>");
                }
                out.println("<a href='?page=" + (pageNumber + 1) + "&searchQuery=" + (searchQuery != null ? searchQuery : "") + "&sortBy=" + sortBy + "&sortOrder=" + sortOrder + "'>Next</a>");
            %>
        </div>

        <!-- Export to CSV -->
        <a href="exportProfiles.jsp" class="button">Export to CSV</a>

        <!-- Back to Home -->
        <a href="welcome.jsp">Back to Home</a>
    </div>
</body>
</html>
<%
} catch (SQLException e) {
    e.printStackTrace();
    out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
}
%>