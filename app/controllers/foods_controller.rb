class FoodsController < ApplicationController

  def index
    #foods = Food.all

    @foods = Food.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)

    # -- para o sort_by, funciona mas causa problemas
    #sort_param = params[:sort_by]
    #foods = sort_by(@sort_param).paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @food = Food.new

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @food }
  end


  def create
    @food = Food.create(food_params)

    if @food.save
      redirect_to @food
    else
      render 'new'
    end
  end

  def show
    @food = Food.find_by(id: params[:id])
  end

  def edit
    @food = Food.find_by(id: params[:id])
  end

  def update
    @food = Food.find_by(id: params[:id])
    if @food.update(food_params)
      redirect_to @food
    else
      render 'edit'
    end
  end

  def sort_by_cal_ASC
    @foods_param = Food.sort_by_cal_ASC.page(params[:page])
    render 'index'
  end

  def sort_by_cal_DESC
    @foods_param = Food.sort_by_cal_DESC.page(params[:page])
    render 'index'
  end

  def destroy
    Food.find(params[:id]).destroy
    flash[:success] = "Food Deleted!"
    redirect_to foods_url
  end

end

private

  def food_params
    params.require(:food).permit(:name, :calories)
  end

  def sort_by(sort_param)
    food = Food.all
    if sort_param === "name ASC"
      food.order(name: :asc).page(params[:page])
    elsif sort_param === "name DESC"
      food.order(name: :desc).page(params[:page])
    elsif sort_param === "calories ASC"
      food.sort_by_cal_ASC.page(params[:page])
    elsif sort_param === "calories DESC"
      food.sort_by_cal_DESC.page(params[:page])
    end
  end

end


