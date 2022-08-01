#!/usr/bin/env python

import sys
import json
from argparse import ArgumentParser, FileType
from configparser import ConfigParser
from confluent_kafka import Producer

if __name__ == '__main__':

    # Open and loads file

    with open("events.json", "r") as file:
        events = [json.loads(line) for line in open("events.json", "r")]

    # Parse the command line.
    parser = ArgumentParser()
    parser.add_argument('config_file', type=FileType('r'))
    args = parser.parse_args()

    # Parse the configuration.
    # See https://github.com/edenhill/librdkafka/blob/master/CONFIGURATION.md
    config_parser = ConfigParser()
    config_parser.read_file(args.config_file)
    config = dict(config_parser['default'])

    # Create Producer instance
    producer = Producer(config)

    # Optional per-message delivery callback (triggered by poll() or flush())
    # when a message has been successfully delivered or permanently
    # failed delivery (after retries).
    def delivery_callback(err, msg):
        if err:
            print('ERROR: Message failed delivery: {}'.format(err))
        else:
            print("Produced event to topic {topic}: key = {key:12}".format(
                topic=msg.topic(), key=msg.key().decode('utf-8')))

    # Produce to topic
    topic = "meetup_events"

    for event in events:
        producer.produce(topic, key=event['id'], value=json.dumps(event, indent=4, sort_keys=True), callback=delivery_callback)
        producer.poll(0.0)

    # Block until the messages are sent.
    # producer.poll(10000)
    producer.flush()