<!DOCTYPE html>
<html>
<head>
    <title>EMI Calculator</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <script>
        function calculateEMI() {
            const amount = parseFloat(document.getElementById("amount").value);
            const interestRate = parseFloat(document.getElementById("interestRate").value);
            const tenure = parseInt(document.getElementById("tenure").value);

            const monthlyInterestRate = (interestRate / 100) / 12;
            const emi = (amount * monthlyInterestRate * Math.pow(1 + monthlyInterestRate, tenure)) / (Math.pow(1 + monthlyInterestRate, tenure) - 1);

            document.getElementById("result").innerText = "EMI: $" + emi.toFixed(2);
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>EMI Calculator</h1>
        <form onsubmit="event.preventDefault(); calculateEMI();">
            <label for="amount">Loan Amount:</label>
            <input type="number" id="amount" step="0.01" required><br>
            <label for="interestRate">Interest Rate (%):</label>
            <input type="number" id="interestRate" step="0.01" required><br>
            <label for="tenure">Tenure (months):</label>
            <input type="number" id="tenure" required><br>
            <button type="submit">Calculate EMI</button>
        </form>
        <p id="result"></p>
        <a href="index.jsp">Back to Home</a>
    </div>
</body>
</html>