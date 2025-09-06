# Lightweight Python
FROM python:3.12-slim

# Avoid bytecode & ensure instant flush
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
# Cloud Run listens on $PORT; default to 8080 for local runs
ENV PORT=8080
CMD exec gunicorn --bind 0.0.0.0:${PORT} --workers 2 --threads 4 app:app
