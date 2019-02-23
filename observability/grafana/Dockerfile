FROM grafana/grafana:5.3.4

COPY datasources /etc/grafana/provisioning/datasources/
COPY dashboards.yml /etc/grafana/provisioning/dashboards/
COPY dashboards /etc/grafana/dashboards/

ENV GF_SECURITY_ADMIN_PASSWORD=password_admin \
    GF_SECURITY_ADMIN_USER=admin_admin \
    GF_PATHS_PROVISIONING=/etc/grafana/provisioning/

# docker build -t ozyab/loadbalancer-grafana .
