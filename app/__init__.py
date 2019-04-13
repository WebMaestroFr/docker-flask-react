import os
from flask import Flask

from .auth import auth
from .auth.extensions import (db as auth_db, jwt as auth_jwt)


class Config(object):
    APP_NAME = 'DockerFlask'
    SQLALCHEMY_DATABASE_URI = 'sqlite:///data.sqlite'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SECRET_KEY = 'some-secret-string'
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

    auth_db.init_app(app)
    auth_jwt.init_app(app)

    app.register_blueprint(
        auth,
        url_prefix='/auth'
    )

    @app.before_first_request
    def create_tables():
        auth_db.create_all()

    @app.route('/')
    def index():
        return app.send_static_file('index.html')

    return app
