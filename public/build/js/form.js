      //queryselectors

      const btnLogin = document.querySelector('#btnLogin');
      const btnSingin = document.querySelector('#btnSingIn');
      const secLogin = document.querySelector('#sec-login');
      const secSingIn = document.querySelector('#sec-singIn');
      const body = document.querySelector('body');
      const form = document.querySelector('#form');
      const formSingin=document.querySelector('#formSingin')
      const btnInicio=document.querySelector('#btnInicio');
      const ingresar=document.querySelector('#ingresar');
      const registrarme=document.querySelector('#registrarme');
    
      function Login() {
        secLogin.classList.remove('inactive');
        secSingIn.classList.add('inactive');
        body.classList.add('overlay'); // Agregar una clase para crear un fondo oscuro
      }
    
      function Singin() {
        secLogin.classList.add('inactive');
        secSingIn.classList.remove('inactive');
        body.classList.add('overlay'); // Agregar una clase para crear un fondo oscuro
      }


    

      function handleClickOutside(event) {
        if (event.target !== btnLogin &&
            event.target !== btnSingin &&
            !secLogin.contains(event.target) &&
            !secSingIn.contains(event.target)) {
          secLogin.classList.add('inactive');
          secSingIn.classList.add('inactive');
          body.classList.remove('overlay'); // Quitar la clase para eliminar el fondo oscuro
        } 
      }
    
      //acciones de botones
      btnLogin.addEventListener("click", Login);
      btnSingin.addEventListener("click", Singin);
      body.addEventListener("click", handleClickOutside);



      