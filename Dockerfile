### build ###
FROM openjdk:11-jdk as BUILDER

ARG APP_PATH=/usr/app

WORKDIR ${APP_PATH}

COPY ./ ./
RUN ./gradlew build --no-daemon

### package ###
FROM openjdk:11-jre

ARG APP_PATH=/usr/app

WORKDIR ${APP_PATH}

COPY --from=BUILDER ${APP_PATH}/build/libs/xraydemo.jar ./app.jar

EXPOSE 8080

CMD ["java","-jar","app.jar"]
