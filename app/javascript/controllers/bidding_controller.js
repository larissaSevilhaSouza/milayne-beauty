// src/controllers/bidding_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["yearSelect", "monthSelect", "filesList"];

  connect() {
    this.yearSelectTarget.value = this.data.get("currentYear");
    this.loadMonths();
  }

  loadMonths() {
    const year = this.yearSelectTarget.value;
    if (year) {
      fetch(`/bidding/months/${year}`)
        .then((response) => response.json())
        .then((data) => {
          this.monthSelectTarget.innerHTML =
            '<option class="capitalize" value="">Selecione o Mês</option>';
          data.forEach((month) => {
            const option = document.createElement("option");
            option.value = month;
            option.textContent = new Date(year, month - 1).toLocaleString(
              "default",
              { month: "long" }
            );
            this.monthSelectTarget.appendChild(option);
          });
          this.monthSelectTarget.disabled = false;

          const currentYear = this.data.get("currentYear");
          const currentMonth = this.data.get("currentMonth");
          if (year == currentYear) {
            this.monthSelectTarget.value = currentMonth;
          } else {
            this.monthSelectTarget.value = "";
          }

          this.loadFiles();
        });
    } else {
      this.monthSelectTarget.innerHTML =
        '<option class="capitalize" value="">Selecione o Mês</option>';
      this.monthSelectTarget.disabled = true;
      this.filesListTarget.innerHTML = "";
    }
  }

  loadFiles() {
    const year = this.yearSelectTarget.value;
    const month = this.monthSelectTarget.value;
    if (year && month) {
      fetch(`/bidding/files/${year}/${month}`)
        .then((response) => response.json())
        .then((data) => {
          this.filesListTarget.innerHTML = "";
          data.forEach((file) => {
            console.log(file);

            const filename = file.file.split('/').pop();

            const fileItem = document.createElement("div");
            fileItem.classList.add(
              "bg-white",
              "p-4",
              "rounded-lg",
              "shadow",
              "border",
              "border-gray-200"
            );
            fileItem.innerHTML = `
              <div class="block">
                <table class="w-full">
                  <thead>
                    <th colspan="2" class="border px-4 py-2"><strong>Número:</strong> ${
                      file.number !== undefined ? file.number : "0"
                    }</th>
                  </thead>
                  <tbody>
                    <tr>
                      <td class="border px-4 py-2"><strong>Modalidade:</strong> ${
                        file.modality || "-"
                      }</td>
                      <td class="border px-4 py-2"><strong>Data de Publicação:</strong> ${
                        file.publish_date ||
                        file.date_publish ||
                        "Data não disponível"
                      }</td>
                    </tr>
                    <tr>
                      <td
                        ${this.getSpecificDateRow(file)}
                      </td>
                      <td class="border px-4 py-2"><strong>Categoria de Licitação:</strong> ${
                        file.bidding_category || "Categoria não definida"
                      }</td>
                    </tr>
                    <tr>
                      <td class="border px-4 py-2" colspan="2">
                        <strong>Objeto:</strong> ${file.object}
                      </td>
                    </tr>
                    <tr>
                      <td ${
                        file.winner ? "" : `colspan="2"`
                      } class="border px-4 py-2">
                        <div data-controller="dialog" data-action="click->dialog#backdropClose">
                          <dialog data-dialog-target="dialog" class="rounded-lg shadow-md">
                            <div class="bg-white overflow-hidden p-6">
                              <div class="pb-8 flex justify-end items-center">
                                <h2 class="w-full flex justify-center items-center text-2xl font-semibold uppercase text-center text-[#004296]">Lista de Arquivos</h2>
                                <button class="hover:bg-red-800 text-slate-700 hover:text-white font-bold rounded transition duration-600 px-4 hidden md:block" type="button" data-action="dialog#close" autofocus>
                                  X
                                </button>
                              </div>
                              <div class="py-4 lg:min-w-[400px] ">
                                
                                <ul>
                                  ${
                                    file.file
                                      ? `
                                  <li class="mb-6 border-b">
                                    <a href="${file.file}" class="font-bold py-2 rounded w-full hover:text-[#004296] transition duration-600" target="_blank" download>
                                      ${filename}
                                    </a>
                                  </li>
                                  `
                                      : ""
                                  }
                                  ${file.archives
                                    .map(
                                      (archive) => `
                                    <li class="mb-6 border-b">
                                      <a href="${
                                        archive.file
                                      }" class="font-bold py-2 rounded w-full hover:text-[#004296] transition duration-600" target="_blank" download>
                                          ${archive.file_name || "Arquivo"}
                                      </a>
                                    </li>
                                    <li class="">
                                      <button class="btn w-full py-2 bg-blue-500 text-white rounded-lg" type="button" data-action="dialog#close" autofocus>
                                        fechar
                                      </button>
                                    </li>
                                  `
                                    )
                                    .join("")}
                                </ul>
                              </div>
                            </div>
                          </dialog>
                          <button class="w-fit bg-blue-800 hover:bg-blue-950 text-white font-bold py-2 px-4 rounded text-center" type="button" data-action="dialog#open">
                             Lista de Arquivos 
                          </button>
                        </div>
                      </td>
                      ${
                        file.winner
                          ? `<td class="border px-4 py-2"><strong>Vencedor:</strong> ${file.winner}</td>`
                          : ""
                      }
                    </tr>
                  </tbody>
                </table>
              </div>
            `;
            this.filesListTarget.appendChild(fileItem);
          });
        });
    } else {
      this.filesListTarget.innerHTML = "";
    }
  }

  getSpecificDateRow(file) {
    if (file.judgment) {
      return `<td class="border px-4 py-2"><strong>Data de Julgamento:</strong> ${file.judgment}</td>`;

    } else if (file.date_result) {
      return `<td class="border px-4 py-2"><strong>Data de Adjudicação:</strong> ${file.date_result}</td>`;

    } else if (file.publish_date) {
      return `<td class="border px-4 py-2"><strong>Data de Abertura:</strong> ${file.publish_date}</td>`;

    } else if (file.date_publish) {
      return `<td class="border px-4 py-2"><strong>Data de Publicação:</strong> ${file.date_publish}</td>`;

    }
    return "";
  }

  yearChanged() {
    this.loadMonths();
    this.filesListTarget.innerHTML = "";
  }

  monthChanged() {
    this.loadFiles();
  }
}
