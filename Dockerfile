
## build and run commands
#docker build -t my_jupyter .
#docker run -it my_jupyter

#use python version 3.8.13, to conserve compatability for future use 
FROM python:3.8.13-bullseye AS willynilly

#if you do not specify user, runs everything as root. If someone gets access to root then has access to whole system 
## some parts of install may still need to be run as root in order to have access to install 
USER root

#install jupyter, can also use from terminal
RUN pip3 install jupyter
## source: https://towardsdatascience.com/how-to-run-jupyter-notebook-on-docker-7c9748ed209f

RUN wget https://raw.githubusercontent.com/bmarin2scu/CloudComputing/main/week_2/notebook2.ipynb
#source: https://learnpython.com/blog/python-requirements-file/
RUN wget https://raw.githubusercontent.com/bmarin2scu/CloudComputing/main/week_2/requirements2.txt

#2 ways to create user
## RUN useradd -ms /bin/bash our_user
#ENV USER=name
ENV JUPYTER_USER our_user

RUN useradd -ms /bin ${JUPYTER_USER} 
RUN mkdir -p home/our_user/lab2
RUN cp notebook2.ipynb home/our_user/lab2
RUN cp requirements2.txt home/our_user/lab2
RUN pip install -r requirements2.txt
WORKDIR /home/our_user/lab2


#expose port 
EXPOSE 7788

#run jupyter notebook on specific port, allow-root should not be used in actual running system 
USER ${JUPYTER_USER}

CMD jupyter notebook --ip=0.0.0.0 --port 7788

#https://learnpython.com/blog/python-requirements-file/

#source: https://linuxhint.com/creating-a-user-with-different-home-directory-in-linux/
