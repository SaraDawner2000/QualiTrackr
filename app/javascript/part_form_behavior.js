document.addEventListener("turbo:render", function() {
  const customerSelector = document.getElementById("customer_selector");
  const mctractorCustomerRequest = document.getElementById("mctractor_customer_request");
  const sparkyCustomerRequest = document.getElementById("sparky_customer_request");

  if (customerSelector) {
    customerSelector.addEventListener("change", function() {
      const selectedValue = this.value;
      if (selectedValue === "mctractor") {
        mctractorCustomerRequest.style.display = "block";
        sparkyCustomerRequest.removeAttribute("name");
      } else if (selectedValue === "sparky") {
        sparkyCustomerRequest.setAttribute("name", "quality_project[customer_request]");
        mctractorCustomerRequest.style.display = "none";
      } else {
        sparkyCustomerRequest.removeAttribute("name");
        mctractorCustomerRequest.style.display = "none";
      }
    });
  }
});