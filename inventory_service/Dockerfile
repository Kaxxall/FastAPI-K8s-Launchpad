FROM python:3.10-slim as base
WORKDIR /app

FROM base as builder
RUN pip install --no-cache-dir poetry
COPY ./inventory_service/pyproject.toml ./inventory_service/poetry.lock ./
RUN poetry config virtualenvs.create false && poetry install --no-root --only main


FROM base as final
COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
COPY ./inventory_service/app /app/

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]