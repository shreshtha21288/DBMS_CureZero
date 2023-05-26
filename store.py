from flask import Flask, render_template, request, redirect, url_for, session, flash
from flask_mysqldb import MySQL
app = Flask(__name__, template_folder = 'templates')
app.secret_key = 'hello'
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'abc'   
app.config['MYSQL_DB'] = 'pharmacy'
mysql = MySQL(app)
@app.route('/')
#landing page
def land():
    return render_template('home.html')
#home page
@app.route('/home',methods=['GET','POST'])
def home():
    if request.method=='POST':
        ch=request.form.get('ch')
        if ch=='admin':
            return redirect(url_for('admin_login'))
        elif ch=='customer':
            return redirect(url_for('customer_login'))
        elif ch=='employee':
            return redirect(url_for('employee_login'))
    return render_template('home.html')
#admin login
@app.route('/admin_login',methods=['GET','POST'])
def admin_login():
    try:
        if request.method=='POST':
            username=request.form['username']
            password=request.form['password']
            cur=mysql.connection.cursor()
            cur.execute("SELECT * FROM ADMIN WHERE ep_name=%s AND ep_pswd=%s", (username,password))
            user=cur.fetchone()
            cur.close() 
            if user:
                session['ch']='admin'
                session['username']=user[0]
                session['password'] = user[1]
                return redirect(url_for('dashboard'))
            else:
                return render_template('admin_login.html',error='Invalid username or password')  
        return render_template('admin_login.html')
    except TypeError:
        return render_template('admin_login.html',error='Invalid username or password')  
#view dashboard
@app.route('/dashboard')
def dashboard():
    cur=mysql.connection.cursor()
    cur.execute("SELECT * FROM TOTAL;")
    total_sales=cur.fetchall()
    cur.execute("SELECT * FROM IN_STOCK;")
    in_stock_medicines=cur.fetchall()
    cur.execute("SELECT * FROM OUT_STOCK;")
    out_of_stock_medicines=cur.fetchall()
    cur.close()
    return render_template('dashboard.html',total_sales=total_sales,in_stock_medicines=in_stock_medicines,out_of_stock_medicines=out_of_stock_medicines,session=session)
#view list of medicines
@app.route('/medicines')
def medicines():
    cur=mysql.connection.cursor()
    cur.execute("SELECT * FROM medicine")
    medicines=cur.fetchall()
    cur.close()
    return render_template('medicines.html',medicines=medicines)
#add medicine
@app.route('/medicines/add',methods=['GET','POST'])
def add_medicine():
    if request.method=='POST':
        medicine_id=request.form['medicine_id']
        medicine_name=request.form['medicine_name']
        company=request.form['company']
        unit_price=request.form['unit_price']
        category = request.form['category']
        prescription_required = request.form['prescription_required']
        expiry_date = request.form['expiry_date']
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO medicine (med_id, med_name, company, med_price, category, presc, expiry_date)"
                    "VALUES (%s, %s, %s, %s, %s, %s, %s)",
                    (medicine_id, medicine_name, company, unit_price, category, prescription_required, expiry_date))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('medicines'))
    return render_template('add_medicine.html')
#search medicine
@app.route('/medicines/search', methods=['GET', 'POST'])
def search_medicine():
    if request.method == 'POST':
        medicine_name = request.form['medicine_name']
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM medicine WHERE med_name LIKE %s;",('%' + medicine_name + '%',))
        medicines = cur.fetchall()
        cur.close()
        if medicines:
            if session['ch']=='admin' or session['ch']=='employee':
                return render_template('medicines.html', medicines=medicines)
            elif session['ch']=='customer':
                return render_template('emp_medicines.html',medicines=medicines)
        else:
            if session['ch']=='admin' or session['ch']=='employee':
                flash('Medicine not present')
                return redirect(url_for('medicines'))
            elif session['ch']=='customer':
                flash('Medicine not present')
                return redirect(url_for('emp_medicines'))
#update medicine
@app.route('/medicines/update/<int:medicine_id>', methods=['GET', 'POST'])
def update_medicine(medicine_id):
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM medicine WHERE med_id = %s", (medicine_id,))
    medicines = cur.fetchone()
    cur.close()
    if request.method == 'POST':
        unit_price = request.form['unit_price']
        cur = mysql.connection.cursor()
        cur.execute("UPDATE medicine SET med_price = %s WHERE med_id = %s", (unit_price, medicine_id))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('medicines'))
    return render_template('update_medicine.html', medicines=medicines)
#delete medicine
@app.route('/medicines/delete/<int:medicine_id>', methods=['GET', 'POST'])
def delete_medicine(medicine_id):
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM medicine WHERE med_id = %s", (medicine_id,))
    medicines = cur.fetchone()
    cur.close()
    if request.method == 'POST':
        cur = mysql.connection.cursor()
        cur.execute("DELETE FROM medicine WHERE med_id = %s", (medicine_id,))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('medicines'))
    return render_template('delete_medicine.html', medicines=medicines)
#manage staff details
@app.route('/staff')
def staff():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM STAFF;")
    emp = cur.fetchall()
    cur.close()
    return render_template('staff.html', emp=emp)
#search staff
@app.route('/staff/search',methods=['GET','POST'])
def search_staff():
    if request.method=='POST':
        ep_name = request.form['ep_name']
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM STAFF WHERE ep_name LIKE %s;",('%' + ep_name + '%',))
        emp = cur.fetchall()
        cur.close()
        if emp:
            return render_template('staff.html', emp=emp)
        else:
            flash('Staff not present')
            return redirect(url_for('staff'))
#add staff
@app.route('/add_staff', methods=['GET', 'POST'])
def add_staff():
    if request.method == 'POST':
        ep_id = request.form['ep_id']
        ep_name = request.form['ep_name']
        ep_contact = request.form['ep_contact']
        ep_address = request.form['ep_address']
        ep_salary = request.form['ep_salary']
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO EMPLOYEE (ep_id, ep_name, ep_contact, ep_address, ep_salary) VALUES (%s, %s, %s, %s, %s)", (ep_id, ep_name, ep_contact, ep_address, ep_salary))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('staff'))
    return render_template('add_staff.html')
#delete staff
@app.route('/delete_staff/<string:ep_id>', methods=['POST'])
def delete_staff(ep_id):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM EMPLOYEE WHERE ep_id = %s", (ep_id,))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('staff'))
#update staff
@app.route('/edit_staff/<string:ep_id>', methods=['GET', 'POST'])
def edit_staff(ep_id):
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM EMPLOYEE WHERE ep_id = %s", (ep_id,))
    emp = cur.fetchone()
    cur.close()
    if request.method == 'POST':
        ep_name = request.form['ep_name']
        ep_contact = request.form['ep_contact']
        ep_address = request.form['ep_address']
        ep_salary = request.form['ep_salary']
        cur = mysql.connection.cursor()
        cur.execute("UPDATE EMPLOYEE SET ep_name = %s, ep_contact = %s, ep_address = %s, ep_salary = %s WHERE ep_id = %s", (ep_name, ep_contact, ep_address, ep_salary, ep_id))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('staff'))
    return render_template('edit_staff.html', emp=emp)
#view supplier details
@app.route('/suppliers')
def suppliers():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM supplier")
    suppliers = cur.fetchall()
    cur.close()
    return render_template('suppliers.html', suppliers=suppliers)
#search supplier
@app.route('/suppliers/search',methods=['GET','POST'])
def search_supplier():
    if request.method=='POST':
        sup_name = request.form['sup_name']
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM SUPPLIER WHERE sup_name LIKE %s;",('%' + sup_name + '%',))
        suppliers = cur.fetchall()
        cur.close()
        if suppliers:
            return render_template('suppliers.html', suppliers=suppliers)
        else:
            flash('Supplier not present')
            return redirect(url_for('suppliers'))
#add supplier details
@app.route('/add_supplier', methods=['GET', 'POST'])
def add_supplier():
    if request.method == 'POST':
        supplier_id = request.form['supplier_id']
        supplier_name = request.form['supplier_name']
        supplier_contact = request.form['supplier_contact']
        supplier_address = request.form['supplier_address']
        supplier_email = request.form['supplier_email']
        supplier_quantity = request.form['supplier_quantity']
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO SUPPLIER(sup_id, sup_name, sup_contact, sup_address, sup_email, sup_quantity) VALUES (%s, %s, %s, %s, %s, %s)", (supplier_id, supplier_name, supplier_contact, supplier_address, supplier_email, supplier_quantity))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('suppliers'))
    return render_template('add_supplier.html')
#update supplier details
@app.route('/edit_supplier/<int:supplier_id>', methods=['GET', 'POST'])
def edit_supplier(supplier_id):
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM supplier WHERE sup_id = %s", (supplier_id,))
    supplier = cur.fetchone()
    cur.close()
    if request.method == 'POST':
        supplier_id = request.form['supplier_id']
        supplier_name = request.form['supplier_name']
        supplier_contact = request.form['supplier_contact']
        supplier_address = request.form['supplier_address']
        supplier_email = request.form['supplier_email']
        supplier_quantity = request.form['supplier_quantity']
        cur = mysql.connection.cursor()
        cur.execute("UPDATE supplier SET sup_name = %s, sup_contact = %s, sup_address = %s, sup_email = %s, sup_quantity = %s WHERE sup_id = %s", (supplier_name, supplier_contact, supplier_address, supplier_email, supplier_quantity, supplier_id))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('suppliers'))
    return render_template('edit_supplier.html', supplier=supplier)
#delete supplier details
@app.route('/delete_supplier/<int:supplier_id>', methods=['POST'])
def delete_supplier(supplier_id):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM supplier WHERE sup_id = %s", (supplier_id,))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('suppliers'))
#view customer details
@app.route('/customers')
def customers():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM CUSTOMERS;")
    customers = cur.fetchall()
    cur.close()
    return render_template('customers.html', customers=customers)
#search customer
@app.route('/customers/search',methods=['GET','POST'])
def search_customer():
    if request.method=='POST':
        cust_name = request.form['cust_name']
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM CUSTOMER WHERE cust_name LIKE %s;",('%' + cust_name + '%',))
        customers = cur.fetchall()
        cur.close()
        if customers:
            return render_template('customers.html', customers=customers)
        else:
            flash('Customer not present')
            return redirect(url_for('customers'))
#view transactions
@app.route('/transactions')
def transactions():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM transaction")
    transactions = cur.fetchall()
    cur.close()
    return render_template('transactions.html', transactions=transactions)
#add transaction
@app.route('/transactions/add', methods=['GET', 'POST'])
def add_transaction():
    if request.method == 'POST':
        transaction_id = request.form['transaction_id']
        cust_name = session['cust_name']
        total_amount = request.form['total_amount']
        quantity = session['quantity']
        transaction_date = request.form['transaction_date']
        payment_type = request.form['payment_type']
        medicine_id = session['medicine_id']
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM transaction WHERE transc_id = %s", [transaction_id])
        existing_transaction = cur.fetchone()
        if existing_transaction:
            flash("This transaction ID already exists. Please try a different ID.")
            return redirect(url_for('add_transaction'))
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO transaction (transc_id, cust_name, total_amount, quantity, transc_date, payment_type, med_id)"
                    "VALUES (%s, %s, %s, %s, %s, %s, %s)", (transaction_id, cust_name, total_amount, quantity, transaction_date, payment_type, medicine_id))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('transactions'))
    return render_template('add_transaction.html')
#search transactions
@app.route('/search_transaction>', methods=['GET', 'POST'])
def search_transaction():
    if request.method == 'POST':
        cust_name = request.form['cust_name']
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM transaction WHERE cust_name LIKE %s", ('%' + cust_name + '%',))
        transaction = cur.fetchall()
        cur.close()
        if transaction:
            return render_template('search_transaction.html', transaction=transaction)
        else:
            flash('Transaction not present')
            return redirect(url_for('transactions'))
#employee login
@app.route('/employee_login', methods=['GET', 'POST'])
def employee_login():
    try:
        if request.method == 'POST':
            username = request.form['username']
            password = request.form['password']
            cur = mysql.connection.cursor()
            cur.execute("SELECT * FROM EMPLOYEE WHERE ep_name = %s AND ep_pswd = %s", (username, password))
            user = cur.fetchone()
            cur.close() 
            if user:
                session['ch'] = 'employee'
                session['username'] = user[0]
                session['password'] = user[1]
                return redirect(url_for('dashboard'))
            else:
                return render_template('employee_login.html', error='Invalid username or password')  
        return render_template('employee_login.html')
    except TypeError:
        return render_template('employee_login.html', error='Invalid username or password') 
#view list of medicines
@app.route('/emp_medicines')
def emp_medicines():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM medicine;")
    medicines = cur.fetchall()
    cur.close()
    return render_template('emp_medicines.html', medicines=medicines)
#search medicine
@app.route('/emp_medicines/search', methods=['GET', 'POST'])
def search_medicine1():
    if request.method == 'POST':
        medicine_name = request.form['medicine_name']
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM medicine WHERE med_name LIKE %s;",('%' + medicine_name + '%',))
        medicines = cur.fetchall()
        cur.close()
        return render_template('emp_medicines.html', medicines=medicines)
    return redirect(url_for('medicines'))
#customer register
@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        cust_id = request.form['cust_id']
        cust_name = request.form['cust_name']
        cust_contact = request.form['cust_contact']
        cust_address = request.form['cust_address']
        cust_pres = request.form['cust_pres']
        cust_pswd = request.form['cust_pswd']
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO customer (cust_id, cust_name, cust_contact, cust_address, cust_pres, cust_pswd)"
                    "VALUES (%s, %s, %s, %s, %s, %s)", (cust_id, cust_name, cust_contact, cust_address, cust_pres, cust_pswd))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('customer_login'))
    return render_template('register.html')
#customer login
@app.route('/customer_login', methods=['GET', 'POST'])
def customer_login():
    try:
        if request.method == 'POST':
            username = request.form['username']
            password = request.form['password']
            cur = mysql.connection.cursor()
            cur.execute("SELECT * FROM CUSTOMER WHERE cust_name = %s AND cust_pswd = %s", (username, password))
            user = cur.fetchone()
            cur.close() 
            if user:
                session['ch'] = 'customer'
                session['username'] = user[0]
                session['password'] = user[1]
                return redirect(url_for('emp_medicines'))
            else:
                return render_template('customer_login.html', error='Invalid username or password')  
        return render_template('customer_login.html')
    except TypeError:
        return render_template('customer_login.html', error='Invalid username or password')
#place an order
@app.route('/order', methods=['GET', 'POST'])
def order():
    if request.method == 'POST':
        cust_name = request.form['cust_name']
        quantity = request.form['quantity']
        medicine_id = request.form['medicine_id']
        session['cust_name']=cust_name
        session['quantity']=quantity
        session['medicine_id']=medicine_id
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM STOCK WHERE med_id = %s", [medicine_id])
        stock = cur.fetchone()
        if stock[2] < int(quantity):
            flash("The quantity required exceeds the quantity present in stock.")
            return redirect(url_for('order'))
        return redirect(url_for('confirm', cust_name=cust_name, quantity=quantity, medicine_id=medicine_id))
    return render_template('order.html')
#confirm an order
@app.route('/confirm',methods=['GET','POST'])
def confirm():
    return render_template('confirm.html')
if __name__ == '__main__':
    app.run(debug=True)