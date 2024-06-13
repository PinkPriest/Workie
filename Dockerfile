FROM python:3.11

WORKDIR /usr/src/app


ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1


RUN apt-get update \
    && apt-get install netcat-traditional -y
RUN apt-get upgrade -y && apt-get install postgresql gcc python3-dev musl-dev -y
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | POETRY_HOME=/apt/poetry
RUN cd /usr/local/bin
RUN ln -s /opt/poetry/bin/poetry
RUN POETRY_VIRTUALENVS_CREATE=false

COPY ./pyproject.toml ./poetry.lock* /usr/src/app/

RUN pip install poetry

RUN poetry install

COPY ./entrypoint.sh .

COPY . .


ENTRYPOINT ["/usr/src/app/entrypoint.sh"]