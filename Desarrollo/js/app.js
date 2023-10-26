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