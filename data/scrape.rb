#!/usr/bin/env ruby

require 'json'
require 'yaml'
require 'open-uri'

class String
  def parameterize
    self.downcase.tr("áéíóúñü", "aeiounu").gsub(/[^a-z0-9]/, "-").gsub(/\-+/, "-").gsub(/^\-/, "").gsub(/\-$/, "")
  end
end

categories = JSON.parse open("http://ceramicapadilla.herokuapp.com/es/catalogo.json").read

categories.each do |category|
  category["products"] = JSON.parse open("http://ceramicapadilla.herokuapp.com/es/catalogo/#{category["id"]}/productos.json").read
end

puts(categories.map do |category|
  {
    "id" => category["id"],
    "slug" => category["es_name"].parameterize,
    "name" => category["es_name"],
    "description" => category["es_description"],
    "products" => category["products"].map do |product|
      {
        "id" => product["id"],
        "slug" => product["es_name"].parameterize,
        "name" => product["es_name"],
        "description" => product["es_description"],
        "new_arrival" => product["new_arrival"]
      }
    end
  }
end.to_yaml)
