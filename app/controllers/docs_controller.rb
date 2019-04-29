class DocsController < ApplicationController
  before_action :find_doc, only: [:show, :edit, :update, :destroy] #this runs before other methods

  def index #this is for index view, @docs = Doc.all.order("created_at DESC") ,order it in the time and day they were created,newest docs at the top and oldest at the bottom
    @docs = Doc.where(user_id: current_user) #now docs are visible to only user who created them
  end

  def show #this will be for show view
    #@doc = Doc.find(params[:id]) #to avoid repeatation later we put it in the private section so that we can access it anytime
  end

  def new #this is for new view
    @doc = current_user.docs.build
   #only current user can create docs
  end

  def create #for creating something we need the create method, it doesn't have the view itself
    @doc = current_user.docs.build(doc_params) #we are creating this component
    #to  redirect to document itself
    if @doc.save
      redirect_to @doc #this would be new http refresh and lose all the content
    else
      render "new" #render doenot refresh the page
    end
  end

  def edit #just responsible for the view file
  end

  def update #the same applies to the update as create, it just make changes to the database, using the edit voiew
    if @doc.update(doc_params)
      redirect_to @doc
    else
      render "edit"
    end
  end

  def destroy #deleting the docs we create
    @doc.destroy
    redirect_to docs_path
  end

  private #this applies to the controller to this page, it helps us with reducing redandency,

    def find_doc
        @doc = Doc.find(params[:id])
    end

    def doc_params
      params.require(:doc).permit(:title, :content)
    end


end
