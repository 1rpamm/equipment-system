# -*- encoding : utf-8 -*-
module EquipmentHelper
  def short(pdf)
    label = pdf.split("\/").last
    if label.size > 15
      label = label[0..6]+"..."+label[-7..-1]
    end
    return label
  end
end
