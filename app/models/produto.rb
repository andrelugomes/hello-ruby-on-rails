class Produto < ActiveRecord::Base

  #Faz o relacionamento de Produto com Departamento
  belongs_to :departamento

  #validates :quantidade, {"presence" => true}
  #validates :quantidade, {presence: true}
  validates :quantidade, presence: true
  validates :nome, length: { minimum: 5 }
end
