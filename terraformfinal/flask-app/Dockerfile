# ---------- build stage ----------
FROM python:3.11-slim AS builder

WORKDIR /app

# Создаем виртуальное окружение
RUN python -m venv /opt/venv

# Активируем venv для установки пакетов
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ---------- runtime stage ----------
FROM python:3.11-slim

WORKDIR /app

# Копируем виртуальное окружение
COPY --from=builder /opt/venv /opt/venv

# Копируем приложение
COPY app.py .

# Активируем venv через PATH (это заменяет source activate)
ENV PATH="/opt/venv/bin:$PATH"
ENV VIRTUAL_ENV="/opt/venv"

EXPOSE 5000
CMD ["python", "app.py"]