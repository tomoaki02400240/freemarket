module Users::ProductsHelper
  def image_url1(product)
    if product.image1.nil?
      "https://dummyimage.com/200x200/000/fff"
    else
      "/images/#{product.image1}"
    end
  end
  
  def image_url2(product)
    if product.image2.nil?
      "https://dummyimage.com/200x200/000/fff"
    else
      "/images/#{product.image2}"
    end
  end
  
  def image_url3(product)
    if product.image3.nil?
      "https://dummyimage.com/200x200/000/fff"
    else
      "/images/#{product.image3}"
    end
  end
end
