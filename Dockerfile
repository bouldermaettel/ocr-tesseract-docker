# built on Ubuntu 20.04 LTS and r-base
FROM openanalytics/r-base

MAINTAINER Rick Torzynski "ricktorzynski@gmail.com"
RUN apt-get update -y && apt-get install -y apt-utils
RUN apt-get install -y python3-pip python-dev build-essential
RUN apt-get update && apt-get install -y libsm6 libxext6
RUN apt-get update && apt-get -y install tesseract-ocr libopencv-dev python3-opencv


RUN mkdir /root/app
COPY app /root/app
WORKDIR root/app
ENV FLASK_APP=app.py

EXPOSE 5000

RUN pip3 install pillow
RUN pip3 install tesseract
RUN pip3 install opencv-contrib-python
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
#ENTRYPOINT ['python']
#CMD ["app.py"]
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]