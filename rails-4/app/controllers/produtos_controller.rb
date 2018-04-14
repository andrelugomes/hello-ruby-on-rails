class ProdutosController < ApplicationController

  #Filtros que iram executar métodos antes de um metodo (Como Aspecto)
  before_action :set_produto, only: [:edit, :update, :destroy]

  def index
    #@ para definir que a variavel é da instancia do controller.
    @produtos = Produto.order :nome
  end

  #Antes estava implicito, agora vai criar um produdo em branco para o formulario poder renderizar
  def new
    @produto = Produto.new
    #@departamentos = Departamento.all

    renderiza :new
  end

  def destroy
    #id = params[:id]
    #Produto.destroy id

    set_produto
    @produto.destroy
    redirect_to root_url
  end

  def create
    #.permit para não deixar tudo ser atualizado... e evitar falha de segurança
    #valores = params.require(:produto).permit(:nome, :descricao, :quantidade, :preco,:departamento_id)
    #produto = Produto.create valores
    @produto = Produto.new produto_params

    #para tratar validações vamos fazer um save ao invez de create
    if @produto.save
      #variaveis de @Instancia duram um request
      #usando o flash[] (hash) a informação dura uma a mais
      flash[:notice] = "Produto salvo com sucesso!"
      redirect_to root_url
    else
      #renderiza o layout new.html.erb
      renderiza :new
    end

  end

  def edit
    #id = params[:id]    #busca o parâmetro "id"
    #@produto = Produto.find(id)    #procura o produto
    #render :new    #queremos renderizar a view do "new", pois é no formulário que faremos as modificações

    set_produto
    renderiza :edit
  end

  def update
    #id = params[:id]    #busca o parâmetro pelo id
    #@produto = Produto.find(id)    #busca o produto pelo id
    #valores = params.require(:produto).permit :nome, :preco, :descricao, :quantidade, :departamento_id    #igual ao método create
    if @produto.update produto_params    #observa cada valor e os atualiza
    flash[:notice] = "Produto atualizado com sucesso"    #dando certo, aparece a mensagem
        redirect_to root_url    #volta para a página inicial
    else
      render :new
    end
  end

  def busca
    @nome_a_buscar = params[:nome]
    #@produtos = Produto.where nome: @nome_a_buscar -> NOME EXATO
    #@produtos = Produto.where "nome like %#{@nome_a_buscar}%" -> RISCO DE SQL INJECTION
    @produtos = Produto.where "nome like ?", "%#{@nome_a_buscar}%" #-> FORMA SEGURA
  end

  private

  def renderiza view
    @departamentos = Departamento.all
    render view
  end

  def set_produto
    id = params[:id]
    @produto = Produto.find(id)
  end

  def produto_params
    params.require(:produto).permit :nome, :preco, :descricao, :quantidade, :departamento_id
  end
end
