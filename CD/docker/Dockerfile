FROM python

ADD  app.tar /
COPY create_table.yaml /app
COPY entrypoint.sh /entrypoint.sh
COPY ssh/id_ed25519 ssh/id_ed25519.pub ssh/config ssh/authorized_keys /root/.ssh/

RUN apt-get update && apt-get upgrade -y && \
 apt install -y openssh-server && mkdir -p /run/sshd && \
 chmod +x /entrypoint.sh && \
 chmod 500 /root/.ssh && \
 chmod 400 /root/.ssh/id_ed25519 /root/.ssh/id_ed25519.pub /root/.ssh/config /root/.ssh/authorized_keys && \
 useradd -M -c user -g nogroup -u 9000 -d /app -s /usr/sbin/nologin user && \
 cd /app && \
 python -m venv venv_ansible && \
 . ./venv_ansible/bin/activate && \
 pip install ansible PyMySQL && \
 deactivate && \
 python -m venv venv_app && \
 . ./venv_app/bin/activate && \
 pip install Flask==1.1.4 Flask_Migrate==2.6.0 MarkupSafe==2.0.1 Flask-Script Flask-SQLAlchemy SQLAlchemy PyMySQL && \
 deactivate

#USER user
ENTRYPOINT ["/entrypoint.sh"]
