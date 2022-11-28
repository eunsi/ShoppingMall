FROM openjdk:18-jdk-alpine
ADD goods.tar /
WORKDIR ShoppingMall
RUN ./gradlew build && ./gradlew jar
COPY /ShoppingMall/build/libs/shoppingMall-0.0.1-SNAPSHOT.jar /goods.jar
CMD ["java", "-jar", "/goods.jar"]











