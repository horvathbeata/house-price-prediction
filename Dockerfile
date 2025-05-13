FROM python:3.11.11-bookworm
# létrehozza a workpace-t
RUN mkdir /workspace
WORKDIR /workspace
#rendszer frissítés
RUN apt update && apt upgrade -y
RUN apt install -y build-essential vim
#gyökértelen mód
RUN useradd --create-home dockerhead
USER dockerhead

#python dependenciák
##mindent átmásolunk (az összes fájlt, ami a könyvtárban van)
COPY . . 
RUN pip install --upgrade pip

RUN pip3 install -r requirements.txt

RUN echo "#!/bin/bash && jupyter lab --ip 0.0.0.0 --port 8888 --allow root --no-browser" > /workspace/run.sh && chmod +x /workspace/run.sh
CMD ["/workspace/run.sh"]
