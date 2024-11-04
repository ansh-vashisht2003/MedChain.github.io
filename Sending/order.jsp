<!DOCTYPE html>
<html>
<head>
<title>Terms and Conditions - Medicine Sale</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #333;
        background-color: #d4edda; /* Light green background */
        padding: 40px;
        margin: 0;
    }

    h1 {
        color: #2e7d32; /* Dark green */
        font-size: 36px;
        font-weight: bold;
        text-align: center;
        margin-bottom: 20px;
    }

    h2 {
        color: #388e3c; /* Medium green */
        font-size: 28px;
        margin-top: 20px;
        margin-bottom: 15px;
        text-align: center;
    }

    .container {
        max-width: 900px;
        margin: auto;
        background-color: #ffffff; /* White background */
        border-radius: 15px;
        padding: 30px;
        box-shadow: 0px 4px 15px rgba(50, 205, 50, 0.3); /* Green shadow */
        margin-bottom: 30px;
    }

    .button {
        background-color: #4caf50; /* Green button */
        color: white;
        padding: 12px 30px;
        font-size: 16px;
        border-radius: 8px;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s ease, transform 0.2s ease;
        display: inline-block;
    }

    .button:hover {
        background-color: #388e3c; /* Darker green */
        transform: scale(1.05);
    }

    .terms-section {
        padding: 20px;
        line-height: 1.6;
        border-bottom: 1px solid #ddd;
        margin-bottom: 20px;
        border-radius: 8px;
    }

    .terms-section:last-of-type {
        border-bottom: none;
    }

    .terms-section p {
        color: #444;
        font-size: 16px;
    }

    form {
        text-align: center;
        margin-top: 30px;
    }

    input[type="checkbox"] {
        margin-right: 10px;
        transform: scale(1.2);
    }

    marquee {
        font-weight: bold;
        color: #d32f2f; /* Red for importance */
        font-size: 18px;
        background-color: #f1f1f1;
        padding: 5px;
        border-radius: 8px;
    }
</style>
</head>
<body>
    <div class="container">
        <h1>MedShare Platform</h1>
        <marquee>IMPORTANT: Please read the terms and conditions carefully before participating in the sale of medicines</marquee>

        <div class="terms-section">
            <h2>Eligibility for Sale</h2>
            <p>
                <strong>Licensing Requirements:</strong> All chemists must possess valid licenses to sell medicines. Sellers must ensure that their licenses are up-to-date and comply with local regulations.
                <br><br>
                <strong>Quality Assurance:</strong> Medicines listed for sale must be stored correctly, in their original packaging, and have at least 2 months before the expiration date.
                <br><br>
                <strong>Compliance:</strong> All sales must comply with regional and national healthcare guidelines to ensure consumer safety.
            </p>
        </div>

        <div class="terms-section">
            <h2>Terms and Conditions</h2>
            <p>
                By accepting these Terms and Conditions, you confirm that you understand and agree to the following points related to the sale of medicines on the MedShare platform.
                <br><br>
                1. <strong>Verification:</strong> All sellers must undergo an initial verification process to confirm their credentials and eligibility.
                <br><br>
                2. <strong>Product Integrity:</strong> Sellers must ensure that all medicines are authentic, unexpired, and properly labeled.
                <br><br>
                3. <strong>Responsibility:</strong> Sellers are responsible for maintaining the quality and safety of the medicines up to the point of handover.
                <br><br>
                4. <strong>Confidentiality:</strong> Any personal or business information shared will be kept confidential and only used for facilitating transactions on the platform.
                <br><br>
                5. <strong>Fair Pricing:</strong> Prices should reflect fair market value, and price gouging is strictly prohibited.
                <br><br>
                6. <strong>Record Keeping:</strong> MedShare will maintain detailed records of transactions for legal and quality assurance purposes.
                <br><br>
                7. <strong>Quality Inspection:</strong> MedShare reserves the right to inspect and approve all listed medicines to ensure they meet safety and quality standards.
                <br><br>
                8. <strong>Non-Discrimination:</strong> The platform does not discriminate based on the chemist’s location, size of business, or other personal characteristics.
                <br><br>
                9. <strong>Return Policy:</strong> Medicines that are damaged or do not meet listed quality standards may be returned, and sellers must honor such returns.
                <br><br>
                10. <strong>Liability Waiver:</strong> MedShare is not liable for any disputes or adverse effects arising from the sale or purchase of medicines.
                <br><br>
                11. <strong>Dispute Resolution:</strong> Any disputes between chemists must be resolved in accordance with the MedShare platform's dispute resolution guidelines.
                <br><br>
                12. <strong>Feedback:</strong> Chemists are encouraged to provide feedback or report any issues regarding their experience on the platform.
            </p>
        </div>

        <form action="salesform.jsp" method="post">
            <input type="checkbox" name="terms" value="agree" required> I have read and agreed to the terms and conditions
            <br><br>
            <input type="submit" class="button" value="Accept Terms and Conditions">
            <button type="button" class="button" onclick="location.href='dashboard.jsp'">Back to Home</button>
        </form>
    </div>
</body>
</html>
