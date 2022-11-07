FROM python

RUN apt-get update && apt-get upgrade -y && \
 git clone https://github.com/05diana/technical_test_2.git && \
 mv technical_test_2/app .  && \
 mv technical_test_2/root/.ssh/ root  && \
 rm -fr technical_test_2 && \
 apt install -y openssh-server && mkdir -p /run/sshd && \
 chmod +x /app/entrypoint.sh && \
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
ENTRYPOINT ["/app/entrypoint.sh"]
