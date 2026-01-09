FROM quay.io/keycloak/keycloak:latest

ARG KEYCLOAK_IMPORT_FILE=local-dev-realm.json

# Copy the import file to the appropriate directory
COPY ${KEYCLOAK_IMPORT_FILE} /opt/keycloak/data/import/

# Expose the necessary port
EXPOSE 8080

# Use ENTRYPOINT and CMD to ensure the environment variables are passed correctly
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev"]
CMD ["--import-realm"]
