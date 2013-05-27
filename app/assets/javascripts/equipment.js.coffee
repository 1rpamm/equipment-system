# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

tokenInputOptions = {crossDomain: false, hintText: "Введите название", noResultText: "Ничего не найдено", searchingText: "Поиск", preventDuplicates: true}
tokenInputOptions2 = {propertyToSearch: "act_num", crossDomain: false, hintText: "Введите название", noResultText: "Ничего не найдено", searchingText: "Поиск", preventDuplicates: true}
tokenInputOptions3 = {propertyToSearch: "serial", crossDomain: false, hintText: "Введите название", noResultText: "Ничего не найдено", searchingText: "Поиск", preventDuplicates: true}
$ ->
  $("input#equipment_room_id").tokenInput(window.rooms_path,$.extend({},tokenInputOptions,{tokenLimit: 1, prePopulate: $(this).attr('data-pre')}))
  $("input#equipment_inventory_id").tokenInput(window.inventories_path,$.extend({},tokenInputOptions2,{tokenLimit: 1, prePopulate: $(this).attr('data-pre')}))
  $("input#equipment_responsible_id").tokenInput(window.users_path,$.extend({},tokenInputOptions,{tokenLimit: 1,prePopulate: $(this).attr('data-pre')}))
  $("input#equipment_detail_tokens").tokenInput("/details.json",$.extend({},tokenInputOptions3,{prePopulate: $(this).attr('data-pre')}))