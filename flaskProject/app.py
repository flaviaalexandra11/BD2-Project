from flask import Flask, session, render_template, request, make_response, redirect, flash
from flaskext.mysql import MySQL

# instatiating flask class
app = Flask(__name__)
mysql = MySQL()

# configuring MySQL for the web application
app.config['MYSQL_DATABASE_USER'] = 'flavia'
app.config['MYSQL_DATABASE_PASSWORD'] = 'parola'
app.config['MYSQL_ROOT_PASSWORD'] = 'parola'
app.config['MYSQL_DATABASE_DB'] = 'gradebook'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'

# connecting to database
mysql.init_app(app)
conn = mysql.connect()

@app.route('/login', methods=['GET', 'POST'])
def login():
    payload = request.get_json()
    print(payload)

    username = payload["username"]
    password = payload["password"]

    c = conn.cursor()
    func = "SELECT login(%s, %s)"
    c.execute(func, (username, password))
    user_id = c.fetchone()[0]
    print(user_id)
    my_dict = {'result': user_id}
    return my_dict


@app.route('/stud_parents', methods=['GET', 'POST'])
def get_stud_parents():
    c = conn.cursor()
    # TODO: harcodare o lista cu chei
    # si pt fiecare creez un dictionar
    # voi returna o list de dictionare
    proc = "CALL get_students_with_parents"
    c.execute(proc)
    my_list = c.fetchall()
    my_dict = {'result': my_list}
    return my_dict


@app.route('/')
def index():
    return "Hello world"
