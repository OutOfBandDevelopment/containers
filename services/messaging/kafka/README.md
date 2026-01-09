# Apache Kafka

Distributed event streaming platform for high-throughput, fault-tolerant message processing and real-time data pipelines.

## Overview

Apache Kafka is a distributed streaming platform designed for building real-time data pipelines and streaming applications. It's horizontally scalable, fault-tolerant, and extremely fast.

## Features

- High-throughput messaging (millions of messages/sec)
- Distributed, partitioned, replicated commit log
- Fault-tolerant and scalable
- Persistent message storage
- Real-time stream processing
- KRaft mode (no Zookeeper required)
- Multiple consumer groups
- Exactly-once semantics
- Connect API for data integration

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
| KAFKA_VERSION | latest | Kafka image version |
| KAFKA_PLAINTEXT_PORT | 9092 | Internal protocol port |
| KAFKA_EXTERNAL_PORT | 9094 | External protocol port |
| KAFKA_BROKER_ID | 1 | Unique broker identifier |
| KAFKA_NODE_ID | 1 | KRaft node identifier |
| KAFKA_AUTO_CREATE_TOPICS | true | Auto-create topics on first use |
| KAFKA_NUM_PARTITIONS | 2 | Default partitions per topic |
| KAFKA_DEBUG | no | Enable debug logging |

## Accessing the Service

After starting:

- **Internal clients**: localhost:9092
- **External clients**: localhost:9094

## KRaft Mode

This configuration uses KRaft (Kafka Raft) mode, which eliminates the dependency on Zookeeper. KRaft provides:
- Simplified architecture
- Faster controller failover
- Better scalability
- Easier operations

## Creating Topics

**Using kafka-topics.sh:**
```bash
docker exec kafka kafka-topics.sh \
  --create \
  --bootstrap-server localhost:9092 \
  --topic my-topic \
  --partitions 3 \
  --replication-factor 1
```

**List topics:**
```bash
docker exec kafka kafka-topics.sh \
  --list \
  --bootstrap-server localhost:9092
```

**Describe topic:**
```bash
docker exec kafka kafka-topics.sh \
  --describe \
  --bootstrap-server localhost:9092 \
  --topic my-topic
```

## Producing Messages

**Using console producer:**
```bash
docker exec -it kafka kafka-console-producer.sh \
  --bootstrap-server localhost:9092 \
  --topic my-topic
```

Type messages and press Enter.

## Consuming Messages

**Using console consumer:**
```bash
docker exec -it kafka kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic my-topic \
  --from-beginning
```

## Python Example (kafka-python)

```python
from kafka import KafkaProducer, KafkaConsumer
import json

# Producer
producer = KafkaProducer(
    bootstrap_servers=['localhost:9092'],
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
)

# Send message
producer.send('my-topic', {'key': 'value'})
producer.flush()

print("Message sent!")

# Consumer
consumer = KafkaConsumer(
    'my-topic',
    bootstrap_servers=['localhost:9092'],
    auto_offset_reset='earliest',
    value_deserializer=lambda m: json.loads(m.decode('utf-8'))
)

print("Waiting for messages...")
for message in consumer:
    print(f"Received: {message.value}")
```

## Node.js Example (kafkajs)

```javascript
const { Kafka } = require('kafkajs');

const kafka = new Kafka({
    clientId: 'my-app',
    brokers: ['localhost:9092']
});

// Producer
async function produce() {
    const producer = kafka.producer();
    await producer.connect();

    await producer.send({
        topic: 'my-topic',
        messages: [
            { value: 'Hello Kafka!' }
        ]
    });

    console.log('Message sent!');
    await producer.disconnect();
}

// Consumer
async function consume() {
    const consumer = kafka.consumer({ groupId: 'my-group' });
    await consumer.connect();
    await consumer.subscribe({ topic: 'my-topic', fromBeginning: true });

    await consumer.run({
        eachMessage: async ({ topic, partition, message }) => {
            console.log({
                value: message.value.toString()
            });
        }
    });
}

produce().catch(console.error);
consume().catch(console.error);
```

## .NET Example (Confluent.Kafka)

```csharp
using Confluent.Kafka;
using System;
using System.Threading;

// Producer
var config = new ProducerConfig { BootstrapServers = "localhost:9092" };

using (var producer = new ProducerBuilder<Null, string>(config).Build())
{
    var result = await producer.ProduceAsync("my-topic",
        new Message<Null, string> { Value = "Hello Kafka!" });

    Console.WriteLine($"Message sent to {result.TopicPartitionOffset}");
}

// Consumer
var consumerConfig = new ConsumerConfig
{
    GroupId = "my-group",
    BootstrapServers = "localhost:9092",
    AutoOffsetReset = AutoOffsetReset.Earliest
};

using (var consumer = new ConsumerBuilder<Ignore, string>(consumerConfig).Build())
{
    consumer.Subscribe("my-topic");

    CancellationTokenSource cts = new CancellationTokenSource();

    try
    {
        while (true)
        {
            var cr = consumer.Consume(cts.Token);
            Console.WriteLine($"Received: {cr.Message.Value}");
        }
    }
    catch (OperationCanceledException)
    {
        consumer.Close();
    }
}
```

## Java Example (Spring Kafka)

```java
@Configuration
public class KafkaConfig {
    @Bean
    public ProducerFactory<String, String> producerFactory() {
        Map<String, Object> config = new HashMap<>();
        config.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");
        config.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
        config.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
        return new DefaultKafkaProducerFactory<>(config);
    }

    @Bean
    public KafkaTemplate<String, String> kafkaTemplate() {
        return new KafkaTemplate<>(producerFactory());
    }
}

// Send message
@Autowired
private KafkaTemplate<String, String> kafkaTemplate;

public void sendMessage(String message) {
    kafkaTemplate.send("my-topic", message);
}

// Receive message
@KafkaListener(topics = "my-topic", groupId = "my-group")
public void listen(String message) {
    System.out.println("Received: " + message);
}
```

## Common Management Tasks

### Consumer Groups

**List consumer groups:**
```bash
docker exec kafka kafka-consumer-groups.sh \
  --bootstrap-server localhost:9092 \
  --list
```

**Describe consumer group:**
```bash
docker exec kafka kafka-consumer-groups.sh \
  --bootstrap-server localhost:9092 \
  --describe \
  --group my-group
```

### Reset Offsets

```bash
docker exec kafka kafka-consumer-groups.sh \
  --bootstrap-server localhost:9092 \
  --group my-group \
  --topic my-topic \
  --reset-offsets \
  --to-earliest \
  --execute
```

## Performance Tuning

### Producer Settings
- `acks=all`: Wait for all replicas (durability)
- `compression.type=snappy`: Enable compression
- `batch.size`: Increase for better throughput
- `linger.ms`: Wait time before sending batch

### Consumer Settings
- `fetch.min.bytes`: Minimum data per request
- `max.poll.records`: Records per poll
- `enable.auto.commit`: Automatic offset commits

## Persistent Volumes

This service uses one persistent volume:

- **kafka-data**: Logs, metadata, and message data (`/bitnami`)

Data persists across container restarts.

## Use in Compositions

To use this service in a higher-level composition:

```yaml
services:
  kafka:
    extends:
      file: ../../services/messaging/kafka/docker-compose.yml
      service: kafka
```

## Health Check

```bash
docker exec kafka kafka-broker-api-versions.sh \
  --bootstrap-server localhost:9092
```

## Documentation

- Official Website: https://kafka.apache.org/
- Documentation: https://kafka.apache.org/documentation/
- Quickstart: https://kafka.apache.org/quickstart
- Bitnami Kafka: https://github.com/bitnami/containers/tree/main/bitnami/kafka

## Source Tracking

**Migrated from:** AnotherOneBytesTheDust/ContainerStore
**Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
**Source date:** 2025-09-16
**Source file:** `docker-compose.kafka.yml`

---

**Service Type:** Messaging (Event Streaming)
**Category:** Message Broker / Stream Processing
**Deployment:** Standalone container with persistence (KRaft mode)
