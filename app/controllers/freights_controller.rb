require 'open-uri'

class FreightsController < ApplicationController
    def index
        freight_cost = params[:freight_cost]
        
        power_generator = PowerGenerator.find(freight_cost[:power_generator_id].to_i)
    
        
        url = "https://viacep.com.br/ws/#{freight_cost[:zip_code]}/json/"
        response = open(url).read
        
        # calcula a regra do peso mais leve
        freight_weight = power_generator.weight 
        if power_generator.cubage < power_generator.weight 
            freight_weight = power_generator.cubage 
        end

        address = JSON.parse(response)

        @uf = !address['erro'] ? address['uf'] : ''

        @freights = Freight.where("state = '#{@uf}' AND weight_min <= #{freight_weight} AND weight_max >= #{freight_weight}")
        
        respond_to do |format|
            format.js
        end
   end
end