<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Список автомобилей</title>
    <script>
        async function sendCar() {
            const car = {
                make: document.getElementById('make').value,
                model: document.getElementById('model').value,
                year: document.getElementById('year').value,
                color: document.getElementById('color').value,
                mileage: document.getElementById('mileage').value
            };

            const response = await fetch('CarServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(car)
            });

            if (response.ok) {
                location.reload();
            } else {
                alert('Ошибка при добавлении автомобиля');
            }
        }

        async function loadCars() {
            const response = await fetch('CarServlet');
            const cars = await response.json();
            const table = document.getElementById('carTable');

            cars.forEach(car => {
                const row = table.insertRow(-1);
                row.insertCell(0).innerText = car.make;
                row.insertCell(1).innerText = car.model;
                row.insertCell(2).innerText = car.year;
                row.insertCell(3).innerText = car.color;
                row.insertCell(4).innerText = car.mileage;
            });
        }

        document.addEventListener('DOMContentLoaded', loadCars);
    </script>
</head>
<body>
<h1>Список автомобилей</h1>
<form onsubmit="event.preventDefault(); sendCar();">
    <label>Марка: <input type="text" id="make" required></label><br>
    <label>Модель: <input type="text" id="model" required></label><br>
    <label>Год выпуска: <input type="number" id="year" required></label><br>
    <label>Цвет: <input type="text" id="color" required></label><br>
    <label>Пробег: <input type="number" id="mileage" required></label><br>
    <button type="submit">Добавить автомобиль</button>
</form>
<table id="carTable" border="1">
    <thead>
    <tr>
        <th>Марка</th>
        <th>Модель</th>
        <th>Год выпуска</th>
        <th>Цвет</th>
        <th>Пробег</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
</body>
</html>