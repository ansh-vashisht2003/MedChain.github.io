<!DOCTYPE html>
<html>
<head>
<title>Terms and Conditions - Medicine Donation</title>
<style>
    body {
        font-family: Arial, sans-serif;
        color: #333;
        background-color: #f5f5f5;
        padding: 40px;
        margin: 0;
    }

    h1 {
        color: #2F4F4F;
        font-size: 32px;
        font-weight: bold;
        text-align: center;
    }

    h2 {
        color: #4682B4;
        font-size: 28px;
        margin-top: 30px;
        margin-bottom: 15px;
        text-align: center;
    }

    .container {
        max-width: 800px;
        margin: auto;
        background-color: #fff;
        border-radius: 8px;
        padding: 30px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    }

    .button {
        background-color: #4CAF50;
        color: white;
        padding: 12px 30px;
        font-size: 16px;
        margin-top: 10px;
        border-radius: 4px;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .button-blue {
        background-color: #007BFF;
    }

    .button:hover {
        background-color: #388E3C;
    }

    .button-blue:hover {
        background-color: #0056b3;
    }

    .button-green {
        background-color: #4CAF50;
        margin-left: 10px;
    }

    .terms-section {
        padding: 20px;
        line-height: 1.6;
        border-bottom: 1px solid #eee;
    }

    .terms-section:last-of-type {
        border-bottom: none;
    }

    .terms-section p {
        color: #666;
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
        color: #ff4500;
        font-size: 18px;
    }
</style>
</head>
<body>
    <div class="container">
        <h1>MedShare</h1>
        <marquee>IMPORTANT: Please read the terms and eligibility criteria carefully before donating</marquee>

        <div class="terms-section">
            <h2>Eligibility</h2>
            <p>
                <strong>Requirements:</strong> Chemist should have proper licensing, and medicines should not be expired. Medicines should have at least 2 months of usage remaining.
                <br><br>
                <strong>Health and Medication Condition:</strong> Shops should be sanitized properly. Medicines must be in their original packaging, within expiration dates, and stored correctly to ensure their safety and efficacy.
                <br><br>
                <strong>Medicine Safety:</strong> All donated medicines should adhere to local safety and quality standards as specified by health authorities.
            </p>
        </div>

        <div class="terms-section">
            <h2>Terms and Conditions</h2>
            <p>
                By accepting these Terms and Conditions, you confirm that you understand and agree to the specified terms. Please read carefully, as this document outlines your rights and obligations.
                <br><br>
                1. <strong>Eligibility:</strong> Donors must meet the eligibility criteria set by MedChain.
                <br><br>
                2. <strong>Medicine Safety:</strong> Donated medicines must be safe for use, unopened, and within the expiration date as per local health authority guidelines.
                <br><br>
                3. <strong>Voluntary Donation:</strong> Medicine donation is entirely voluntary, and donors should not be compensated or coerced into donating.
                <br><br>
                4. <strong>Confidentiality:</strong> Donor personal information will be kept confidential and used only for purposes related to the donation process.
                <br><br>
                5. <strong>Donor Rights:</strong> Donors have the right to ask questions, receive information about the donation process, and expect respectful treatment from staff.
                <br><br>
                6. <strong>Record Keeping:</strong> MedChain will maintain accurate records of all donations, including donor information and medicine details.
                <br><br>
                7. <strong>Quality Control:</strong> MedChain reserves the right to inspect and approve all donated medicine items to ensure they meet quality and safety standards.
                <br><br>
                8. <strong>Non-Discrimination:</strong> MedChain does not discriminate against donors based on race, religion, gender, or any other personal characteristics.
                <br><br>
                9. <strong>Donation Disposal:</strong> MedChain may dispose of donated medicines that do not meet safety, quality, or storage standards.
                <br><br>
                10. <strong>Liability Waiver:</strong> MedChain is not liable for any adverse effects resulting from the donation or usage of donated medicine items.
                <br><br>
                11. <strong>Cooperation with Authorities:</strong> MedChain will cooperate with relevant authorities in cases involving medicine safety or public health concerns.
                <br><br>
                12. <strong>Feedback and Complaints:</strong> Donors are encouraged to provide feedback or report any issues or complaints regarding the donation process.
            </p>
        </div>

        <form action="medicinedonateform.jsp" method="post">
            <input type="checkbox" name="terms" value="agree" required> I have read and agreed to the terms and conditions
            <br><br>
            <input type="submit" class="button button-blue" value="Accept Terms and Conditions">
            <button type="button" class="button button-green" onclick="location.href='dashboard.jsp'">Back to Home</button>
        </form>
    </div>
</body>
</html>
