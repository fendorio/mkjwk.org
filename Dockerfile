FROM maven:3-openjdk-17 AS builder

RUN mkdir /build
WORKDIR /build
ADD . /build
RUN mvn -Dmaven.test.skip=true -Dmaven.javadoc.skip=true package

FROM openjdk:17-jdk

COPY --from=builder /build/target/ROOT.war /app.jar
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]
