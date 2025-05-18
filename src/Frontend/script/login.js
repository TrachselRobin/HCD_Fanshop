const form = document.getElementById('login-form');

const login = async (event) => {
    event.preventDefault();
    const formData = new FormData(form);
    const data = Object.fromEntries(formData.entries());
    console.log(data);
}

const loadImage = async (event) => {
    // fetch from https://api.unsplash.com/photos/random?client_id=ST_hMchid9hl4rMtIiwEHKhegMdnIWyfGh9ZjVRWp00
    const response = await fetch('https://api.unsplash.com/photos/random?client_id=ST_hMchid9hl4rMtIiwEHKhegMdnIWyfGh9ZjVRWp00');
    const data = await response.json();
    const url = data.urls.regular;
    const author = "Bild von " + data.user.username;
    const authorElement = document.getElementById('author');
    const image = document.getElementById('left');
    
    authorElement.innerText = author;
    image.style.backgroundImage = `url(${url})`;
}

form.addEventListener('submit', login);
loadImage();