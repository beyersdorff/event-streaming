# Event Processing: Streaming with Kafka & KSQL

Big Data and the necessity to transfer data through different applications, reinforce the importance of initiatives to process data in real-time. There are already several event stream frameworks, dealing with the data flow to perform stream analysis. In this project, a small event processing system was developed using Apache Kafka and KSQL to describe the usefulness of some tools.

See paper: [a link](https://github.com/beyersdorff/event-streaming/blob/main/Event_Processing_%20Streaming_with_Kafka_KSQL.pdf)

## Requirements

To install requirements:

```setup env
virtualenv env
source env/bin/activate
pip install confluent-kafka
```

```run docker containers
docker compose up -d
```

``` create topic
docker compose exec broker \
  kafka-topics --create \
    --topic meetup_events \
    --bootstrap-server localhost:9092 \
    --replication-factor 1 \
    --partitions 1
```

``` produce events
chmod u+x producer.py
./producer.py getting_started.ini
```

``` consume events
chmod u+x consumer.py
./consumer.py getting_started.ini
```
