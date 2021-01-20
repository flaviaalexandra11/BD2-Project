# key->user_id, value->username
logins = {}


def login_user(user_id, username):
    global logins
    if user_id in logins:
        return False
    logins[user_id] = username
    return True


def logout_user(user_id):
    if user_id in logins:
        del logins[user_id]
    return True


def is_logged_in(user_id):
    global logins
    return user_id in logins
