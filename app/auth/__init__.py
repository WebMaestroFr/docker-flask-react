from flask import Blueprint
from flask_jwt_extended import JWTManager
from flask_restful import Api

from . import models, resources


blueprint = Blueprint('auth', __name__)
api = Api(blueprint)
jwt = JWTManager()


def init_blueprint(app, **kwargs):

    models.db.init_app(app)
    jwt.init_app(app)

    app.register_blueprint(blueprint, **kwargs)

    @app.before_first_request
    def create_tables():
        models.db.create_all()


api.add_resource(resources.UserRegistration, '/registration')
api.add_resource(resources.UserLogin, '/login')
api.add_resource(resources.UserLogoutAccess, '/logout/access')
api.add_resource(resources.UserLogoutRefresh, '/logout/refresh')
api.add_resource(resources.TokenRefresh, '/token/refresh')
api.add_resource(resources.AllUsers, '/users')
api.add_resource(resources.SecretResource, '/secret')


@jwt.token_in_blacklist_loader
def check_if_token_in_blacklist(decrypted_token):
    jti = decrypted_token['jti']
    return models.RevokedTokenModel.is_jti_blacklisted(jti)
