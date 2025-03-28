<!DOCTYPE html>
<html>
<head>
    <title>Banking Application</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <script>
        // Function to toggle dark mode
        function toggleDarkMode() {
            const body = document.body;
            body.classList.toggle("dark-mode");

            // Save the theme preference in localStorage
            if (body.classList.contains("dark-mode")) {
                localStorage.setItem("theme", "dark");
            } else {
                localStorage.setItem("theme", "light");
            }
        }

        // Set the theme on page load
        document.addEventListener("DOMContentLoaded", () => {
            const savedTheme = localStorage.getItem("theme");
            if (savedTheme === "dark") {
                document.body.classList.add("dark-mode");
            }
        });
    </script>
</head>
<body>
    <!-- Header with SBI text -->
    <header>
        <h1>SBI</h1>
    </header>

    <!-- Dark Mode Toggle Button -->
    <button onclick="toggleDarkMode()">Toggle Dark Mode</button>

    <!-- Main Content -->
    <div class="container">
        <h1>Welcome to the Banking Application</h1>
        <ul>
              <li><a href="cAccount.jsp">Register</a></li>
            <li><a href="createAccount.jsp">Create Account</a></li>
            <li><a href="deposit.jsp">Deposit Money</a></li>
            <li><a href="withdraw.jsp">Withdraw Money</a></li>
            <li><a href="balance.jsp">Check Balance</a></li>
            <li><a href="transactions.jsp">View Transaction History</a></li>
            <li><a href="applyLoan.jsp">apply Loan</a></li>
            
            <li><a href="emiCalculator.jsp">Calculator</a></li>
             <li><a href="feedback.jsp">feedback</a></li>
        </ul>
    </div>
</body>
</html>