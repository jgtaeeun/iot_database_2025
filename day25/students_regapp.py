# tkinter 탬플릿코드 작성 - 기본적인 GUI앱 틀  > 1~4
# 데이터베이스 CRUD 함수 구현  - SELECT 기능 구현 > 5 ,6
#                              - insert 기능 구현 > 7
#                              - update 기능 구현 > 8
#                              - delete 기능 구현 > 9

# 학생정보 등록 GUI 앱
# pip install pymysql


# 1. 관련 모듈 import 
import tkinter as tk
from tkinter import *                       # tkinter 은 이 코드로 모든 모듈을 부를 수 없음
from tkinter import ttk, messagebox
from tkinter.font import  *                 # 기본 외 폰트를 사용하려면

import pymysql                              # mysql-connector 등 다른 모듈도 사용추천

# 2. db관련 설정
host = 'localhost'                          # '127.0.0.1'
port = 3306
database = 'madang'
username = 'madang'
password = 'madang'

# 5. DB 처리 함수 정의
## 5-1. showDatas()  - db학생정보 테이블에서 데이터를 가져와 TreeView에 표시
def showDatas():
    '''
    데이터베이스 내 모든 학생정보를 가져와 표시하는 함수\n
    매개변수 필요없음
    '''
    ### 외부에 있는 변수를 전역변수로 사용
    global dataView   

    ### db연결 (커넥션 객체 생성->커서-> 쿼리실행->커서로 데이터 패치-> 커서종료->커넥션 종료)
    conn = pymysql.connect(host=host, user=username, password=password, database=database, port=port)
    cursor = conn.cursor()      # 쿼리실행시  반드시 커서 생성
    query = 'select std_id, std_name, std_mobile, std_regyear from students'
    cursor.execute(query =query)
    data = cursor.fetchall()
   

    ### 가져온 데이터 treeview에 추가
    print(data)
    dataView.delete(*dataView.get_children())   # 최초, 중간에 showDatas() 호출시마다 트리뷰에 있는 모든 행을 삭제하여 트리뷰를 초기화합니다.
    for i , (std_id, std_name, std_mobile, std_regyear) in enumerate(data, start=1):    # mysql같은 데이터베이스에서는 인덱스 1부터 시작하기에 enumerate의 start =1 이다.
        dataView.insert('','end',values=(std_id, std_name, std_mobile, std_regyear))   
                                                                                        #첫 번째 인수인 ''은 부모 항목을 지정하는 부분입니다. 여기서는 루트 항목을 의미하며, 모든 항목을 최상위로 추가하려면 빈 문자열을 사용합니다.
                                                                                        #'end'는 새 항목을 트리뷰의 마지막에 추가하라는 의미입니다.
    cursor.close()
    conn.close()

# 6. getData(event) - 트리뷰 한줄 더블클릭한 값 엔트리에 표시
def getData(event):
    '''
    트리뷰 더블클릭으로 선택된 학생정보를 엔트리 위젯에 채우는 사용자 함수 \n

    Args: 
        event : 트리뷰에 발생하는 이벤트 객체
    '''
    global ent1, ent2, ent3, ent4, dataView

    ## 엔트리 위젯 기존 내용 삭제 - 이 코드가 없다면 엔트리 위젯에 글자들이 계속 덧붙여지게 된다.
    ent1.config(state='normal')
    ent1.delete(0, END)
    ent1.config(state='readonly')
    ent2.delete(0, END)
    ent3.delete(0, END)
    ent4.delete(0, END)

    ## 트리뷰 선택항목 ID 가져오기
    sel_item = dataView.selection()

    ## 선택한 항목의 모든 값 가져오기
    if sel_item :
        item_values = dataView.item(sel_item, 'values') 
    
    ## 엔트리 위젯에 가져온 값 각각 넣기  (1, '정해성', '010-9999-8888', 2020)
    ent1.config(state='normal')
    ent1.insert(0, item_values[0])
    ent1.config(state='readonly')
    ent2.insert(0, item_values[1])
    ent3.insert(0, item_values[2])
    ent4.insert(0, item_values[3])

# 7. 학생정보 추가 함수
def addData():
    '''
    새 학생정보 db테이블에 추가 위한 사용자 함수
    ''' 
    global ent1, ent2, ent3, ent4, dataView

    ## 엔트리 위젯 학생정보 데이터 변수할당
    std_name = ent2.get()
    std_mobile =ent3.get()
    std_regyear = ent4.get()

    ## db연결
    conn = pymysql.connect(host=host, user=username, password=password, database=database, port=port)
    cursor = conn.cursor()      # 쿼리실행시  반드시 커서 생성
    
    try :
       conn.begin()
       query = 'insert into students(std_name, std_mobile, std_regyear) values(%s, %s,%s)'
       val = (std_name, std_mobile, std_regyear)
       cursor.execute(query =query, args= val)
       
       # 트랜잭션 확정
       conn.commit()
       # 마지막에 insert된 레코드 id 추출(auto_increment)
       lastid=cursor.lastrowid
       print(lastid)
       messagebox.showinfo('INSERT', '학생등록 성공!')

       ent1.config(state='normal')
       ent1.delete(0, END)
       ent1.config(state='readonly')
       ent2.delete(0, END)
       ent3.delete(0, END)
       ent4.delete(0, END)
       ent2.focus_set()

    except Exception as e:
        print(e)
        conn.rollback()
        messagebox.showerror('INSERT', '학생등록 실패!')

    finally :
        cursor.close()
        conn.close()
    
    showDatas()     
    
    
# 8. 기존 학생 정보를 수정
def modData():
    '''
    기존 학생정보 수정하는 사용자 함수
    '''
    global ent1, ent2, ent3, ent4, dataView

    std_id = ent1.get()
    std_name = ent2.get()
    std_mobile =ent3.get()
    std_regyear = ent4.get()

    if std_id == '':
        messagebox.showwarning('UPDATE','수정할 데이터를 선택하시오')
        return
    
    ## db연결
    conn = pymysql.connect(host=host, user=username, password=password, database=database, port=port)
    cursor = conn.cursor()      # 쿼리실행시  반드시 커서 생성
    
    try :
       conn.begin()
       query = 'update  students set std_name = %s, std_mobile =  %s, std_regyear = %s where std_id = %s'
       val = (std_name, std_mobile, std_regyear, std_id)
       cursor.execute(query =query, args= val)
       
       # 트랜잭션 확정
       conn.commit()
       # 마지막에 insert된 레코드 id 추출(auto_increment)
       lastid=cursor.lastrowid
       print(lastid)
       messagebox.showinfo('UPDATE', '학생수정 성공!')

       ent1.config(state='normal')
       ent1.delete(0, END)
       ent1.config(state='readonly')
       ent2.delete(0, END)
       ent3.delete(0, END)
       ent4.delete(0, END)
       ent2.focus_set()

    except Exception as e:
        print(e)
        conn.rollback()
        messagebox.showerror('UPDATE', '학생수정 실패!')

    finally :
        cursor.close()
        conn.close()
    
    showDatas()     
    
# 9. 삭제
def delData():
    '''
    기존 학생정보 삭제하는 사용자 함수
    '''
    global ent1, ent2, ent3, ent4, dataView

    std_id = ent1.get()

    if std_id == '':
        messagebox.showwarning('DELETE','삭제할 데이터를 선택하시오')
        return
    
    ## db연결
    conn = pymysql.connect(host=host, user=username, password=password, database=database, port=port)
    cursor = conn.cursor()      # 쿼리실행시  반드시 커서 생성
    
    try :
       conn.begin()
       query = 'delete from  students where std_id = %s'
       val = (std_id)
       cursor.execute(query =query, args= val)
       
       # 트랜잭션 확정
       conn.commit()
       # 마지막에 insert된 레코드 id 추출(auto_increment)
       lastid=cursor.lastrowid
       print(lastid)
       messagebox.showinfo('DELETE', '학생삭제 성공!')

       ent1.config(state='normal')
       ent1.delete(0, END)
       ent1.config(state='readonly')
       ent2.delete(0, END)
       ent3.delete(0, END)
       ent4.delete(0, END)
       ent2.focus_set()

    except Exception as e:
        print(e)
        conn.rollback()
        messagebox.showerror('DELETE', '학생삭제 실패!')

    finally :
        cursor.close()
        conn.close()
    
    showDatas()

# 3. tkinter UI 윈도우 설정
root = Tk()                                 # 클래스 Tk()
root.title('학생정보 등록앱')
root.geometry('820x500')
root.resizable(False,False)                 # 윈도우 사이즈 변경 불가
root.iconphoto(True, tk.PhotoImage(file='./images/school.png'))

myFont = Font(family='NanumGothic', size=10)    # 화면의 위젯에 지정할 동일 폰트

# 4. UI 구성

## 4-1.레이블
tk.Label(root, text='학생번호', font=myFont).place(x=10,y=10)
tk.Label(root, text='학생명', font=myFont).place(x=10,y=40)
tk.Label(root, text='핸드폰', font=myFont).place(x=10,y=70)
tk.Label(root, text='입학년도', font=myFont).place(x=10,y=100)

## 4-2.엔트리(텍스트박스)
ent1 = tk.Entry(root, font=myFont)
ent1.config(state='readonly', foreground='blue', disabledforeground='blue')   # 학생번호  -> db에 저장될 필요 없음. db에서 학생번호는 auto_increment이기 때문임
ent1.place(x=140, y=10)         # 학생번호 

ent2 = tk.Entry(root, font=myFont)
ent2.place(x=140, y=40)         # 학생명

ent3 = tk.Entry(root, font=myFont)
ent3.place(x=140, y=70)         # 학생 핸드폰

ent4 = tk.Entry(root, font=myFont)
ent4.place(x=140, y=100)         # 학생 입학년도

## 4-3.버튼 - 추가, 수정, 삭제 3개 구성하기
## 7-1. 추가버튼에 addData()함수 연결 
## 8-1. 수정버튼에 modData()함수 연결
## 9-1. 삭제버튼에 delData()함수 연결
tk.Button(root, text='추가', font=myFont, height=2, width=12, command=addData).place(x=30, y= 130)
tk.Button(root, text='수정', font=myFont, height=2, width=12,  command=modData).place(x=140, y= 130)
tk.Button(root, text='삭제', font=myFont, height=2, width=12, command=delData).place(x=250, y= 130)

## 4-4.트리뷰(행과 열로 만들어진 데이터 표현할 때 좋은 위젯 중 하나)
cols = ('학생번호','학생명','핸드폰','입학년도')
dataView = ttk.Treeview(root, columns=cols, show='headings', height=14)

## 4-5.트리뷰 설정
for col in cols :
    dataView.heading(col, text=col)                 # 각 열의 제목을 cols에서 하나씩 지정
    dataView.grid(row=1, column=0, columnspan=2)    # 트리뷰 위젯을 그리드 레이아웃에 배치
    dataView.place(x=10, y=180)                     # 트리뷰 위젯 배치 

# 5. showData() 수행
showDatas()

# 6. 트리뷰 항목을 더블클릭하면 이벤트발생(getData()함수 호출)
dataView.bind('<Double-Button-1>', func=getData)

# 10. 최초 실행시 ent2에 포커스
ent2.focus_set()

# 3. 앱 실행
root.mainloop()

