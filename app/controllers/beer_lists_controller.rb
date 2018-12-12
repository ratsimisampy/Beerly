class BeerListsController < ApplicationController

  before_action :manager_can_only_edit_their_beerlists, only: [:edit]

  def new 
    @beerlist = BeerList.new 
  end 

  def index
    @bar = Bar.find(current_manager.bar.id)
    @draft_beers = @bar.beer_lists.draft.up
    @bottle_beers = @bar.beer_lists.bottle.up
    @beers = Beer.search(params[:term])
    @beerlist = BeerList.new
    @draft_archived_beers = @bar.beer_lists.draft.archived
    @bottle_archived_beers = @bar.beer_lists.bottle.archived
  end

  def create
    if no_blank_price
      @beerlist = current_manager.bar.beer_lists.create(beerlist_params)    
      redirect_to managers_beer_lists_path
    else
      redirect_to managers_beer_lists_path, alert: "Attention: vous avez oublié un prix!"
    end 
  end

  def edit
    @beerlist = BeerList.find(params[:id]) 
  end

  def update
    @beerlist = BeerList.find(params[:id]) 
    if no_blank_price
      @beerlist.update(beerlist_params)
      redirect_to managers_beer_lists_path
    else 
      redirect_to edit_managers_beer_list_path(@beerlist.id), alert: "Attention: vous avez oublié un prix!"
    end 
  end

  def destroy
    @beerlist = BeerList.find(params[:id])
    @beerlist.destroy
    redirect_to managers_beer_lists_path
  end

  def archive
    @beerlist = BeerList.find(params[:id]) 
    if @beerlist.is_archived?
      @beerlist.update_attributes(is_archived: false)
      redirect_to managers_beer_lists_path
    else
      @beerlist.update_attributes(is_archived: true)
      redirect_to managers_beer_lists_path
    end 
  end 

  private 
    def beerlist_params
      params.require(:beer_list).permit(:beer_id, :pint_price, :half_pint_price, :bottle_price)
    end 

    def manager_can_only_edit_their_beerlists 
      unless current_manager.bar.id =  BeerList.find(params[:id].to_i).manager.id
        redirect_to managers_beer_lists_path, alert: "Vous ne pouvez pas modifier cette bière"
      end 
    end 

    def no_blank_price
     (!(params[:beer_list][:pint_price].blank?) && !(params[:beer_list][:half_pint_price].blank?)) || !(params[:beer_list][:bottle_price].blank?)
    end 
    
end
