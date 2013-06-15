# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

tokenInputOptions = {crossDomain: false, hintText: "Введите название", noResultText: "Ничего не найдено", searchingText: "Поиск", preventDuplicates: true}

$ ->
  $("input#detail_vendor_id").tokenInput(window.vendors_path,$.extend({},tokenInputOptions,{tokenLimit: 1, prePopulate: $(this).attr('data-pre')}))
  $("input#detail_device_id").tokenInput(window.devices_path,$.extend({},tokenInputOptions,{tokenLimit: 1, prePopulate: $(this).attr('data-pre')}))
  $("input#detail_subsystem_id").tokenInput(window.subsystems_path,$.extend({},tokenInputOptions,{tokenLimit: 1, prePopulate: $(this).attr('data-pre')}))