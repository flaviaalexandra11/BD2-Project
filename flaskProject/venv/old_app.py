from flask import Flask, session, render_template, request, make_response, redirect, flash
from flaskext.mysql import MySQL
from forms import LoginForm
import os
from flask_bootstrap import Bootstrap

# instatiating flask class
app = Flask(__name__)
mysql = MySQL()
Bootstrap(app)

# configuring MySQL for the web application
app.config['MYSQL_DATABASE_USER'] = 'flavia'
app.config['MYSQL_DATABASE_PASSWORD'] = 'parola'
app.config['MYSQL_ROOT_PASSWORD'] = 'parola'
app.config['MYSQL_DATABASE_DB'] = 'gradebook'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'

# not sure what it does, needed for forms
SECRET_KEY = os.urandom(32)
app.config['SECRET_KEY'] = SECRET_KEY

# connecting to database
mysql.init_app(app)
conn = mysql.connect()


@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    cursor = conn.cursor()
    if form.validate_on_submit():
        flash('Login requested for user {}, remember_me={}'.format(
            form.username.data, form.remember_me.data))

        print("Username: {}".format(form.username.data))
        print("Password: {}".format(form.password.data))

        func = 'SELECT login(%s, %s)'
        user_id = cursor.execute(func, (form.username.data, form.password.data));
        print("Found user_id: {}".format(user_id))
        return redirect('/index')
    return render_template('login.html', title='Sign In', form=form)

@app.route('/')
def index():
    # create a cursor
    cursor = conn.cursor()
    # execute select statement to fetch data to be displayed in combo/dropdown
    # cursor.execute('SELECT first_name, last_name FROM teacher')
    cursor.execute('CALL get_all_teachers')
    # fetch all rows ans store as a set of tuples
    joblist = cursor.fetchall()
    print(joblist)
    # render template and send the set of tuples to the HTML file for displaying
    return render_template("teachers.html", joblist=joblist)