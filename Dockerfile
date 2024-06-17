FROM python:3.9
WORKDIR /app
RUN pip install dice
COPY main.py /app/
CMD ["python","main.py"]
