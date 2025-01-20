module AccessibilityHelper
  def high_contrast?
    request.session[:high_contrast] == true
  end
end