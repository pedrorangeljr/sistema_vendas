window.buscarCep = function (cep) {
  cep = cep.replace(/\D/g, "");

  if (cep.length !== 8) {
    return;
  }

  console.log("Consultando CEP:", cep);

  fetch(`https://viacep.com.br/ws/${cep}/json/`)
    .then(response => {
      if (!response.ok) {
        throw new Error("Erro na comunicação com a API");
      }

      return response.json();
    })
    .then(data => {

      console.log("Resposta ViaCEP:", data);

      if (data.erro) {
        alert("CEP não encontrado.");
        limparEndereco();
        return;
      }

      document.getElementById("customer_street").value =
        data.logradouro || "";

      document.getElementById("customer_neighborhood").value =
        data.bairro || "";

      document.getElementById("customer_city").value =
        data.localidade || "";

      document.getElementById("customer_state").value =
        data.uf || "";
    })
    .catch(error => {
      console.error("Erro ao consultar CEP:", error);
      alert("Não foi possível consultar o CEP.");
    });
};


window.limparEndereco = function () {
  document.getElementById("customer_street").value = "";
  document.getElementById("customer_neighborhood").value = "";
  document.getElementById("customer_city").value = "";
  document.getElementById("customer_state").value = "";
};