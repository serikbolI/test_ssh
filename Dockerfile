FROM quay.io/astronomer/astro-runtime:6.0.2
USER root
RUN apt-get update && apt-get install -y git
RUN mkdir /root/.ssh/
ADD .ssh/id_rsa /root/.ssh/id_rsa
ADD .ssh/known_hosts /root/.ssh/known_hosts
RUN chmod 600 /root/.ssh/id_rsa
RUN chown -R root:root /root/.ssh
RUN ssh-keygen -R github.com
RUN virtualenv /usr/local/airflow/dq_env && . /usr/local/airflow/dq_env/bin/activate && pip install git+ssh://git@github.com/Palta-Data-Platform/paltabrain_dq_services.git && deactivate
ENV PIP_USER=true


