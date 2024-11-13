Here are the SMTP settings for Hotmail (Outlook) and Gmail:

1. Hotmail / Outlook SMTP Settings

    SMTP Server: smtp.office365.com
    SMTP Port: 587 (for TLS)
    Encryption: TLS
    SMTP Authentication: Yes
    Username: Your full Hotmail/Outlook email address (e.g., your-email@hotmail.com)
    Password: Your Hotmail/Outlook account password

2. Gmail SMTP Settings

    SMTP Server: smtp.gmail.com
    SMTP Port: 587 (for TLS) or 465 (for SSL)
    Encryption: TLS (recommended) or SSL
    SMTP Authentication: Yes
    Username: Your full Gmail email address (e.g., your-email@gmail.com)
    Password: Your Gmail account password or an App Password (recommended for Gmail accounts with 2FA enabled)

Example Configuration for Jenkins

For Gmail (Using the Email Extension Plugin in Jenkins):

    Go to Jenkins → Manage Jenkins → Configure System.
    Under the Extended E-mail Notification section:
        SMTP server: smtp.gmail.com
        Default user e-mail suffix: @gmail.com
        SMTP port: 587
        Use SSL: Unchecked (use TLS instead)
        SMTP username: Your full Gmail email address.
        SMTP password: Your Gmail password or an App Password.
    For Hotmail, use the SMTP server smtp.office365.com, port 587, and follow the same steps for configuration.

Note: If you're using Gmail with Two-Factor Authentication (2FA), you’ll need to create an App Password from the Google Account settings. You can do this by visiting Google's App Passwords page.


