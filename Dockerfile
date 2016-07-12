FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssl && apt-get clean

