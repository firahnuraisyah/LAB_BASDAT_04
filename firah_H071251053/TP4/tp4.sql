SET search_path TO "classicmodels";

-- 1
SELECT
	customernumber,
	SUM(amount) AS "Total Akumulasi",
	COUNT(DISTINCT checknumber) AS "Frekuensi Transaksi",
	MAX(amount) AS "Setoran Terbesar"
FROM payments
GROUP BY customernumber
HAVING 
	COUNT(DISTINCT checknumber) > 4 AND
	AVG(amount) > 20000;

-- 2
SELECT
	customernumber,
	SUM(amount) AS "Total Dana"
FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 80000
ORDER BY SUM(amount) DESC;

-- 3
SELECT
	productline,
	COUNT(DISTINCT productcode) AS ragam_produk,
	ROUND(AVG(MSRP), 2) AS rata_rata_harga,
	STRING_AGG(DISTINCT productname, ', ') AS nama_produk
FROM products
GROUP BY productline
HAVING COUNT(productcode) > 10;

-- 4
SELECT DISTINCT reportsto FROM employees
EXCEPT
SELECT DISTINCT employeenumber FROM employees
WHERE jobtitle LIKE '%VP%' OR jobtitle LIKE '%President%';

SELECT * FROM employees;

-- 5
SELECT
	productcode,
	SUM(quantityordered) AS total_akumulasi,
	ROUND(AVG(priceeach), 2) AS rata_rata_harga
FROM orderdetails
WHERE priceeach > 100
GROUP BY productcode
HAVING SUM(quantityordered) > 50
ORDER BY SUM(quantityordered) DESC;

-- 6
SELECT
	productcode,
	SUM(quantityordered) AS total_unit,
	SUM(quantityordered * priceeach) AS estimasi_pendapatan_kotor,
	ROUND(AVG(priceeach), 2) AS rata_rata_harga,
	MAX(priceeach) - MIN(priceeach) AS rentang_volatilitas_harga 
FROM orderdetails
WHERE orderlinenumber <= 20
GROUP BY productcode
HAVING SUM(quantityordered * priceeach) > 50000
ORDER BY estimasi_pendapatan_kotor DESC;

-- 7
(SELECT customernumber FROM customers
WHERE creditlimit > 80000
INTERSECT
SELECT customernumber FROM orders
WHERE status = 'Cancelled' OR status = 'On Hold')
EXCEPT
SELECT customernumber FROM payments
GROUP BY customernumber 
HAVING SUM(amount) > 100000;

-- studycase
-- 1
SELECT
	COUNT(*) AS jumlah_seluruh_produk,
	COUNT(quantityinstock) AS total_stok_fisik,
	ROUND(AVG(buyprice), 2) AS rata_rata_harga,
	MIN(buyprice) AS harga_termurah,
	MAX(buyprice) AS harga_termahal
FROM products;

-- 2
SELECT 
	country,
	COUNT(*) AS jumlah_pelanggan
FROM customers
GROUP BY country
ORDER BY jumlah_pelanggan DESC
LIMIT 5;













