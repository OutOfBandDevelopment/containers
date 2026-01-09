# Keycloak

Open-source Identity and Access Management (IAM) solution for modern applications and services.

## Overview

Keycloak provides user authentication and authorization for applications. It supports single sign-on (SSO), social login, user federation, and fine-grained authorization policies.

## Features

- Single Sign-On (SSO)
- Identity Brokering and Social Login
- User Federation (LDAP, Active Directory)
- OAuth 2.0 and OpenID Connect
- SAML 2.0 support
- Fine-grained Authorization Services
- Multi-tenancy with Realms
- Admin Console
- Account Management Console
- Standard protocols support

## Quick Start

**Linux/macOS:**
```bash
# Copy environment template
cp .env.template .env

# Edit configuration (IMPORTANT: Change admin credentials)
nano .env

# Build and start service
./build.sh
./start.sh

# Stop service
./stop.sh
```

**Windows:**
```cmd
# Copy environment template
copy .env.template .env

# Edit configuration (IMPORTANT: Change admin credentials)
notepad .env

# Build and start service
build.bat
start.bat

# Stop service
stop.bat
```

## Configuration

Edit `.env` file to customize:

| Variable | Default | Description |
|:---------|:--------|:------------|
| KEYCLOAK_PORT | 8081 | Web UI and API port |
| KEYCLOAK_ADMIN | admin | Admin username (CHANGE!) |
| KEYCLOAK_ADMIN_PASSWORD | YourStrong@Password | Admin password (CHANGE!) |

## Accessing the Service

After starting:

- **Admin Console**: http://localhost:8081
- **Realm**: local-dev (pre-configured)
- **Username**: admin (or from .env)
- **Password**: (from .env)

## Pre-configured Realm

This service includes a `local-dev` realm configuration with:
- User registration enabled
- Remember me enabled
- Login with email allowed
- Password reset allowed

## Creating a Realm

1. Login to Admin Console
2. Click dropdown in top-left (currently shows "master")
3. Click "Create Realm"
4. Enter realm name
5. Click "Create"

## Creating a Client

1. Select your realm
2. Navigate to Clients → Create client
3. Enter Client ID (e.g., `my-app`)
4. Select Client authentication
5. Configure valid redirect URIs
6. Save

## Creating Users

1. Select your realm
2. Navigate to Users → Add user
3. Enter username and email
4. Click "Create"
5. Go to Credentials tab
6. Set password
7. Toggle "Temporary" off for permanent password

## OAuth 2.0 / OpenID Connect Example

**Authorization Code Flow:**

1. **Authorization URL:**
```
http://localhost:8081/realms/local-dev/protocol/openid-connect/auth?client_id=my-app&redirect_uri=http://localhost:3000/callback&response_type=code&scope=openid
```

2. **Token Exchange:**
```bash
curl -X POST http://localhost:8081/realms/local-dev/protocol/openid-connect/token \
  -d "grant_type=authorization_code" \
  -d "client_id=my-app" \
  -d "client_secret=<client-secret>" \
  -d "code=<authorization-code>" \
  -d "redirect_uri=http://localhost:3000/callback"
```

3. **User Info:**
```bash
curl http://localhost:8081/realms/local-dev/protocol/openid-connect/userinfo \
  -H "Authorization: Bearer <access-token>"
```

## Python Example (python-keycloak)

```python
from keycloak import KeycloakOpenID

# Configure client
keycloak_openid = KeycloakOpenID(
    server_url="http://localhost:8081",
    client_id="my-app",
    realm_name="local-dev",
    client_secret_key="<client-secret>"
)

# Get access token
token = keycloak_openid.token("username", "password")
access_token = token['access_token']

# Get user info
userinfo = keycloak_openid.userinfo(access_token)
print(userinfo)

# Introspect token
token_info = keycloak_openid.introspect(access_token)
print(token_info)
```

## Node.js Example (keycloak-js)

```javascript
const Keycloak = require('keycloak-js');

const keycloak = new Keycloak({
    url: 'http://localhost:8081',
    realm: 'local-dev',
    clientId: 'my-app'
});

// Initialize
keycloak.init({ onLoad: 'login-required' }).then(authenticated => {
    if (authenticated) {
        console.log('User authenticated');
        console.log('Token:', keycloak.token);
        console.log('User info:', keycloak.tokenParsed);
    }
});

// Logout
keycloak.logout();
```

## .NET Example (Keycloak.AuthServices)

```csharp
using Keycloak.AuthServices.Authentication;
using Keycloak.AuthServices.Authorization;

// appsettings.json
{
  "Keycloak": {
    "realm": "local-dev",
    "auth-server-url": "http://localhost:8081",
    "ssl-required": "none",
    "resource": "my-app",
    "verify-token-audience": true,
    "credentials": {
      "secret": "<client-secret>"
    }
  }
}

// Program.cs
builder.Services.AddKeycloakAuthentication(builder.Configuration);

// Protect endpoints
[Authorize]
public class SecureController : ControllerBase
{
    [HttpGet]
    public IActionResult GetSecureData()
    {
        var username = User.Identity?.Name;
        return Ok($"Hello, {username}!");
    }
}
```

## Java/Spring Boot Example

```java
// application.properties
spring.security.oauth2.client.registration.keycloak.client-id=my-app
spring.security.oauth2.client.registration.keycloak.client-secret=<client-secret>
spring.security.oauth2.client.registration.keycloak.authorization-grant-type=authorization_code
spring.security.oauth2.client.registration.keycloak.redirect-uri={baseUrl}/login/oauth2/code/keycloak

spring.security.oauth2.client.provider.keycloak.issuer-uri=http://localhost:8081/realms/local-dev

// SecurityConfig.java
@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(authorize -> authorize
                .requestMatchers("/public/**").permitAll()
                .anyRequest().authenticated()
            )
            .oauth2Login(withDefaults());
        return http.build();
    }
}
```

## Admin REST API

**Get all users:**
```bash
# Get admin token
TOKEN=$(curl -X POST http://localhost:8081/realms/master/protocol/openid-connect/token \
  -d "client_id=admin-cli" \
  -d "username=admin" \
  -d "password=YourPassword" \
  -d "grant_type=password" | jq -r '.access_token')

# Get users
curl http://localhost:8081/admin/realms/local-dev/users \
  -H "Authorization: Bearer $TOKEN"
```

## Customizing the Realm

To use your own realm configuration:

1. Export realm from Keycloak Admin Console
2. Replace `local-dev-realm.json` with your configuration
3. Rebuild the image: `./build.sh`

## Persistent Volumes

This service uses one persistent volume:

- **keycloak-data**: User data, realms, clients (`/opt/keycloak/data`)

Data persists across container restarts.

## Use in Compositions

To use this service in a higher-level composition:

```yaml
services:
  keycloak:
    extends:
      file: ../../services/auth/keycloak/docker-compose.yml
      service: keycloak
```

## Health Check

```bash
curl http://localhost:8081/health
```

## Security Notes

**Production deployment:**
1. Change default admin credentials
2. Use strong passwords
3. Enable HTTPS (requires reverse proxy or Keycloak HTTPS config)
4. Configure proper realm settings
5. Review security policies
6. Regular backups
7. Keep Keycloak updated

**Development mode:**
- This configuration uses `start-dev` mode
- NOT suitable for production
- For production, use `start` with proper configuration

## Documentation

- Official Website: https://www.keycloak.org/
- Documentation: https://www.keycloak.org/documentation
- Admin Guide: https://www.keycloak.org/docs/latest/server_admin/
- Securing Apps: https://www.keycloak.org/docs/latest/securing_apps/

## Source Tracking

**Migrated from:** AnotherOneBytesTheDust/ContainerStore
**Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
**Source date:** 2025-09-16
**Source file:** `docker-compose.keycloak.yml`, `DockerFile.keycloak`

---

**Service Type:** Authentication (IAM)
**Category:** Identity & Access Management
**Deployment:** Standalone container with persistence (development mode)
