
FROM --platform=$BUILDPLATFORM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn -B -q dependency:go-offline
COPY src ./src
# Tests already ran in the CI "test" job
RUN mvn -B -q package -DskipTests

# ---------- Stage 2: small runtime image (built for the server's CPU: ARM Graviton) ----------
FROM eclipse-temurin:21-jre
RUN apt-get update \
 && apt-get install -y --no-install-recommends curl \
 && rm -rf /var/lib/apt/lists/* \
 && groupadd --system app && useradd --system --gid app --home-dir /app app
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
RUN mkdir -p /app/uploads /app/exports /app/logs && chown -R app:app /app
USER app

# UTC avoids the PostgreSQL "Asia/Calcutta" error (defects D-02 / D-08)
ENV JAVA_OPTS="-XX:MaxRAMPercentage=70 -Duser.timezone=UTC"
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s --start-period=120s --retries=3 \
  CMD curl -fs http://localhost:8080/actuator/health || exit 1
ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -jar app.jar"]