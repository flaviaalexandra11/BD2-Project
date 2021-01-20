from flask import Flask, request
from flaskext.mysql import MySQL
from flask_cors import CORS

from utils.sql_db_headers import *
from utils.login_logic import login_user, logout_user, is_logged_in

# instatiating flask class
app = Flask(__name__)
mysql = MySQL()
CORS(app)

# configuring MySQL for the web application
app.config['MYSQL_DATABASE_USER'] = 'flavia'
app.config['MYSQL_DATABASE_PASSWORD'] = 'parola'
app.config['MYSQL_ROOT_PASSWORD'] = 'parola'
app.config['MYSQL_DATABASE_DB'] = 'gradebook'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'

# connecting to database
mysql.init_app(app)
conn = mysql.connect()


def exec_mysql(func, params=None):
    c = conn.cursor()
    c.execute(func, params)
    # conn.commit()
    result = list(c.fetchall())
    c.close()
    return result


def create_dict_from_lists(keys, values):
    return dict(zip(keys, values))


@app.route('/login', methods=['POST'])
def login():
    payload = request.get_json()
    print(payload)

    username = payload['username']
    password = payload['password']

    a = exec_mysql('SELECT login(%s, %s)', (username, password))[0]
    user_id = a[0]
    my_dict = {'result': user_id}
    result = login_user(user_id, username)
    # if not result:
    #     return {'status':'already logged in user'}, 403
    return my_dict


@app.route('/logout/<int:user_id>', methods=['GET'])
def logout(user_id):
    result = logout_user(user_id)
    return {'status': 'OK'}, 200


@app.route('/class/<int:teacher_id>', methods=['GET'])
def get_class_by_teacher_id(teacher_id):
    print(teacher_id)
    if not is_logged_in(teacher_id):
        return {'status': 'not logged in'}, 403
    classes = {'classes': []}
    db_classes = exec_mysql('CALL get_classes_by_teacher(%s)', teacher_id)
    print(db_classes)
    for c in db_classes:
        db_class = create_dict_from_lists(get_classes_by_teacher_header, c)
        # print(db_class)
        spec_name = exec_mysql('SELECT get_class_spec_id(%s)', db_class['class_id'])[0][0]
        # print(spec_name)
        teacher = exec_mysql('CALL get_teacher_profile(%s)',  db_class['class_master_id'])[0]
        # print(teacher)
        db_class['specialization_name'] = spec_name
        db_class['master'] = create_dict_from_lists(get_teacher_profile_header, teacher)
        classes['classes'].append(db_class)

    return classes, 200


@app.route('/students/<int:teacher_id>&<int:class_id>')
def get_students_of_class(teacher_id, class_id):
    print(teacher_id)
    print(class_id)
    if not is_logged_in(teacher_id):
        return {'status': 'not logged in'}, 403

    students = exec_mysql('CALL get_stud_by_class_id(%s)',  class_id)
    # print(students)
    students = {'students': [create_dict_from_lists(get_stud_by_class_id_header, s) for s in students]}
    # print(students)
    return students, 200


@app.route('/parents/<int:teacher_id>&<int:class_id>')
def get_parents_of_class(teacher_id, class_id):
    print(teacher_id)
    print(class_id)
    if not is_logged_in(teacher_id):
        return {'status': 'not logged in'}, 403

    parents = exec_mysql('CALL get_parents_by_class_id(%s)',  class_id)
    print(parents)
    parents = {'parents': [create_dict_from_lists(get_parents_by_class_id_header, p) for p in parents]}

    return parents, 200


@app.route('/students/grades/<int:teacher_id>&<int:class_id>')
def get_student_from_class_grades(teacher_id, class_id):
    print(teacher_id)
    print(class_id)
    if not is_logged_in(teacher_id):
        return {'status': 'not logged in'}, 403

    students = exec_mysql('CALL get_stud_by_class_id(%s)', class_id)

    students = {'students': [create_dict_from_lists(get_stud_by_class_id_header, s) for s in students]}
    for s in students['students']:
        del s['email']
        grades = exec_mysql('CALL get_grades_by_stud_uid(%s, %s)', (s['user_id'], teacher_id))
        s['grades'] = [create_dict_from_lists(get_grades_by_stud_uid_header, g) for g in grades]

        # works if teacher teaches just one subject
        # to change in next version
        teacher_subject = exec_mysql('SELECT get_subject_by_tuid(%s)', teacher_id)[0][0]
        mean = exec_mysql('CALL compute_average(%s, %s, %s, %s)', (class_id, teacher_id, teacher_subject, 1))
        mean = exec_mysql('CALL get_mean_grade_by_stud_uid(%s, %s)', (s['user_id'], teacher_id))[0][0]
        # print(mean)
        s['mean'] = mean
    # print(students)

    return students, 200


@app.route('/students/grades/<int:teacher_id>&<int:class_id>/add', methods=['POST'])
def get_student_grades(teacher_id, class_id):
    print(teacher_id)
    print(class_id)
    payload = request.get_json()
    print(payload)
    if not is_logged_in(teacher_id):
        return {'status': 'not logged in'}, 403

    teacher_subject = exec_mysql('SELECT get_subject_by_tuid(%s)', teacher_id)[0][0]
    print(teacher_subject)

    add_examination = exec_mysql(
        'CALL add_examination(%s, %s, %s, %s, %s, %s, %s)',
        (
            payload['user_id'],
            teacher_id,
            teacher_subject,
            payload['examination_type'],
            payload['score'],
            payload['student_feedback'],
            payload['parent_feedback'],
        )
    )
    # print(add_examination)
    grades = exec_mysql('CALL get_grades_by_stud_uid(%s, %s)', (payload['user_id'], teacher_id))
    grades = [create_dict_from_lists(get_grades_by_stud_uid_header, g) for g in grades]
    print(grades)
    return {'grades': grades}, 200


@app.route('/profile/teacher/<int:teacher_id>')
def get_teacher_profile(teacher_id):
    print(teacher_id)
    if not is_logged_in(teacher_id):
        return {'status': 'not logged in'}, 403
    profile = exec_mysql('CALL get_teacher_profile(%s)', teacher_id)[0]
    print(profile)
    return create_dict_from_lists(get_teacher_profile_header, profile), 200


@app.route('/profile/teacher/<int:teacher_id>/update', methods=['POST'])
def update_teacher_profile(teacher_id):
    print(teacher_id)
    payload = request.get_json()
    print(payload)
    print("AAAAAA")
    if not is_logged_in(teacher_id):
        return {'status': 'not logged in'}, 403
    update = exec_mysql(
        'CALL update_teacher_profile(%s, %s, %s, %s, %s)',
        (
            teacher_id,
            payload['first_name'],
            payload['last_name'],
            payload['email'],
            payload['phone_number'],
        )
    )
    if len(update) == 0:
        return {'status': 'OK'}, 200
    return {'status': 'ooops, something went wrong'}, 500


@app.route('/')
def index():
    return {'status': "Hello world"}, 200


if __name__ == '__main__':
    app.run(port=8080)
