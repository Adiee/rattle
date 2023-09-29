import ssl
import socket
import datetime
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

#domains to check
domains = [
    {"name": "mixed.badssl.com", "port": 443},
    {"name": "google.com", "port": 443},
    
]

#to and from details
email_config = {
    "smtp_server": "smtp.gmail.com",
    "smtp_port": 465, 
    "smtp_username": "xxxxxxxxxxxxxx",
    "app_password": "xxxxxxxxxxxxxx",
    "sender_email": "xxxxxxxxxxxxxx@gmail.com",
    "recipient_email": "xxxxxxxxxxxxxx@gmail.com",
}

def check_ssl_expiry(domain, port):
    try:
        context = ssl.create_default_context()
        with socket.create_connection((domain, port)) as sock:
            with context.wrap_socket(sock, server_hostname=domain) as ssock:
                cert = ssock.getpeercert()
                #print(cert)
                #print("============")
                expiry_date = datetime.datetime.strptime(cert['notAfter'], "%b %d %H:%M:%S %Y %Z")
                #print(expiry_date)
                current_date = datetime.datetime.now()
                days_until_expiry = (expiry_date - current_date).days
                return days_until_expiry
    except Exception as e:
        print(f"Error checking SSL certificate for {domain}: {str(e)}")
        return None

def send_email_alert(domain, days_until_expiry):
    subject = f"SSL Certificate Expiry Alert: {domain}"
    body = f"The SSL certificate for {domain} will expire in {days_until_expiry} days."

    message = MIMEMultipart()
    message["From"] = email_config["sender_email"]
    message["To"] = email_config["recipient_email"]
    message["Subject"] = subject
    message.attach(MIMEText(body, "plain"))

    try:
        server = smtplib.SMTP_SSL(email_config["smtp_server"], email_config["smtp_port"])
        #print("server connected")
        server.login(email_config["sender_email"], email_config["app_password"])
        #print("logged in")
        server.sendmail(email_config["sender_email"], email_config["recipient_email"], message.as_string())
        server.quit()
        print(f"Email alert sent for {domain}")
    except Exception as e:
        print(f"Error sending email alert: {str(e)}")

for domain_info in domains:
    domain = domain_info["name"]
    port = domain_info["port"]
    days_until_expiry = check_ssl_expiry(domain, port)
    if days_until_expiry is not None and days_until_expiry < 15:
        print("Need to update the certs")
        send_email_alert(domain, days_until_expiry)
    else:
        print("All ok")
        
