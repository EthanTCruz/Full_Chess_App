# Use an official Python runtime as a parent image
FROM python:3.11.0

# Set the working directory in the container
WORKDIR /usr/src/app

RUN mkdir  /usr/src/app/Chess_Model

# Copy the current directory contents into the container at /usr/src/app
COPY ./Chess_Model /usr/src/app/Chess_Model


# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r /usr/src/app/Chess_Model/requirements.txt

# Define environment variable
ENV trainModel True
ENV selfTrain False

# Run dash_app.py when the container launches
CMD ["python","./Chess_Model/src/model/main.py"]
