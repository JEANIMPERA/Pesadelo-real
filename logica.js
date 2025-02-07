document.addEventListener("DOMContentLoaded", function() {
    console.log("Script carregado com sucesso!");
    
    // Função para validar formulário de cadastro e login
    function validarFormulario(event) {
        let email = document.getElementById("email").value;
        let senha = document.getElementById("senha").value;
        
        if (!email.includes("@") || senha.length < 6) {
            event.preventDefault();
            alert("Por favor, insira um e-mail válido e uma senha com pelo menos 6 caracteres.");
        }
    }
    
    let formCadastro = document.querySelector("form[action='bancodedados.py']");
    if (formCadastro) {
        formCadastro.addEventListener("submit", validarFormulario);
    }
    
    // Filtro de histórias na página explorarhistorias.html
    let campoPesquisa = document.getElementById("pesquisa");
    if (campoPesquisa) {
        campoPesquisa.addEventListener("input", function() {
            let termo = this.value.toLowerCase();
            let historias = document.querySelectorAll(".historia");
            historias.forEach(historia => {
                let titulo = historia.querySelector("h3").innerText.toLowerCase();
                historia.style.display = titulo.includes(termo) ? "block" : "none";
            });
        });
    }
});
