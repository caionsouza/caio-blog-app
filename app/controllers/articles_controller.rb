class ArticlesController < ApplicationController
  before_action :user_is_member?, only: %i[new create update destroy]
  before_action :set_article, only: %i[show edit update destroy]
  before_action :categories_ids, only: %i[create update]
  before_action :same_user, only: %i[edit update destroy]

  def index
    @articles = Article.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = current_user.articles.build(article_params)
    Article.add_categories(@article, categories_ids) if categories_ids.present?

    if @article.save
      redirect_to articles_path, notice: 'Article was created'
    else
      render :new, status: :unprocessable_entity
    end 
  end
  
  def update
    Article.update_categories(@article, categories_ids) if categories_ids.present?

    if @article.update(article_params)
      redirect_to article_path(@article), notice: 'Article was updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @article.destroy
      redirect_to articles_path, notice: 'Article was removed'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(
      :article
    ).permit(
      :name, 
      :description,
      :avatar,
      :body
    )
  end

  def categories_ids
    params[:categories][:ids].reject {|id| id.empty?}
  end

  def same_user
    redirect_to articles_path if @article.user != current_user && !current_user.profile.superadmin?
  end
end
