FROM python:3.9.6
RUN pip3 install -r /app/requirements.txt
COPY . /air_qu
WORKDIR /air_qu
RUN pip3 install -r /air_qu/requirements.txt
