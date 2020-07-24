class PowerGeneratorsController < ApplicationController
  def index
    sort_by = "price, "
    if params["sortRadio"] != ""
      if params["sortRadio"] == "sortKWP"
        sort_by = "kwp, "  
      end
    end
    sort_by += " name"

    if params[:keywords].present?
      # Diz ao elastickick para pesquisar as keyrwords nos campos name e description
      @power_generators = PowerGenerator.search params[:keywords], fields: [:name, :description, :manufacturer, :kwp]
    end

    @power_generators = PowerGenerator.order(sort_by).paginate(page: params[:page], per_page: 6)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @power_generator = PowerGenerator.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end  

end
