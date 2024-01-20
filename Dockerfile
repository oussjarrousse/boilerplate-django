# Dockerfile

FROM python:3.11

# Allows docker to cache installed dependencies between builds

# for easy debugging
# RUN apt-get install -y vim

# RUN apt-get update -qy 
# Download required apps
# RUN apt-get install -y sqlite3

# Download required apps
RUN pip install --upgrade pip setuptools wheel

RUN useradd -ms /bin/bash user
ARG HOMEDIR=/home/user
WORKDIR ${HOMEDIR}

COPY --chown=user:user requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Mounts the application code to the image
COPY --chown=user:user ./src ./src/

USER user

EXPOSE 8000

ENTRYPOINT ["python", "src/manage.py"]
# TODO: replace with a production ready server
CMD ["runserver", "0.0.0.0:8000"]
