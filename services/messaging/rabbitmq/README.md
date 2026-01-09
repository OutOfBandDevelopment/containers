# RabbitMQ

Open-source message broker implementing AMQP (Advanced Message Queuing Protocol) for reliable message delivery between applications.

## Overview

RabbitMQ is a widely-used open-source message broker that supports multiple messaging protocols. It enables asynchronous communication between distributed systems through message queues.

## Features

- AMQP 0-9-1 protocol support
- Multiple messaging patterns (publish/subscribe, routing, topics, RPC)
- High availability and clustering
- Management UI
- Plugin system
- Multiple client libraries
- Message persistence
- Flexible routing
- Federation and shovel

## Quick Start

**Linux/macOS:**
```bash
# Copy environment template
cp .env.template .env

# Edit configuration (IMPORTANT: Change credentials)
nano .env

# Start service
./start.sh

# Stop service
./stop.sh
```

**Windows:**
```cmd
# Copy environment template
copy .env.template .env

# Edit configuration (IMPORTANT: Change credentials)
notepad .env

# Start service
start.bat

# Stop service
stop.bat
```

## Configuration

Edit `.env` file to customize:

| Variable | Default | Description |
|:---------|:--------|:------------|
| RABBITMQ_VERSION | management | Image tag (includes management UI) |
| RABBITMQ_USER | admin | Admin username (CHANGE!) |
| RABBITMQ_PASSWORD | YourStrong@Password | Admin password (CHANGE!) |
| RABBITMQ_AMQP_PORT | 5672 | AMQP protocol port |
| RABBITMQ_MANAGEMENT_PORT | 15672 | Management UI port |

## Accessing the Service

After starting:

- **AMQP Protocol**: amqp://localhost:5672
- **Management UI**: http://localhost:15672
- **Username**: admin (or from .env)
- **Password**: (from .env)

## Management UI Features

- Queue monitoring
- Exchange management
- Binding visualization
- Message publishing and inspection
- User management
- Virtual host configuration
- Cluster management

## Basic Concepts

### Exchanges
- **Direct**: Route messages by exact routing key match
- **Topic**: Route messages by pattern matching
- **Fanout**: Broadcast to all bound queues
- **Headers**: Route based on message headers

### Queues
- Named buffers that store messages
- Can be durable (persist across restarts)
- Support priority and TTL

### Bindings
- Links between exchanges and queues
- Define routing rules

## Python Example (pika)

```python
import pika

# Connect
connection = pika.BlockingConnection(
    pika.ConnectionParameters('localhost')
)
channel = connection.channel()

# Declare queue
channel.queue_declare(queue='hello')

# Publish message
channel.basic_publish(
    exchange='',
    routing_key='hello',
    body='Hello World!'
)

print("Message sent!")
connection.close()

# Consume messages
def callback(ch, method, properties, body):
    print(f"Received {body}")

channel.basic_consume(
    queue='hello',
    on_message_callback=callback,
    auto_ack=True
)

print('Waiting for messages...')
channel.start_consuming()
```

## Node.js Example (amqplib)

```javascript
const amqp = require('amqplib');

async function send() {
    const connection = await amqp.connect('amqp://localhost');
    const channel = await connection.createChannel();

    await channel.assertQueue('hello');
    channel.sendToQueue('hello', Buffer.from('Hello World!'));

    console.log("Message sent!");

    await channel.close();
    await connection.close();
}

async function receive() {
    const connection = await amqp.connect('amqp://localhost');
    const channel = await connection.createChannel();

    await channel.assertQueue('hello');

    console.log('Waiting for messages...');
    channel.consume('hello', (msg) => {
        console.log(`Received: ${msg.content.toString()}`);
    }, { noAck: true });
}
```

## .NET Example (RabbitMQ.Client)

```csharp
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System.Text;

// Send
var factory = new ConnectionFactory() { HostName = "localhost" };
using (var connection = factory.CreateConnection())
using (var channel = connection.CreateModel())
{
    channel.QueueDeclare(queue: "hello",
                         durable: false,
                         exclusive: false,
                         autoDelete: false,
                         arguments: null);

    string message = "Hello World!";
    var body = Encoding.UTF8.GetBytes(message);

    channel.BasicPublish(exchange: "",
                        routingKey: "hello",
                        basicProperties: null,
                        body: body);
    Console.WriteLine("Message sent!");
}

// Receive
using (var connection = factory.CreateConnection())
using (var channel = connection.CreateModel())
{
    channel.QueueDeclare(queue: "hello",
                         durable: false,
                         exclusive: false,
                         autoDelete: false,
                         arguments: null);

    var consumer = new EventingBasicConsumer(channel);
    consumer.Received += (model, ea) =>
    {
        var body = ea.Body.ToArray();
        var message = Encoding.UTF8.GetString(body);
        Console.WriteLine($"Received: {message}");
    };

    channel.BasicConsume(queue: "hello",
                         autoAck: true,
                         consumer: consumer);

    Console.WriteLine("Waiting for messages...");
    Console.ReadLine();
}
```

## Connection String Format

```
amqp://username:password@hostname:port/vhost
```

Example:
```
amqp://admin:YourStrong@Password@localhost:5672/
```

## Common Management Tasks

### Create Queue (CLI)
```bash
docker exec rabbitmq rabbitmqctl add_queue my_queue
```

### List Queues
```bash
docker exec rabbitmq rabbitmqctl list_queues
```

### List Exchanges
```bash
docker exec rabbitmq rabbitmqctl list_exchanges
```

### Add User
```bash
docker exec rabbitmq rabbitmqctl add_user myuser mypassword
docker exec rabbitmq rabbitmqctl set_permissions -p / myuser ".*" ".*" ".*"
```

## Persistent Volumes

This service uses two persistent volumes:

- **rabbitmq-data**: Message data and metadata (`/var/lib/rabbitmq`)
- **rabbitmq-log**: Server logs (`/var/log/rabbitmq`)

Data persists across container restarts.

## Use in Compositions

To use this service in a higher-level composition:

```yaml
services:
  rabbitmq:
    extends:
      file: ../../services/messaging/rabbitmq/docker-compose.yml
      service: rabbitmq
```

## Health Check

```bash
docker exec rabbitmq rabbitmqctl status
```

Or via HTTP:
```bash
curl -u admin:YourStrong@Password http://localhost:15672/api/healthchecks/node
```

## Documentation

- Official Website: https://www.rabbitmq.com/
- Getting Started: https://www.rabbitmq.com/getstarted.html
- Management Plugin: https://www.rabbitmq.com/management.html
- Docker Hub: https://hub.docker.com/_/rabbitmq

## Source Tracking

**Migrated from:** AnotherOneBytesTheDust/ContainerStore
**Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
**Source date:** 2025-09-16
**Source file:** `docker-compose.rabbitmq.yml`

---

**Service Type:** Messaging (Message Broker)
**Category:** Message Queue
**Deployment:** Standalone container with persistence
