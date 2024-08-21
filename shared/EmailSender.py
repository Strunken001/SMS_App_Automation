import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

def send_email(user_account, mobile_numbers, message_content, to_email):
    # Set up the server
    server = smtplib.SMTP('smtp.gmail.com', 587)  # Use your SMTP server and port
    server.starttls()

    # Login to your email account
    from_email = 'fahadbinazizconsultant@gmail.com'
    password = 'lgny rqcw nwoy vlrd'
    server.login(from_email, password)

    # Create the email
    msg = MIMEMultipart()
    msg['From'] = from_email
    msg['To'] = to_email
    msg['Subject'] = "Test Automation Notification Email from SMS_Automation_App"

    # Format the email body
    mobile_numbers_str = ','.join(mobile_numbers)
    body = f"Dear Team,\n\nA test was successfully automated on User account: {user_account} to mobile numbers: {mobile_numbers_str} with content: {message_content}.\n\nBest Regards,\nYour Automation Team"
    msg.attach(MIMEText(body, 'plain'))

    # Send the email
    server.send_message(msg)
    server.quit()

    print(f"Email sent to {to_email}")
