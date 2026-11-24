# Etapa de build: instalar dependencias y ejecutar las pruebas Python.
FROM python:3.11-slim AS builder

LABEL maintainer="devops-academia"
LABEL description="App calculadora - Curso DevOps; ejecución de pruebas"

WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

RUN useradd -m -u 1000 appuser \
    && chown -R appuser:appuser /app
USER appuser
RUN pytest tests/ -v

# Etapa runtime: Nginx sin privilegios con su página predeterminada.
FROM nginx:1.25-alpine

LABEL maintainer="devops-academia"
LABEL description="Nginx runtime para el chart devops-app"

COPY nginx.conf /etc/nginx/nginx.conf
RUN chown -R 101:101 /var/cache/nginx /var/run

EXPOSE 8080
USER 101
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
