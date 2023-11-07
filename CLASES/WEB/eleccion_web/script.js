document.getElementById('opcion1').addEventListener('click', function() {
    guardarEleccion(1);
});

document.getElementById('opcion2').addEventListener('click', function() {
    guardarEleccion(2);
});

document.getElementById('opcion3').addEventListener('click', function() {
    guardarEleccion(3);
});

function guardarEleccion(opcion) {
    fetch('/guardar-eleccion', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ opcion: opcion })
    })
    .then(response => response.text())
    .then(data => {
        alert(data); // Muestra la respuesta del servidor
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Error al enviar la elección al servidor.');
    });
}

document.getElementById('enviar').addEventListener('click', enviarEleccionAlServidor);

function enviarEleccionAlServidor() {
    const eleccionUsuario = localStorage.getItem('eleccionUsuario'); // Obtener la elección del almacenamiento local
    if (eleccionUsuario) {
        fetch('/guardar-eleccion', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ opcion: parseInt(eleccionUsuario) })
        })
        .then(response => response.text())
        .then(data => {
            alert(data); // Muestra la respuesta del servidor
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error al enviar la elección al servidor.');
        });
    } else {
        alert('No hay una elección para enviar al servidor.');
    }
}