# Java Development Container

Lightweight Java development environment with JDK.

## Overview

Minimal Java container for Java development. Based on official Eclipse Temurin (AdoptOpenJDK successor) images with persistent workspace and Maven cache. Perfect for Java projects without multi-language overhead.

## Features

- **Eclipse Temurin JDK**: Latest Java 21 by default
- **javac compiler**: Ready to compile
- **Persistent workspace**: Projects preserved across restarts
- **Maven cache**: Faster dependency downloads
- **Interactive shell**: Direct bash access
- **Lightweight**: Only JDK

## Quick Start

```bash
cd services/dev-tools/dev-java
./start.sh

# Inside container:
java --version
javac --version

# Create and run simple program
cat > Hello.java << 'EOJAVA'
public class Hello {
    public static void main(String[] args) {
        System.out.println("Hello from Java!");
    }
}
EOJAVA

javac Hello.java
java Hello
```

## Configuration

| Variable | Default | Description |
|:---------|:--------|:------------|
| JAVA_VERSION | 21-jdk | Java JDK version |

## Usage Examples

### Compile and Run

```bash
cat > HelloWorld.java << 'EOJAVA'
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello World!");
    }
}
EOJAVA

javac HelloWorld.java
java HelloWorld
```

### With Maven (install first)

```bash
# Install Maven
apt-get update && apt-get install -y maven

# Create Maven project
mvn archetype:generate -DgroupId=com.example -DartifactId=myapp -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false

cd myapp
mvn package
java -cp target/myapp-1.0-SNAPSHOT.jar com.example.App
```

### JAR Creation

```bash
javac MyApp.java
jar cvfe myapp.jar MyApp MyApp.class
java -jar myapp.jar
```

## Persistent Volumes

| Volume Name | Mount Path | Purpose | Typical Size |
|:------------|:-----------|:--------|:-------------|
| java-workspace | /workspace | Project files | 1-10GB |
| maven-cache | /root/.m2 | Maven repository cache | 1-5GB |

## Documentation

- **Java**: https://docs.oracle.com/en/java/
- **Maven**: https://maven.apache.org/guides/

---

**Service Type:** Development Tool (Java)
**Category:** dev-tools
**Deployment:** Uses official Eclipse Temurin image
