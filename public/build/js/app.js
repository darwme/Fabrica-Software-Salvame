        // Generar opciones para los días (1-31)
        var diaSelect = document.getElementById("dia");
        for (var i = 1; i <= 31; i++) {
            var option = document.createElement("option");
            option.text = i;
            option.value = i;
            diaSelect.appendChild(option);
        }

        // Generar opciones para los meses 
        var mesSelect = document.getElementById("mes");
        var meses = [
            'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
            'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
        ];

        for (var i = 0; i < meses.length; i++) {
            var option = document.createElement("option");
            option.text = meses[i];
            option.value = i + 1;
            mesSelect.appendChild(option);
        }

        // Generar opciones para los años 
        var anoSelect = document.getElementById("ano");
        var anoActual = new Date().getFullYear();
        for (var i = 1900; i <= anoActual; i++) {
            var option = document.createElement("option");
            option.text = i;
            option.value = i;
            anoSelect.appendChild(option);
        }


document.addEventListener('DOMContentLoaded', function() {
    fetch('/api/alerts')
        .then(response => response.json())
        .then(data => {
            const tableBody = document.getElementById('alertsTable').querySelector('tbody');
            data.forEach(alert => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${alert.AlertNumber}</td>
                    <td>${alert.FechaPublicacion}</td>
                    <td>${alert.TipoAlerta === 'Revisado' ? '✔️' : ''}</td>
                    <td>${alert.TipoAlerta === 'Aceptado' ? '✔️' : ''}</td>
                    <td>${alert.TipoAlerta === 'Rechazado' ? '✔️' : ''}</td>
                `;
                tableBody.appendChild(row);
            });
        })
        .catch(error => console.error('Error:', error));
});
