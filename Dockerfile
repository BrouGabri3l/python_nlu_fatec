FROM python:3.9
WORKDIR /app 
COPY . . 
RUN pip install -r requisitos.txt
CMD ["python3" , "levenshtein_teste.py"]