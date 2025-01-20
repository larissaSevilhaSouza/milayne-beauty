//= require rails_admin/custom/ckeditor.js
//= require rails_admin/custom/classic_editor.js
//= require rails_admin/custom/masks.js



$(document).on("rails_admin.dom_ready", function () {
  var $sidebar = $(".sidebar");

  // Fecha todas as pastas ao carregar o Rails Admin dentro da sidebar
  $sidebar.find(".collapse").removeClass("show");
  $sidebar
    .find(".fas")
    .addClass("fa-chevron-right")
    .removeClass("fa-chevron-down");

  $sidebar.find(".btn-toggle").each(function () {
    // Definindo o estado inicial como fechado (collapsed)
    $(this).attr("aria-expanded", "false");
    $(this).removeClass("active").addClass("collapsed");
  });

  // Verifica se algum elemento possui a classe "nav-link active" dentro da sidebar
  var activeNav = $sidebar.find(".nav-link.active").closest(".collapse");
  if (activeNav.length > 0) {
    // Mantém o elemento com a classe "nav-link active" aberto
    activeNav.addClass("show");
    activeNav
      .prev(".btn-toggle")
      .attr("aria-expanded", "true")
      .removeClass("collapsed")
      .addClass("active");
    // Atualiza o ícone do botão ativo
    activeNav
      .prev(".btn-toggle")
      .find(".fas")
      .removeClass("fa-chevron-right")
      .addClass("fa-chevron-down");
  }

  // Adiciona evento de clique para os elementos .btn-toggle dentro da sidebar
  $sidebar.on("click", ".btn-toggle", function () {
    var $this = $(this);
    var targetCollapse = $this.next(".collapse");

    if (!targetCollapse.hasClass("show")) {
      // Fecha todas as pastas que não são o alvo do clique dentro da sidebar
      $sidebar.find(".collapse.show").removeClass("show");
      $sidebar
        .find(".btn-toggle.active")
        .attr("aria-expanded", "false")
        .removeClass("active")
        .addClass("collapsed");
      $sidebar
        .find(".btn-toggle .fas")
        .addClass("fa-chevron-right")
        .removeClass("fa-chevron-down");

      // Abre a pasta correspondente ao elemento clicado
      targetCollapse.addClass("show");
      $this
        .attr("aria-expanded", "true")
        .removeClass("collapsed")
        .addClass("active");
      // Atualiza o ícone do botão clicado para "fa-chevron-down"
      $this
        .find(".fas")
        .removeClass("fa-chevron-right")
        .addClass("fa-chevron-down");
    } else {
      // Fecha a pasta se ela já estiver aberta
      targetCollapse.removeClass("show");
      $this
        .attr("aria-expanded", "false")
        .removeClass("active")
        .addClass("collapsed");
      // Atualiza o ícone do botão clicado para "fa-chevron-right"
      $this
        .find(".fas")
        .removeClass("fa-chevron-down")
        .addClass("fa-chevron-right");
    }
  });
});
$(document).on("rails_admin.dom_ready", function () {
  var activeLinkField = $('input[name="menu[active_link]"][value="1"]');
  var activeSubMenuField = $('input[name="menu[active_sub_menu]"][value="1"]');
  var linkField = $("#menu_link_field");
  var subMenuField = $("#menu_sub_menus_attributes_field");

  function toggleFields() {
    if (activeLinkField.is(":checked")) {
      linkField.show();
      subMenuField.hide();
    } else if (activeSubMenuField.is(":checked")) {
      linkField.hide();
      subMenuField.show();
    } else {
      linkField.hide();
      subMenuField.hide();
    }
  }

  $(
    'input[name="menu[active_link]"], input[name="menu[active_sub_menu]"]'
  ).change(toggleFields);

  toggleFields();
});


//script para aba do menu header
$(document).on("rails_admin.dom_ready", function () {
  // dimenção photo page admin
  $('#page_photo_field img').css({
    'width': '380px',
    'height': '380px',
    'object-fit': 'cover'
  }).show();

  // dimenção photo secretaria admin
  $('#secretary_photo_field .img-thumbnail').css({
    'width': '380px',
    'height': '380px',
    'object-fit': 'cover'
  }).show();

  //campo button submenu fechado
  $('#menu_active_sub_menu_field').hide();
  //campo button menu ativo fechado
  $('#menu_active_field').hide();
  //campo button submenu fechado
  $('#menu_sub_menus_attributes_0_new_page_field').hide();

  // Mudar texto da label
  // $('#menu_active_link').next('label').text('Url (Link)');

  // Mudar texto da label
  $('#menu_active_link_1').next('label').text('Menu único');
  $('#menu_active_link_0').next('label').text('Submenu');
  $('#menu_active_link_').next('label').text('Menu desativado');

  // Mudar cor do button
  $('[for="menu_active_link_0"]').removeClass('danger btn btn-outline-danger').addClass('primary btn btn-outline-primary');
  $('[for="menu_active_link_"]').removeClass('default btn btn-outline-secondary').addClass('danger btn btn-outline-danger');
  
  //quando menu link estiver com neutro ativo
  $('#menu_active_link_').on('change', function() {
    if ($(this).prop('checked')) {

      //campo button submenu fechado
      $('#menu_sub_menus_attributes_field').hide();
      //neutro do submenu ativo
      $('#menu_active_sub_menu_').prop('checked', true);
      //neutro do link ativo
      $('#menu_active_').prop('checked', true);
      //campo input link único
      $('#menu_link_field').hide();

    }
  });

  //quando menu link estiver com closed ativo
  $('#menu_active_link_0').on('change', function() {
    if ($(this).prop('checked')) {

      //campo button submenu aberto
      $('#menu_sub_menus_attributes_field').show();
      //ok do submenu ativo
      $('#menu_active_sub_menu_1').prop('checked', true);
      //ok do link ativo
      $('#menu_active_1').prop('checked', true);
      //campo input link único
      $('#menu_link_field').hide();

    }
  });

  //quando menu link estiver com ok ativo
  $('#menu_active_link_1').on('change', function() {
    if ($(this).prop('checked')) {

      //campo button submenu fechado
      $('#menu_link_field').hide();
      //closed do submenu ativo
      $('#menu_active_sub_menu_0').prop('checked', true);
      //ok do link ativo
      $('#menu_active_1').prop('checked', true);
      //campo input link único
      $('#menu_link_field').show();

    }
  });

  $('#banner_format_ad_id_field').hide();
  $('#quick_access_category_quick_access_id_field').show();


  //select colab prefeitura
  var bannerCategoryTypesSelect = $('#banner_category');
  var bannerFormatField = $('#banner_format_ad_id_field');
  var bannerTitleField = $('#banner_title_field');
  var bannerSubtitleField = $('#banner_subtitle_field');
  var bannerPhotoField = $('#banner_photo_field');
  var bannerVideoField = $('#banner_video_field');
  var bannerLinkField = $('#banner_link_field');


  bannerCategoryTypesSelect.on('change', function() {
    if ($(this).val() === '1') {
      bannerFormatField.hide();
      bannerTitleField.show();
      bannerSubtitleField.show();
      bannerPhotoField.hide();
      bannerVideoField.show();
      bannerLinkField.hide();
    } else if ($(this).val() === '0') {
      bannerFormatField.show();
      bannerTitleField.show();
      bannerSubtitleField.show();
      bannerPhotoField.show();
      bannerVideoField.hide();
      bannerLinkField.show();
    } else {
      bannerFormatField.hide();
      bannerTitleField.hide();
      bannerSubtitleField.hide();
      bannerPhotoField.hide();
      bannerVideoField.hide();
      bannerLinkField.hide();

    }
  });

  // Check initial state
  if (bannerCategoryTypesSelect.val() === '1') {
    bannerFormatField.hide();
    bannerTitleField.show();
    bannerSubtitleField.show();
    bannerPhotoField.hide();
    bannerVideoField.show();
    bannerLinkField.hide();
  } else if (bannerCategoryTypesSelect.val() === '0') {
    bannerFormatField.show();
    bannerTitleField.show();
    bannerSubtitleField.show();
    bannerPhotoField.show();
    bannerVideoField.hide();
    bannerLinkField.show();
  } else {
    bannerFormatField.hide();
    bannerTitleField.hide();
    bannerSubtitleField.hide();
    bannerPhotoField.hide();
    bannerVideoField.hide();
    bannerLinkField.hide();

  }

  const radioButtonGroup = $('#menu_sub_menus_attributes_field.boolean_type.btn-group');
  radioButtonGroup.find('input[type="radio"]').on('click', function() {
    $(this).trigger('click');
  });

  const label = $('label[for="menu_sub_menus_attributes_1719259096296_new_page_1"]');
const input = $('#' + label.attr('for'));

console.log(input.is(':checked')); // deve imprimir true se o input estiver checked


const labels = $('label.success'); // selecione todas as labels com a classe "success"
const inputs = labels.map(function() {
  return $('#' + $(this).attr('for'));
});
  
});


// $(document).on("rails_admin.dom_ready", function() {
//   $('#menu_sub_menus_attributes_field.btn-group input[type="radio"][checked]').each(function() {
//     $(this).on('click', function() {
//       $(this).siblings('input[type="radio"]').prop('checked', false);
//     });
//   });
// });


