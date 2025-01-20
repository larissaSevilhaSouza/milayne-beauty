$(document).on('rails_admin.dom_ready', function () {
  const elements = document.querySelectorAll('[data-ckeditor]');
  let formSubmitted = false;
  let urlCounts = {};
  let imageUrls = [];

  if (elements.length > 0) {
    const url = window.location.pathname.split('/');
    const model = url[2]
    const model_id = url[3]

    elements.forEach(element => {
      ClassicEditor.create(element, {
        simpleUpload: {
          uploadUrl: `/post_images/upload/${model}/${model_id}`,
          headers: {
            'X-CSRF-TOKEN': Rails.csrfToken()
          }
        },
        heading: {
          options: [
            { model: 'paragraph', title: 'Parágrafo', class: 'ck-heading_paragraph' },
            { model: 'heading4', view: 'h4', title: 'Título', class: 'ck-heading_heading3' }
          ]
        },
        language: {
          textPartLanguage: [
            { title: 'Português', languageCode: 'pt-br' },
          ]
        }
      }).then(editor => {
        editor.model.document.on('change:data', () => {
          const differ = editor.model.document.differ;
          const changes = differ.getChanges();

          for (const entry of changes) {
            if (entry.type === 'attribute' && entry.attributeKey === "src") {
              imageUrls.push(entry.attributeNewValue);
            }

            if ((entry.type === 'remove' || entry.type === 'insert') &&
              (entry.name === "imageBlock" || entry.name === "imageInline") &&
              entry.attributes.has('src')) {
              const src = entry.attributes.get('src');

              if (!urlCounts[src]) {
                urlCounts[src] = { insertions: 0, removals: 0 };
              }

              if (entry.type === 'remove') {
                urlCounts[src].removals++;
              } else {
                urlCounts[src].insertions++;
              }
            }
          }
        });

      }).catch(error => {
        console.error(error);
      });
    });
  }

  // Evento beforeunload não ser ativado se for um envio de form
  let form = $('#edit_post');
  if (form.length === 0) {
    form = $('#edit_page');
  }

  form.on('submit', function (event) {
    event.preventDefault();

    for (const url in urlCounts) {
      const count = urlCounts[url];
      if (count.removals > count.insertions) {
        deleteImage(url);
      }
    }

    formSubmitted = true;
    form[0].submit();
  });

  // Deleta as imagens colocadas se atualizar a página
  $(window).on('beforeunload', handleImageDeletion);

  // Deleta as imagens colocadas se trocar a página pelo sidebar
  $(document).on('turbo:before-fetch-request', handleImageDeletion);

  // Lida com a remoção das imagens se atualizar ou trocar de página pelo sidebar
  function handleImageDeletion() {
    if (!formSubmitted && imageUrls.length > 0) {
      for (const url of imageUrls) {
        if (!urlCounts[url] || urlCounts[url].removals > urlCounts[url].insertions) {
          deleteImage(url);
        }
      }
    }
    imageUrls = [];
  }

  // Função para deletar imagem
  async function deleteImage(url) {
    const post_image_id = url.match(/url\/(\d+)\//)[1];
    console.log(post_image_id);
    const deleteUrl = '/post_images/delete/' + post_image_id;

    let numAttempts = 0;

    while (numAttempts < 3) {
      try {
        const response = await fetch(deleteUrl, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': Rails.csrfToken()
          }
        });

        if (response.ok) {
          console.log('Imagem deletada com sucesso');
          break;
        } else {
          console.error('Erro ao deletar imagem. Tentando novamente...');
        }
      } catch (error) {
        console.error('Erro ao deletar imagem. Tentando novamente...', error);
      }

      numAttempts++;
      await new Promise(resolve => setTimeout(resolve, 1000));
    }

    if (numAttempts === 3) {
      console.error('Excedeu o número máximo de tentativas. A exclusão da imagem falhou.');
    }
  }
});
