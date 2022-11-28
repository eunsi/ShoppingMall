FROM openjdk:18-jdk-alpine
ADD goods.tar /
WORKDIR ShoppingMall
RUN ./gradlew jar
COPY /build/libs/shoppingMall-0.0.1-SNAPSHOT.jar /shoppingMall-0.0.1-SNAPSHOT.jar
CMD ["java", "-jar", "/shoppingMall-0.0.1-SNAPSHOT.jar"]












