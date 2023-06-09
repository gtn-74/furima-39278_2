function Price(){
  const itemPrice = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  itemPrice.addEventListener('input', function() {
    const Price = itemPrice.value;

    const Tax = Math.floor(Price * 0.1);
    addTaxPrice.textContent = Tax;

    const ProfitValue = Price - Tax;
    profit.textContent = ProfitValue;
  });
};
window.addEventListener('load', Price);