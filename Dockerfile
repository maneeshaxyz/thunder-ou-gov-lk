FROM ghcr.io/asgardeo/thunder:latest

USER root

# Create user only (group already exists in base image)
RUN adduser -u 10001 -G thunder -s /bin/sh -D thunder || echo "user already exists, skipping"

RUN chown -R 10001:10001 /opt/thunder && \
	chmod +x /opt/thunder/start.sh /opt/thunder/setup.sh /opt/thunder/scripts/init_script.sh && \
	(find /opt/thunder/bootstrap -name "*.sh" -type f -exec chmod +x {} \; 2>/dev/null || true)

USER thunder

EXPOSE 8090
CMD ["/opt/thunder/start.sh"]
