# 파이썬 웹앱(Flask)
# powershell에서 pip install Flask

from flask import Flask, render_template, request
import pymysql

# 변수 초기화
host = 'localhost'  # 'localhost' or '127.0.0.1'
port = 3306
database = 'madang'
username = 'root'
password = '12345'

conflag = True  # 접속상태

app = Flask(__name__)   # 플라스크 웹앱 실행

conn = pymysql.connect(host=host, user=username, passwd=password, database=database, port=port)
cursor = conn.cursor()

@app.route('/') #routing decorator :웹사이트 경로를 실행할 때  http://localhost:5000/
def index():
    sqlstring = 'SELECT bookid, bookname, publisher, price FROM Book'
    res = cursor.execute(sqlstring)
    book_list = cursor.fetchall()

    return render_template('booklist.html', book_list = book_list)

@app.route('/view') #http://localhost:5000/view/id=
def getDetail():
    bookid = request.args.get('id')
    sqlstring = f'SELECT bookid, bookname, publisher, price FROM Book WHERE bookid = {bookid}'
    cursor.execute(sqlstring)
    book = cursor.fetchall()

    return render_template('bookview.html', book = book)
if __name__ == '__main__':
    app.run('localhost')