import os
from flask import Flask

from .auth import init_blueprint as init_auth


class Config(object):
    APP_NAME = 'DockerFlask'
    SECRET_KEY = 'some-secret-string'
    SQLALCHEMY_DATABASE_URI = 'sqlite:///data.sqlite'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    JWT_SECRET_KEY = 'jwt-secret-string'
    JWT_BLACKLIST_ENABLED = True
    JWT_BLACKLIST_TOKEN_CHECKS = ['access', 'refresh']


def create_app(config=None):

    app = Flask(
        __name__,
        static_url_path='',
        static_folder='../build',
        instance_relative_config=True
    )
    app.config.from_object(Config)

    if config is not None:
        app.config.from_mapping(config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    init_auth(app, url_prefix='/auth')

    @app.route('/')
    def index():
        return app.send_static_file('index.html')

    return app
