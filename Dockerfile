# Use the latest OpenJDK image
FROM openjdk:11-jdk-slim

# Set the working directory
WORKDIR /opt/kops

# Download the KoPS zip file
ADD https://fachportal.gematik.de/fileadmin/Fachportal/Tool-Kit/KoPs/KoPS31_ohne_OpenJDK_V3.1.15_20220621.zip /tmp/kops.zip

# Install unzip utility and unzip the downloaded file
RUN apt-get update && apt-get install -y unzip && \
    unzip /tmp/kops.zip -d /opt/kops && \
    rm /tmp/kops.zip

# Make the start.sh script executable
RUN chmod u+x /opt/kops/start.sh

# Expose the port (default to 9090 if not set)
ENV PORT 9090
EXPOSE $PORT

# Run the start.sh script with the specified port
CMD ["/bin/bash", "-c", "/opt/kops/start.sh $PORT && exec /bin/bash"]

