# SMTP4Dev

Fake SMTP email server for development and testing. View and test email sending without actually delivering messages.

## Overview

SMTP4Dev is a dummy SMTP server for development and testing. It captures emails sent by your application, displays them in a web interface, and never actually sends them to real recipients.

## Features

- SMTP server for capturing emails
- Web-based email viewer
- No actual email delivery (safe for testing)
- IMAP support for email client testing
- POP3 support
- Message persistence
- Search and filter
- View HTML and plain text
- Attachments support

## Quick Start

**Linux/macOS:**
```bash
# Copy environment template
cp .env.template .env

# Start service
./start.sh

# Stop service
./stop.sh
```

**Windows:**
```cmd
# Copy environment template
copy .env.template .env

# Start service
start.bat

# Stop service
stop.bat
```

## Configuration

Edit `.env` file to customize:

| Variable | Default | Description |
|:---------|:--------|:------------|
| SMTP4DEV_VERSION | latest | SMTP4Dev image version |
| SMTP4DEV_WEB_PORT | 7777 | Web UI port |
| SMTP4DEV_SMTP_PORT | 25 | SMTP server port |
| SMTP4DEV_IMAP_PORT | 143 | IMAP server port |
| SMTP4DEV_POP3_PORT | 110 | POP3 server port |

## Accessing the Service

After starting:

- **Web UI**: http://localhost:7777
- **SMTP Server**: localhost:25
- **IMAP Server**: localhost:143
- **POP3 Server**: localhost:110

## Sending Test Emails

### Using telnet:
```bash
telnet localhost 25
EHLO localhost
MAIL FROM: <sender@example.com>
RCPT TO: <recipient@example.com>
DATA
Subject: Test Email
From: sender@example.com
To: recipient@example.com

This is a test email.
.
QUIT
```

### Using Python:
```python
import smtplib
from email.mime.text import MIMEText

msg = MIMEText("This is a test email")
msg['Subject'] = 'Test Email'
msg['From'] = 'sender@example.com'
msg['To'] = 'recipient@example.com'

with smtplib.SMTP('localhost', 25) as server:
    server.send_message(msg)

print("Email sent! Check http://localhost:7777")
```

### Using Node.js (nodemailer):
```javascript
const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
    host: 'localhost',
    port: 25,
    secure: false,
    tls: {
        rejectUnauthorized: false
    }
});

const mailOptions = {
    from: 'sender@example.com',
    to: 'recipient@example.com',
    subject: 'Test Email',
    text: 'This is a test email',
    html: '<p>This is a <b>test</b> email</p>'
};

transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
        console.log(error);
    } else {
        console.log('Email sent! Check http://localhost:7777');
    }
});
```

### Using .NET:
```csharp
using System.Net.Mail;

var message = new MailMessage
{
    From = new MailAddress("sender@example.com"),
    Subject = "Test Email",
    Body = "This is a test email"
};
message.To.Add("recipient@example.com");

using (var client = new SmtpClient("localhost", 25))
{
    client.Send(message);
}

Console.WriteLine("Email sent! Check http://localhost:7777");
```

## Application Configuration

### Spring Boot (application.properties):
```properties
spring.mail.host=localhost
spring.mail.port=25
spring.mail.properties.mail.smtp.auth=false
spring.mail.properties.mail.smtp.starttls.enable=false
```

### Django (settings.py):
```python
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'localhost'
EMAIL_PORT = 25
EMAIL_USE_TLS = False
```

### Laravel (.env):
```
MAIL_MAILER=smtp
MAIL_HOST=localhost
MAIL_PORT=25
MAIL_ENCRYPTION=null
```

## IMAP/POP3 Testing

Connect to IMAP or POP3 ports using email clients for testing email retrieval:

**IMAP:**
- Server: localhost
- Port: 143
- Username: (any)
- Password: (any)
- Encryption: None

## Persistent Volumes

This service uses one persistent volume:

- **smtp4dev-data**: Stored emails and configuration (`/smtp4dev`)

Emails persist across container restarts.

## Use in Compositions

To use this service in a higher-level composition:

```yaml
services:
  smtp4dev:
    extends:
      file: ../../services/utilities/smtp4dev/docker-compose.yml
      service: smtp4dev
```

## Health Check

```bash
curl -I http://localhost:7777
```

## Documentation

- Official Website: https://github.com/rnwood/smtp4dev
- Docker Hub: https://hub.docker.com/r/rnwood/smtp4dev
- GitHub: https://github.com/rnwood/smtp4dev

## Source Tracking

**Migrated from:** AnotherOneBytesTheDust/ContainerStore
**Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
**Source date:** 2025-09-16
**Source file:** `docker-compose.smtp4dev.yml`

---

**Service Type:** Utility (Email Testing)
**Category:** Development Tools
**Deployment:** Standalone container with persistence
