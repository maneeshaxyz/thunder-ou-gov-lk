FROM ghcr.io/asgardeo/thunder:latest

USER root

# Create a new user with UID that passes security checks
RUN groupadd -r thunder -g 10001 && \
	useradd -r -u 10001 -g thunder -s /bin/bash thunder

# Set ownership and permissions
RUN chown -R 10001:10001 /opt/thunder && \
	chmod +x /opt/thunder/start.sh /opt/thunder/setup.sh /opt/thunder/scripts/init_script.sh && \
	(find /opt/thunder/bootstrap -name "*.sh" -type f -exec chmod +x {} \; 2>/dev/null || true)

# Switch to thunder user for security
USER 10001

# Expose the server port
EXPOSE 8090

# Use the startup script
CMD ["/opt/thunder/start.sh"]
