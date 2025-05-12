const backendUrl = 'http://13.53.127.208:3000/allProducts'; // Die URL des Backends in Docker Compose

fetch(`${backendUrl}/`)
    .then((response) => response.json())
    .then((data) => {
        document.getElementById("message").innerText = data[0].message; // Annahme, dass es ein Array ist
    })
    .catch((err) => {
        console.error("Failed to fetch from backend:", err);
        document.getElementById("message").innerText = "Error fetching data.";
    });
