FROM python

ADD  app.tar /
COPY entrypoint.sh /entrypoint.sh

RUN apt-get update && apt-get upgrade -y && \
 chmod +x /entrypoint.sh && \
 useradd -M -c user -g nogroup -u 9000 -d /app -s /usr/sbin/nologin user && \
 cd /app && \
 python -m venv venv && \
 . ./venv/bin/activate && \
 pip install Flask==1.1.4 Flask_Migrate==2.6.0 MarkupSafe==2.0.1 Flask-Script Flask-SQLAlchemy SQLAlchemy PyMySQL && \
 deactivate

#USER user
ENTRYPOINT ["/entrypoint.sh"]
