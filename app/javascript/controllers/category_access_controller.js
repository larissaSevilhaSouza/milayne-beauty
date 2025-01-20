import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="category-access"
export default class extends Controller {
  static targets = ["toggle", "items"]

  connect() {
    this.showFirstCategory();
  }

  tab(event) {
    event.preventDefault();
    const categoryId = event.currentTarget.dataset.categoryId;
    const items = this.itemsTargets.find(
      (items) => items.dataset.categoryId === categoryId
    );

    // Ocultar todas as outras categorias
    this.itemsTargets.forEach(target => {
      target.classList.add("hidden");
    });

    // Mostrar a categoria selecionada
    items.classList.remove("hidden");
  }

  showFirstCategory() {
    if (this.itemsTargets.length > 0) {
      this.itemsTargets[0].classList.remove("hidden");
    }
  }
}
