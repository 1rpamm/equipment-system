# -*- encoding : utf-8 -*-
module ApplicationHelper
  def admin_user?
    logged_in? && current_user.admin_user?
  end

  def admin_inv?
    logged_in? && current_user.admin_inv?
  end

  def admin_equip?
    logged_in? && current_user.admin_equip?
  end

  def responsible?
    logged_in? && current_user.responsible?
  end

  def menu_items
    [{name: "equipment", title: "Оборудование", admin: "public"}, {name: "users", title: "Пользователи", admin: "admin_user"},
     {name: "rooms", title: "Кабинеты", admin: "admin_equip"}, {name: "act_types", title: "Типы документов", admin: "admin_inv"},
     {name: "inventories", title: "Инвентарь", admin: "admin_inv"}, {name: "details", title: "Детали", admin: "admin_equip"}]
  end

  def link_to_icon(icon, text, *args)
    link_to(content_tag(:i, nil, :class => icon)+text, *args)
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).class.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
