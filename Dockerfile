### build ###
FROM openjdk:11-jdk as BUILDER

ARG APP_PATH=/usr/app

WORKDIR ${APP_PATH}

COPY gradle ./gradle
COPY gradlew ./
COPY settings.gradle ./
COPY build.gradle ./
RUN ./gradlew build -x bootJar --no-daemon

COPY src ./src
RUN ./gradlew build --no-daemon
RUN java -Djarmode=layertools -jar ${APP_PATH}/build/libs/xraydemo.jar extract --destination ${APP_PATH}/build/layers

### package ###
FROM openjdk:11-jre

ARG APP_PATH=/usr/app

WORKDIR ${APP_PATH}

COPY --from=BUILDER ${APP_PATH}/build/layers/dependencies/ ./
COPY --from=BUILDER ${APP_PATH}/build/layers/spring-boot-loader/ ./
COPY --from=BUILDER ${APP_PATH}/build/layers/snapshot-dependencies/ ./
COPY --from=BUILDER ${APP_PATH}/build/layers/application/ ./

EXPOSE 8080

CMD ["java","org.springframework.boot.loader.JarLauncher"]
