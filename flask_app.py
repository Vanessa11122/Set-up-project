
from flask import Flask, redirect, render_template, request, url_for
from dotenv import load_dotenv
import os
import git
import hmac
import hashlib
from db import db_read, db_write
from auth import login_manager, authenticate, register_user
from flask_login import login_user, logout_user, login_required, current_user
import logging
import pymysql

logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s [%(levelname)s] %(name)s: %(message)s",
)

# Load .env variables
load_dotenv()
W_SECRET = os.getenv("W_SECRET")

# Init flask app
app = Flask(__name__)
app.config["DEBUG"] = True
app.secret_key = "supersecret"

# Init auth
login_manager.init_app(app)
login_manager.login_view = "login"

# DON'T CHANGE
def is_valid_signature(x_hub_signature, data, private_key):
    hash_algorithm, github_signature = x_hub_signature.split('=', 1)
    algorithm = hashlib.__dict__.get(hash_algorithm)
    encoded_key = bytes(private_key, 'latin-1')
    mac = hmac.new(encoded_key, msg=data, digestmod=algorithm)
    return hmac.compare_digest(mac.hexdigest(), github_signature)

# DON'T CHANGE
@app.post('/update_server')
def webhook():
    x_hub_signature = request.headers.get('X-Hub-Signature')
    if is_valid_signature(x_hub_signature, request.data, W_SECRET):
        repo = git.Repo('./mysite')
        origin = repo.remotes.origin
        origin.pull()
        return 'Updated PythonAnywhere successfully', 200
    return 'Unathorized', 401

# Auth routes
@app.route("/login", methods=["GET", "POST"])
def login():
    error = None

    if request.method == "POST":
        user = authenticate(
            request.form["username"],
            request.form["password"]
        )

        if user:
            login_user(user)
            return redirect(url_for("index"))

        error = "Benutzername oder Passwort ist falsch."

    return render_template(
        "auth.html",
        title="In dein Konto einloggen",
        action=url_for("login"),
        button_label="Einloggen",
        error=error,
        footer_text="Noch kein Konto?",
        footer_link_url=url_for("register"),
        footer_link_label="Registrieren"
    )


@app.route("/register", methods=["GET", "POST"])
def register():
    error = None

    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]

        ok = register_user(username, password)
        if ok:
            return redirect(url_for("login"))

        error = "Benutzername existiert bereits."

    return render_template(
        "auth.html",
        title="Neues Konto erstellen",
        action=url_for("register"),
        button_label="Registrieren",
        error=error,
        footer_text="Du hast bereits ein Konto?",
        footer_link_url=url_for("login"),
        footer_link_label="Einloggen"
    )

@app.route("/logout")
@login_required
def logout():
    logout_user()
    return redirect(url_for("index"))



# App routes
@app.route("/", methods=["GET", "POST"])
@login_required
def index():
    # GET
    if request.method == "GET":
        todos = db_read("SELECT id, content, due FROM todos WHERE user_id=%s ORDER BY due", (current_user.id,))
        return render_template("main_page.html", todos=todos)

    # POST
    content = request.form["contents"]
    due = request.form["due_at"]
    db_write("INSERT INTO todos (user_id, content, due) VALUES (%s, %s, %s)", (current_user.id, content, due, ))
    return redirect(url_for("index"))

@app.route("/Test1")
def test(): 
    return render_template("Test1.html") 

@app.route("/")
def home():
    return render_template("main_page.html")

@app.post("/complete")
@login_required
def complete():
    todo_id = request.form.get("id")
    db_write("DELETE FROM todos WHERE user_id=%s AND id=%s", (current_user.id, todo_id,))
    return redirect(url_for("index"))

if __name__ == "__main__":
    app.run()


from flask import Flask, render_template, request, redirect, url_for
import pymysql

app = Flask(__name__)

# ----------------------
# MySQL Verbindung
# ----------------------


import mysql.connector
from mysql.connector import pooling

DB_CONFIG = {
    "host": "Vanessa1.mysql.pythonanywhere-services.com",
    "user": "Vanessa1",
    "password": '376aqk376',  # Das Passwort, das du gerade gesetzt hast
     "database":'Vanessa1$default',           # Exakt so, wie auf PythonAnywhere
}

pool = pooling.MySQLConnectionPool(pool_name="pool", pool_size=5, **DB_CONFIG)


# ----------------------
# Routen
# ----------------------

# Startseite: Liste aller Trips
@app.route('/Reisen')
def index():
    with db.cursor() as cursor:
        cursor.execute("SELECT * FROM trips ORDER BY start_date")
        trips = cursor.fetchall()
    return render_template('index.html', trips=trips)

# Neue Reise erstellen
@app.route('/add_trip', methods=['GET', 'POST'])
def add_trip():
    if request.method == 'POST':
        destination = request.form['destination']
        start_date = request.form['start_date']
        end_date = request.form['end_date']
        total_budget = request.form['total_budget']

        with db.cursor() as cursor:
            cursor.execute(
                "INSERT INTO trips (destination, start_date, end_date, total_budget) VALUES (%s, %s, %s, %s)",
                (destination, start_date, end_date, total_budget)
            )
            db.commit()
        return redirect(url_for('index'))

    return render_template('add_trip.html')

# Trip Details
@app.route('/trip/<int:trip_id>')
def trip_detail(trip_id):
    with db.cursor() as cursor:
        cursor.execute("SELECT * FROM trips WHERE id = %s", (trip_id,))
        trip = cursor.fetchone()

        cursor.execute("SELECT * FROM hotels WHERE trip_id = %s", (trip_id,))
        hotels = cursor.fetchall()

        cursor.execute("SELECT * FROM transports WHERE trip_id = %s", (trip_id,))
        transports = cursor.fetchall()

        cursor.execute("SELECT * FROM sights WHERE trip_id = %s", (trip_id,))
        sights = cursor.fetchall()

        cursor.execute("SELECT * FROM restaurants WHERE trip_id = %s", (trip_id,))
        restaurants = cursor.fetchall()

    return render_template(
        'trip_detail.html',
        trip=trip,
        hotels=hotels,
        transports=transports,
        sights=sights,
        restaurants=restaurants
    )

# ----------------------
# App starten
# ----------------------
if __name__ == '__main__':
    app.run(debug=True)
