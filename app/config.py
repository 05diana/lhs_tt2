import os
basedir = os.path.abspath(os.path.dirname(__file__))

class Config(object):
    DEBUG = False
    TESTING = False
    CSRF_ENABLED = True
    #Database URL
    SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://lahaus:password@db/lahaus'


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True
