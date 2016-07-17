class ProdutosController < ApplicationController
  def index
    #@ para definir que a variavel é da instancia do controller.
    @produtos = Produto.order :nome
  end

  #Antes estava implicito, agora vai criar um produdo em branco para o formulario poder renderizar
  def new
    @produto = Produto.new
  end

  def destroy
    id = params[:id]
    Produto.destroy id
    redirect_to root_url
  end

  def create
    valores = params.require(:produto)
                  .permit(:nome, :descricao, :quantidade, :preco)
    #produto = Produto.create valores
    @produto = Produto.new valores

    #para tratar validações vamos fazer um save ao invez de create
    if @produto.save
      #variaveis de @Instancia duram um request
      #usando o flash[] (hash) a informação dura uma a mais
      flash[:notice] = "Produto salvo com sucesso!"
      redirect_to root_url
    else
      #renderiza o layout new.html.erb
      render :new
    end

  end

  def busca
    @nome_a_buscar = params[:nome]
    #@produtos = Produto.where nome: @nome_a_buscar -> NOME EXATO
    #@produtos = Produto.where "nome like %#{@nome_a_buscar}%" -> RISCO DE SQL INJECTION
    @produtos = Produto.where "nome like ?", "%#{@nome_a_buscar}%" #-> FORMA SEGURA
  end
end
