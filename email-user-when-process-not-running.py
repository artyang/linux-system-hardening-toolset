import psutil
import smtplib
from email.mime.text import MIMEText

# Configuration
process_name = "PROCESS_NAME"
recipient_email = "RECIPIENT_EMAIL"
sender_email = "SENDER_EMAIL"
smtp_server = "SMTP_SERVER"
smtp_port = SMTP_PORT
smtp_username = "SMTP_USERNAME"
smtp_password = "SMTP_PASSWORD"

def check_process_running(process_name):
    for process in psutil.process_iter(['name']):
        if process.info['name'] == process_name:
            return True
    return False

def send_email(subject, message):
    msg = MIMEText(message)
    msg['Subject'] = subject
    msg['From'] = sender_email
    msg['To'] = recipient_email

    try:
        smtp_obj = smtplib.SMTP(smtp_server, smtp_port)
        smtp_obj.starttls()
        smtp_obj.login(smtp_username, smtp_password)
        smtp_obj.sendmail(sender_email, [recipient_email], msg.as_string())
        smtp_obj.quit()
        print("Email sent successfully!")
    except smtplib.SMTPException as e:
        print(f"Failed to send email. Error: {str(e)}")

# Check if the process is running
if not check_process_running(process_name):
    # Compose and send email notification
    subject = f"Process {process_name} is not running"
    message = f"The process {process_name} is not running on the system."
    send_email(subject, message)
else:
    print("Process is running.")
