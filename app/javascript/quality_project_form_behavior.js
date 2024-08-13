document.addEventListener("turbo:load", function() {
  const baseSelector = document.getElementById("base_selector");
  const baseMaterialField = document.getElementById("base_material_field");
  const subcomponentField = document.getElementById("subcomponent_field");
  const subcomponentMaterialField = document.getElementById("subcomponent-material-field");
  const childFieldsContainer = document.getElementById("child-fields-container");
  const addChildFieldButton = document.getElementById("add-child-field");

  let childFieldCount = 1;

  function updateFieldVisibility() {
    const selectedValue = baseSelector.value;

    if (selectedValue === "no") {
      baseMaterialField.style.display = "block";
      baseMaterialField.setAttribute("name", "part[base_material]");
      subcomponentField.style.display = "none";
      subcomponentMaterialField.removeAttribute("name");
    } else {
      baseMaterialField.style.display = "none";
      baseMaterialField.removeAttribute("name");
      subcomponentField.style.display = "block";
      subcomponentMaterialField.setAttribute("name", "part[base_material]");
    }
  }

  if (baseSelector !== null) {
    baseSelector.addEventListener("change", updateFieldVisibility);
  }

  addChildFieldButton.addEventListener("click", function() {
    const newChildField = document.createElement("div");
    newChildField.classList.add("child-field", "d-flex", "small");
    newChildField.id = `child${childFieldCount}`;

    newChildField.innerHTML = `
<ul class="list-unstyled">
  <li class="mb-3">
    <div class="d-flex justify-content-between align-items-center">
      <label for="child${childFieldCount}_number" class="form-label mb-0">Part number</label>
      <input id="child${childFieldCount}_number" type="text" name="subcomponents[child${childFieldCount}][number]" class="form-control w-50">
    </div>
  </li>
  <li class="mb-3">
    <div class="d-flex justify-content-between align-items-center">
      <label for="child${childFieldCount}_revision" class="form-label mb-0">Revision</label>
      <input id="child${childFieldCount}_revision" type="text" name="subcomponents[child${childFieldCount}][revision]" class="form-control w-50">
    </div>
  </li>
  <li class="mb-3">
    <div class="d-flex justify-content-between align-items-center">
      <label for="child${childFieldCount}_base_material" class="form-label mb-0">Base material</label>
      <input id="child${childFieldCount}_base_material" type="text" name="subcomponents[child${childFieldCount}][base_material]" class="form-control w-50">
    </div>
  </li>
  <li class="mb-3">
    <div class="d-flex justify-content-between align-items-center">
      <label for="child${childFieldCount}_finish" class="form-label mb-0">Finish</label>
      <input id="child${childFieldCount}_finish" type="text" name="subcomponents[child${childFieldCount}][finish]" class="form-control w-50">
    </div>
  </li>
  <li class="text-center mt-3">
    <button type="button" class="remove-child-field btn btn-danger">Remove</button>
  </li>
</ul>`;

    childFieldsContainer.appendChild(newChildField);
    childFieldCount++;
  });

  childFieldsContainer.addEventListener("click", function(event) {
    if (event.target.classList.contains("remove-child-field")) {
      event.target.closest('.child-field').remove();
    }
  });
});