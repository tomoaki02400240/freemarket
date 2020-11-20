module MarketsHelper
  def button_change(btnchange="")
    btnbase = "購入する"
    if btnchange.empty?
      btnbase
    else
      btnchange
    end
  end
  
end
