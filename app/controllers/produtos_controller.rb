class ProdutosController < ApplicationController
  def index
    #@ para definir que a variavel é da instancia do controller.
    @produtos = Produto.order :nome
  end
end
